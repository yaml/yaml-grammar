###
# This is a parser class. It has a parse() method and parsing primitives for
# the grammar. It calls methods in the receiver class, when a rule matches:
###

use v5.12;

package Parser;

use Prelude;
use Grammar;

use base 'Grammar';

use constant TRACE => $ENV{TRACE};

sub new {
  my ($class, $receiver) = @_;

  bless {
    receiver => $receiver,
    pos => 0,
    end => 0,
    state => [],
    trace_num => 1,
    trace_on => true,
    trace_off => 0,
    trace_info => ['', '', ''],
  }, $class;
}

sub parse {
  my ($self, $input) = @_;
  $self->{input} = $input;

  $self->{end} = length $self->{input};

  $self->{trace_on} = not $self->trace_start if TRACE;

  my $ok;
  eval {
    $ok = $self->call($self->func('TOP'));
    $self->trace_flush;
  };
  if ($@) {
    $self->trace_flush;
    die $@;
  }

  die "Parser failed" if not $ok;
  die "Parser finished before end of input"
    if $self->{pos} < $self->{end};

  return true;
}

sub state_curr {
  my ($self) = @_;
  $self->{state}[-1] || {
    name => undef,
    lvl => 0,
    beg => 0,
    end => 0,
    ind => -1,
    m => undef,
    t => undef,
  };
}

sub state_prev {
  my ($self) = @_;
  $self->{state}[-2]
}

sub state_push {
  my ($self, $name) = @_;

  my $prev = $self->state_curr;

  push @{$self->{state}}, {
    name => $name,
    lvl => $prev->{lvl} + 1,
    beg => $self->{pos},
    end => undef,
    ind => $prev->{ind},
    m => $prev->{m},
    t => $prev->{t},
  };
}

sub state_pop {
  my ($self) = @_;
  my $curr = pop @{$self->{state}};
  my $prev = $self->state_prev;
  return unless defined $prev;
  $prev->{beg} = $curr->{beg};
  $prev->{end} = $self->{pos};
}

sub call {
  my ($self, $func, $type) = @_;
  $type //= 'boolean';

  my $args = [];
  ($func, @$args) = @$func if isArray $func;

  return $func if isNumber $func;

  xxxxx "Bad call type '${\ typeof $func}' for '$func'"
    unless isFunction $func;

  $func->{trace} //= $func->{name};

  $self->state_push($func->{trace});

  $self->trace('?', $func->{trace}, $args) if TRACE;

  @$args = map {
    isArray($_) ? $self->call($_, 'any') :
    isFunction($_) ? $_->{func}->() :
    $_;
  } @$args;

  my $pos = $self->{pos};
  $self->receive($func, 'try', $pos);

  my $value = $func->{func}->($self, @$args);
  while (isFunction($value) or isArray($value)) {
    $value = $self->call($value);
  }

  xxxxx "Calling '$func->{trace}' returned '${\ typeof($value)}' instead of '$type'"
    if $type ne 'any' and typeof($value) ne $type;

  if ($type ne 'boolean') {
    $self->trace('>', $value) if TRACE;
  }
  else {
    if ($value) {
      $self->trace('+', $func->{trace}) if TRACE;
      $self->receive($func, 'got', $pos);
    }
    else {
      $self->trace('x', $func->{trace}) if TRACE;
      $self->receive($func, 'not', $pos);
    }
  }

  $self->state_pop;
  return $value;
}

sub receive {
  my ($self, $func, $type, $pos) = @_;

  $func->{receivers} //= $self->make_receivers;
  my $receiver = $func->{receivers}{$type};
  return unless $receiver;

  $receiver->($self->{receiver}, {
    text => substr($self->{input}, $pos, $self->{pos}-$pos),
    state => $self->state_curr,
    start => $pos,
  });
}

sub make_receivers {
  my ($self) = @_;
  my $i = @{$self->{state}};
  my $names = [];
  my $n;
  while ($i > 0 and not(($n = $self->{state}[--$i]{name}) =~ /_/)) {
    if ($n =~ /^chr\((.)\)$/) {
      $n = hex_char $1;
    }
    unshift @$names, $n;
  }
  my $name = join '__', $n, @$names;

  return {
    try => $self->{receiver}->can("try__$name"),
    got => $self->{receiver}->can("got__$name"),
    not => $self->{receiver}->can("not__$name"),
  };
}

# Match all subrule methods:
sub all {
  my ($self, @funcs) = @_;
  name all => sub {
    my $pos = $self->{pos};
    for my $func (@funcs) {
      xxxxx '*** Missing function in @all group:', \@funcs
        unless defined $func;

      if (not $self->call($func)) {
        $self->{pos} = $pos;
        return false;
      }
    }

    return true;
  };
}

# Match any subrule method. Rules are tried in order and stops on first match:
sub any {
  my ($self, @funcs) = @_;
  name any => sub {
    for my $func (@funcs) {
      if ($self->call($func)) {
        return true;
      }
    }

    return false;
  };
}

