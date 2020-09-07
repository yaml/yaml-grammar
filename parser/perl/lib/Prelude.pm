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
  name func_name func_trace stringify typeof func timer
  isNull isBoolean isNumber isString isFunction isArray isObject
  debug debug1 dump
  carp croak cluck confess
  true false
  WWW XXX YYY ZZZ
>;

my %name;
my %num;
my %trace;
my %sig;
my $save = [];
sub name {
  my ($name, $func, $trace) = @_;
  push @$save, $func;
  $name{$func} = $name;
  if (defined $trace) {
    if ($trace =~ /^(\d+)$/) {
      $num{$func} = $trace;
    }
    else {
      $trace{$func} = $trace;
    }
  }
  return $func;
}

sub func_name {
  $name{$_[0]};
}

sub func_trace {
  $trace{$_[0]};
}

my $json = JSON::PP->new->canonical->allow_unknown->allow_nonref;
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
    return "\@$name{$c}";
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
sub isFunction { ref($_[0]) eq 'CODE' }
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
  $self->can($name) ||
    die "Can't find parser function '$name'";
}

sub debug {
  my ($msg) = @_;
  warn ">>> $msg\n";
}

sub debug1 {
  return unless $ENV{DEBUG};
  my ($name, @args) = @_;
  my $args = join ',', map stringify($_), @args;
  debug "$name($args)";
}

sub dump {
  YAML::PP::Perl->new->dump(@_);
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
