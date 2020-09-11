use v5.12;
package Prelude;

use boolean;
use Carp;
use Exporter 'import';
use JSON::PP;
use Time::HiRes qw< gettimeofday tv_interval >;
use YAML::PP::Perl;
use XXX;

our @EXPORT = qw<
  name rule
  true false
  stringify typeof func
  isNull isBoolean isNumber isString isFunction isArray isObject
  debug debug_rule dump
  carp croak cluck confess
  WWW XXX YYY ZZZ
  xxxxx
  timer
>;

{
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
}

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

sub name {
  my ($name, $func, $trace) = (@_, '');
  return Func->new($func, $name, $trace);
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

sub stringify {
  my ($c) = @_;
  if ($c eq "\x{feff}") {
    return "\\uFEFF";
  }
  if (typeof($c) eq 'function') {
    return "\@$c->{name}";
  }
  if (typeof($c) eq 'object') {
    return json_stringify [ sort keys %$c ];
  }
  $_ = json_stringify $c;
  s/^"(.*)"/$1/;
  return $_;
}

sub isNull { not defined $_[0] }
sub isBoolean { ref($_[0]) eq 'boolean' }
sub isNumber { not(ref $_[0]) and $_[0] =~ /^-?\d+$/ }
sub isString { not(ref $_[0]) and $_[0] !~ /^-?\d+$/ }
sub isFunction { ref($_[0]) eq 'Func' }
sub isArray { ref($_[0]) eq 'ARRAY' }
sub isObject { ref($_[0]) eq 'HASH' }

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

sub func {
  my ($self, $name) = @_;
  my $func = $self->can($name) or
    croak "Can't find parser function '$name'";
  Func->new($func, $name);
}

sub debug {
  my ($msg) = @_;
  warn ">>> $msg\n";
}

sub debug_rule {
  return unless $ENV{DEBUG};
  my ($name, @args) = @_;
  my $args = join ',', map stringify($_), @args;
  debug "$name($args)";
}

sub dump {
  YAML::PP::Perl->new->dump(@_);
}

sub xxxxx {
  confess @_;
}

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