sub may {
  my ($self, $func) = @_;
  name may => sub {
    $self->call($func);
  };
}

# Repeat a rule a certain number of times:
sub rep {
  my ($self, $min, $max, $func) = @_;
  name rep => sub {
    my $count = 0;
    my $pos = $self->{pos};
    my $pos_start = $pos;
    while (
      ($max == -1 or $count < $max) and
      $self->{pos} < $self->{end}
    ) {
      last unless $self->call($func);
      last if $self->{pos} == $pos;
      $count++;
      $pos = $self->{pos};
    }
    if ($count >= $min and ($max == -1 or $count <= $max)) {
      return true;
    }
    $self->{pos} = $pos_start;
    return false;
  }, "rep($min,$max)";
}

# Call a rule depending on state value:
sub case {
  my ($self, $var, $map) = @_;
  name case => sub {
    my $rule = $map->{$var} or
      xxxxx "Can't find '$var' in:", $map;
    $self->call($rule);
  }, "case($var,${\ stringify $map})";
}

# Call a rule depending on state value:
sub flip {
  my ($self, $var, $map) = @_;
  my $value = $map->{$var} or
    xxxxx "Can't find '$var' in:", $map;
  return $value if not ref $value;
  return $self->call($value, 'number');
}
name flip => \&flip;

# Match a single char:
sub chr {
  my ($self, $char) = @_;
  name chr => sub {
    if ($self->{pos} >= $self->{end}) {
      return false;
    }
    if (substr($self->{input}, $self->{pos}, 1) eq $char) {
      $self->{pos}++;
      return true;
    }
    return false;
  }, "chr(${\ stringify($char)})";
}

# Match a char in a range:
sub rng {
  my ($self, $low, $high) = @_;
  name rng => sub {
    if ($self->{pos} >= $self->{end}) {
      return false;
    }
    if (
      $low le substr($self->{input}, $self->{pos}, 1) and
      substr($self->{input}, $self->{pos}, 1) le $high
    ) {
      $self->{pos}++;
      return true;
    }
    return false;
  }, "rng(${\ stringify($low)},${\ stringify($high)})";
}

# Must match first rule but none of others:
sub but {
  my ($self, @funcs) = @_;
  name but => sub {
    my $pos1 = $self->{pos};
    return false unless $self->call($funcs[0]);
    my $pos2 = $self->{pos};
    $self->{pos} = $pos1;
    for my $func (@funcs[1..$#funcs]) {
      if ($self->call($func)) {
        $self->{pos} = $pos1;
        return false;
      }
    }
    $self->{pos} = $pos2;
    return true;
  }
}

sub chk {
  my ($self, $type, $expr) = @_;
  name chk => sub {
    my $pos = $self->{pos};
    $self->{pos}-- if $type eq '<=';
    my $ok = $self->call($expr);
    $self->{pos} = $pos;
    return $type eq '!' ? not($ok) : $ok;
  }, "chk($type, ${\ stringify $expr})";
}

sub set {
  my ($self, $var, $expr) = @_;
  name set => sub {
    my $value = $self->call($expr, 'any');
    $self->state_curr->{$var} = $value;
    return true;
  }, "set('$var', ${\ stringify $expr})";
}

sub max {
  my ($self, $max) = @_;
  name max => sub {
    return true;
  };
}

sub exclude {
  my ($self, $rule) = @_;
  name exclude => sub {
    return true;
  };
}

sub add {
  my ($self, $x, $y) = @_;
  name add => sub {
    $y = $self->call($y, 'number') if isFunction $y;
    return $x + $y;
  }, "add($x,$y)";
}

sub sub {
  my ($self, $x, $y) = @_;
  name sub => sub {
    return $x - $y;
  }, "sub($x,$y)";
}

# This method does not need to return a function since it is never
# called in the grammar.
sub match {
  my ($self) = @_;
  my $state = $self->{state};
  my $i = @$state - 1;
  while ($i > 0 && not defined $state->[$i]{end}) {
    xxxxx "Can't find match" if $i == 1;
    $i--;
  }

  my ($beg, $end) = @{$self->{state}[$i]}{qw<beg end>};
  return substr($self->{input}, $beg, ($end - $beg));
}
name match => \&match;

sub len {
  my ($self, $str) = @_;
  name len => sub {
    $str = $self->call($str, 'string') unless isString($str);
    return length $str;
  };
}

sub ord {
  my ($self, $str) = @_;
  name ord => sub {
    return ord $str;
  };
}

sub if {
  my ($self, $test, $do_if_true) = @_;
  name if => sub {
    $test = $self->call($test, 'boolean') unless isBoolean $test;
    return $self->call($do_if_true) if $test;
    return undef;
  };
}

sub lt {
  my ($self, $x, $y) = @_;
  name lt => sub {
    $x = $self->call($x, 'number') unless isNumber($x);
    $y = $self->call($y, 'number') unless isNumber($y);
    return $x < $y ? true : false;
  }, "lt(${\ stringify $x},${\ stringify $y})";
}

sub le {
  my ($self, $x, $y) = @_;
  name le => sub {
    $x = $self->call($x, 'number') unless isNumber($x);
    $y = $self->call($y, 'number') unless isNumber($y);
    return $x <= $y ? true : false;
  }, "le(${\ stringify $x},${\ stringify $y})";
}

sub m {
  my ($self) = @_;
  return 1; # XXX
  name m => sub {
    $self->state_curr->{m};
  };
}

sub t {
  my ($self) = @_;
  name t => sub {
    xxxxx $self;
  };
}

#------------------------------------------------------------------------------
# Special grammar rules
#------------------------------------------------------------------------------
sub start_of_line {
  my ($self) = @_;
  (
    $self->{pos} == 0 ||
    substr($self->{input}, $self->{pos} - 1, 1) eq "\n"
  ) ? true : false;
}
name 'start_of_line', \&start_of_line;

sub end_of_stream {
  my ($self) = @_;
  ($self->{pos} >= $self->{end}) ? true : false;
}
name 'end_of_stream', \&end_of_stream;

sub empty { true }
name 'empty', \&empty;

sub auto_detect_indent {
  my ($self) = @_;
  my $state = $self->state_curr;
  substr($self->{input}, $self->{pos}) =~ /^(\ *)/ or die;
  my $indent = length $1;
  $indent++ if $state->{ind} == -1;
  $state->{ind} += $indent;
  return $indent;
}
name 'auto_detect_indent', \&auto_detect_indent;

#------------------------------------------------------------------------------
# Trace debugging
#------------------------------------------------------------------------------
sub trace_start {
  '' || "$ENV{TRACE_START}";
}

sub trace_quiet {
  [
    split(',', ($ENV{TRACE_QUIET} || '')),
#     'b_char',
#     'c_byte_order_mark',
#     'c_flow_indicator',
#     'c_indicator',
#     'c_ns_alias_node',
#     'c_ns_properties',
#     'c_printable',
#     'l_comment',
#     'l_directive_document',
#     'l_document_prefix',
#     'l_explicit_document',
#     'nb_char',
#     'ns_char',
#     'ns_flow_pair',
#     'ns_plain',
#     'ns_plain_char',
#     's_l_block_collection',
#     's_l_block_in_block',
#     's_l_comments',
#     's_separate',
#     's_white',
  ];
}

sub trace {
  my ($self, $type, $call, $args) = @_;
  $args //= [];

  return unless $self->{trace_on} or $call eq $self->trace_start;

  my $level = $self->state_curr->{lvl};
  my $indent = ' ' x $level;
  if ($level > 0) {
    my $l = length "$level";
    $indent = "$level" . substr($indent, $l);
  }

  my $input = substr($self->{input}, $self->{pos});
  $input =~ s/\t/\\t/g;
  $input =~ s/\r/\\r/g;
  $input =~ s/\n/\\n/g;

  my $line = sprintf(
    "%s%s %-30s  %4d '%s'\n",
    $indent,
    $type,
    $self->trace_format_call($call, $args),
    $self->{pos},
    $input,
  );

  my $trace_info = undef;
  $level = "${level}_$call";
  if ($type eq '?' and not $self->{trace_off}) {
    $trace_info = [$type, $level, $line];
  }
  if (grep $_ eq $call, @{$self->trace_quiet}) {
    $self->{trace_off} += $type eq '?' ? 1 : -1;
  }
  if ($type ne '?' and not $self->{trace_off}) {
    $trace_info = [$type, $level, $line];
  }

  if (defined $trace_info) {
    my ($prev_type, $prev_level, $prev_line) = @{$self->{trace_info}};
    if ($prev_type eq '?' and $prev_level eq $level) {
      $trace_info->[1] = '';
      if ($line =~ /^\d*\ *\+/) {
        $prev_line =~ s/\?/=/;
      }
      else {
        $prev_line =~ s/\?/!/;
      }
    }
    if ($prev_level) {
      # die $prev_line if $prev_line =~ /\\\\/;
      warn sprintf "%5d %s", $self->{trace_num}++, $prev_line;
    }

    $self->{trace_info} = $trace_info;
  }

  if ($call eq $self->trace_start) {
    $self->{trace_on} = not $self->{trace_on};
  }
}

sub trace_format_call {
  my ($self, $call, $args) = @_;
  return $call unless @$args;
  my $list = join ',', map stringify($_), @$args;
  return "$call($list)";
}

sub trace_flush {
  my ($self) = @_;
  if (my $line = $self->{trace_info}[2]) {
    warn sprintf "%5d %s", $self->{trace_num}++, $line;
  }
}

1;

# vim: sw=2:
