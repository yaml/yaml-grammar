use v5.12;

package Func;
use overload
  eq => sub { 0 },
  bool => sub { 1 };
sub new {
  my ($class, $func, $name, $trace, $num) = @_;
  bless {
    func => $func,
    name => $name,
    trace => $trace || $name,
    num => $num,
    receivers => undef,
  }, $class;
}
sub TO_JSON { $_[0]->{func} }

package Prelude;

use boolean;
use Carp;
use Exporter 'import';
use JSON::PP;
use Time::HiRes qw< gettimeofday tv_interval >;
use YAML::PP::Perl;
use XXX;

our @EXPORT;
sub export { push @EXPORT, @_ }

export qw< true false >;

export 'rule';
sub rule {
  my ($num, $name, $func) = @_;
  my ($pkg) = caller;
  {
    no strict 'refs';
    *{"${pkg}::$name"} = $func;
  }
  $func = name($name, $func);
  $func->{num} = $num;
  return $func;
}

export 'name';
sub name {
  my ($name, $func, $trace) = (@_, '');
  return Func->new($func, $name, $trace);
}

export qw<isNull isBoolean isNumber isString isFunction isArray isObject>;
sub isNull { not defined $_[0] }
sub isBoolean { ref($_[0]) eq 'boolean' }
sub isNumber { not(ref $_[0]) and $_[0] =~ /^-?\d+$/ }
sub isString { not(ref $_[0]) and $_[0] !~ /^-?\d+$/ }
sub isFunction { ref($_[0]) eq 'Func' }
sub isArray { ref($_[0]) eq 'ARRAY' }
sub isObject { ref($_[0]) eq 'HASH' }

export 'typeof';
sub typeof {
  my ($value) = @_;
  return 'null' if isNull $value;
  return 'boolean' if isBoolean $value;
  return 'number' if isNumber $value;
  return 'string' if isString $value;
  return 'function' if isFunction $value;
  return 'array' if isArray $value;
  return 'object' if isObject $value;
  XXX [$value, ref($value)];
}

my $json = JSON::PP->new->canonical->allow_unknown->allow_nonref->convert_blessed;
sub json_stringify {
  my $string;
  eval {
    $string = $json->encode($_[0]);
  };
  confess $@ if $@;
  return $string;
}

export 'stringify';
sub stringify;
sub stringify {
  my ($o) = @_;
  if ($o eq "\x{feff}") {
    return "\\uFEFF";
  }
  if (isFunction $o) {
    return "\@$o->{name}";
  }
  if (isObject $o) {
    return json_stringify [ sort keys %$o ];
  }
  if (isArray $o) {
    return "[${\ join ',', map stringify($_), @$o}]";
  }
  if (isString $o) {
    $_ = json_stringify $o;
    s/^"(.*)"$/$1/;
    return $_;
  }
  return json_stringify $o;
}

export 'hex_char';
sub hex_char {
  my ($chr) = @_;
  return sprintf "x%x", ord $chr;
}

export 'func';
sub func {
  my ($self, $name) = @_;
  my $func = $self->can($name) or
    die "Can't find parser function '$name'";
  Func->new($func, $name);
}

export 'file_read';
sub file_read {
  do { local $/; <> };
}

export 'debug';
sub debug {
  my ($msg) = @_;
  warn ">>> $msg\n";
}

export 'debug_rule';
sub debug_rule {
  return unless $ENV{DEBUG};
  my ($name, @args) = @_;
  my $args = join ',', map stringify($_), @args;
  debug "$name($args)";
}

export qw< WWW XXX YYY ZZZ www xxx yyy zzz >;
*www = \&www;
*xxx = \&xxx;
*yyy = \&yyy;
*zzz = \&zzz;

export 'dump';
sub dump {
  YAML::PP::Perl->new->dump(@_);
}

export 'xxxxx';
sub xxxxx {
  WWW [@_];
  confess "xxxxx '${\ $_[0] // '???'}'";
}

export 'timer';
sub timer {
  if (@_) {
    tv_interval(shift);
  }
  else {
    [gettimeofday];
  }
}

1;

# vim: sw=2:
