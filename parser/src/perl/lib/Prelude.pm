use v5.12;
package Prelude;

use boolean;
use Carp;
use Exporter 'import';
use JSON::PP;
use Time::HiRes qw< gettimeofday tv_interval >;

use XXX;

our @EXPORT = qw<
  name func_name func_trace stringify typeof func timer debug
  carp croak cluck confess
  true false
  WWW XXX YYY ZZZ
>;

my %name;
my %num;
my %trace;
my %sig;
sub name {
  my ($name, $func, $trace) = @_;
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

my $json = JSON::PP->new->allow_unknown;
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
    return "@${name $c}";
  }
  ($_ = substr(json_stringify([$c]), 2, -2)) =~ s/^"(.*)"/$1/;
  return $_;
}

sub typeof {
  my ($value) = @_;
  return 'null' if not defined $value;;
  return 'boolean' if ref($value) eq 'boolean';
  return 'number' if not(ref $value) and $value =~ /^-?\d+$/;
  return 'string' if not(ref $value);
  return 'function' if ref($value) eq 'CODE';
  return 'array' if ref($value) eq 'ARRAY';
  return 'object' if ref($value) eq 'HASH';
  XXX [$value, ref($value)];
}

sub func {
  my ($self, $name) = @_;
  $self->can($name) ||
    die "Can't find parser function '$name'";
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
