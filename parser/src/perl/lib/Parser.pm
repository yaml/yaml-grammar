###
# This is a parser class. It has a parse() method and parsing primitives for
# the grammar. It calls methods in the receiver class, when a rule matches:
###

use v5.12;
package Parser;
use Prelude;
use base 'Grammar';

sub new {
  my ($class, $receiver) = @_;

  bless {
    receiver => $receiver,
    pos => 0,
    len => 0,
    stack => [],
    trace_info => ['', '', ''],
    trace_off => 0,
  }, $class;
}

sub parse {
  my ($self, $input, $rule, $trace) = @_;
  $self->{input} = $input;
  $rule //= $self->can('TOP') or die;
  $trace //= false;

  $self->{len} = length $self->{input};
  $self->{pos} = 0;

  *trace = \&noop;
  *trace = \&trace_func if $trace;

  my $ok;
  eval {
    $ok = $self->call($rule);
  };
  if ($@) {
    $self->trace_flush;
    die $@;
  }

  $self->trace_flush;

  if (not $ok) {
    die "Parser failed";
  }

  if ($self->pos < length $input) {
    die "Parser finished before end of input";
  }

  return true;
}

sub state {
  $_[0]->{stack}[-1] || { lvl => 0 };
}

sub new_state {
  my ($self, $name) = @_;

  my $prev = $self->state;

  {
    name => $name,
    lvl => $prev->{lvl} + 1,
    pos => $self->{pos},
    m => undef,
  };
}

sub call {
  my ($self, $func, $type) = @_;
  $type //= 'boolean';

  my $args = [];
  if (typeof($func) eq 'array') {
    ($func, @$args) = @$func;
    @$args = map {
      typeof($_) eq 'array' ? $self->call($_, 'any') :
      typeof($_) eq 'function' ? $_->() :
      $_;
    } @$args;
  }

  return $func if $func eq $func + 0;

  die "Bad call type '${\ typeof $func}' for '$func'"
    unless typeof($func) eq 'function';

  my $trace = func_trace($func) || func_name($func) || XXX $func;

  push @{$self->{stack}}, $self->new_state(func_name($func));

  $self->trace('?', $trace, $args);

  my $pos = $self->{pos};
  $self->receive($func, 'try', $pos);

  my $func2 = $func->($self, $args);
  my $value = $func2;
  while (typeof($func2) eq 'function' or typeof($func2) eq 'array') {
    $value = $func2 = $self->call($func2);
  }

  die "Calling '$trace' returned '${\ typeof($value)}' instead of '$type'"
    if $type ne 'any' and typeof($value) ne $type;

  if ($type ne 'boolean') {
    pop @{$self->{stack}};
    return $value;
  }

  if ($value) {
    $self->trace('+', $trace);
    $self->receive($func, 'got', $pos);
  }
  else {
    $self->trace('x', $trace);
    $self->receive($func, 'not', $pos);
  }

  pop @{$self->{stack}};

  return $value;
}
my %receivers;
sub receive {
  my ($self, $func, $type, $pos) = @_;

  my $receiver = $receivers{$func} //=
    $self->make_receivers->{$type};

  return unless $receiver;

  $receiver->($self->{receiver}, {
    text => substr($self->{input}, $pos, $self->{pos}-$pos),
    state => $self->state,
    start => $pos,
  });
}

sub make_receivers {
  my ($self) = @_;
  my $i = @{$self->{stack}};
  my $names = [];
  my $n;
  while ($i > 0 and not ($n = $self->{stack}[--$i]{name}) =~ /_/) {
    if ($n =~ /^chr\((.)\)$/) {
      $n = 'chr_' . sprintf("%x", ord($1));
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
  name 'all', sub {
    my $pos = $self->{pos};
    for my $func (@funcs) {
      if (not defined $func) {
        XXX '*** Missing function in @all group:', \@funcs;
      }

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
  name 'any', sub {
    for my $func (@funcs) {
      if ($self->call($func)) {
        return true;
      }
    }

    return false;
  };
}

# Repeat a rule a certain number of times:
sub rep {
  my ($self, $min, $max, $func) = @_;
  name 'rep', sub {
    my $count = 0;
    my $pos = $self->{pos};
    while ($self->{pos} < $self->{len} and $self->call($func)) {
      return true if $min == 0 and $pos == $self->{pos};
      $count++;
    }
    if ($count >= $min and ($max == 0 or $count <= $max)) {
      return true;
    }
    else {
      $self->{pos} = $pos;
      return false;
    }
  }, "rep($min,$max)";
}

# Call a rule depending on state value:
sub case {
  my ($self, $var, $map) = @_;
  $self->die("$var");# + YAML::PP->new->dump([$var, $map]);
  my $rule = $map->{var} or
    XXX "Can't find '$var' in:"; #, $map;
  $self->call($rule);
}
name 'case', \&case;

# Call a rule depending on state value:
sub flip {
  my ($self, $var, $map) = @_;
  my $value = $map->{var} or
    XXX "Can't find '$var' in:", $map;
  return $value if not ref$value;
  return $->call($value);
}
name 'flip', \&flip;

# Match a single char:
sub chr {
  my ($self, $char) = @_;
  name 'chr', sub {
    if ($self->{pos} >= $self->{len}) {
      return false;
    }
    elsif (substr($self->{input}, $self->{pos}, 1) eq $char) {
      $self->{pos}++;
      return true;
    }
    else {
      return false;
    }
  }, "chr(${\ stringify($char)})";
}

# Match a char in a range:
sub rng {
  my ($self, $low, $high) = @_;
  name 'rng', sub {
    if ($self->{pos} >= $self->{len}) {
      return false;
    }
    elsif (
      $low le substr($self->{input}, $self->{pos}, 1) and
      substr($self->{input}, $self->{pos}, 1) le $high
    ) {
      $self->{pos}++;
      return true;
    }
    else {
      return false;
    }
  }, "rng(${\ stringify($low)},${\ stringify($high)})";
}

# Must match first rule but none of others:
sub but {
  my ($self, @funcs) = @_;
  name 'but', sub {
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
  name 'chk', sub {
    my $pos = $self->{pos};
    $pos-- if $type eq '<=';
    my $ok = $self->call($expr);
    $self->{pos} = $pos;
    return $type eq '!' ? not($ok) : $ok;
  }, "chk($type, ${\ stringify $expr}";
}

sub set {
  my ($self, $var, $expr) = @_;
  name 'set', sub {
    $self->state->{$var} = $self->call($expr, 'any');
    return true;
  };
}

sub max {
  my ($self, $max) = @_;
  name 'max', sub {
    return true;
  };
}

sub exclude {
  my ($self, $rule) = @_;
  name 'exclude', sub {
    return true;
  };
}

sub add {
  my ($self, $x, $y) = @_;
  name 'add', sub {
    return $x + $y;
  }, "add($x,$y)";
}

sub sub {
  my ($self, $x, $y) = @_;
  name 'sub', sub {
    return $x - $y;
  }, "sub($x,$y)";
}

sub die {
  my ($self, $msg) = @_;
  Carp::croak($msg);
}

#------------------------------------------------------------------------------
# Trace debugging:
#------------------------------------------------------------------------------
sub noop {}
sub trace_func {
  my ($self, $type, $call, $args) = @_;
  $args //= [];
  if ($type eq 'report') {
    return $self->trace_report;
  }

  my $level = $self->state->{lvl};
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
  if (grep $_ eq $call, @{$self->trace_no_descend}) {
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
        warn $prev_line;
      }
      else {
        $prev_line =~ s/\?/!/;
        warn $prev_line;
      }
    }
    elsif ($prev_level) {
      warn $prev_line;
    }
  }

  $self->{trace_info} = $trace_info;
}

sub trace_format_call {
  my ($self, $call, $args) = @_;
  return $call unless @$args;
  my @list = map {
    if (typeof($_) eq 'function') {
      $_->();
    }
    elsif (not defined $_) {
      'null';
    }
    else {
      $_;
    }
  } @$args;
  return $call . '(' . join(',', @list) . ')';
}

sub trace_flush {
  my ($self) = @_;
  if (my $line = $self->{trace_info}->[2]) {
    warn $line;
  }
}

sub trace_no_descend {
  [
#     'l_document_prefix',
#     'l_directive_document',
#     'l_explicit_document',
#     's_l_block_in_block',
#     's_separate',
#     'c_ns_alias_node',
#     'ns_plain',
#     's_l_comments',
#     'c_ns_properties',
#     'ns_flow_pair',

#     'c_printable',
#     'b_char',
#     'c_byte_order_mark',
#     'nb_char',
#     'ns_char',
#     'c_indicator',
#     'ns_plain_char',
#     's_white',
#     'c_flow_indicator',
#     'l_comment',
#     's_l_block_collection',
  ];
}

1;

# vim: sw=2:
