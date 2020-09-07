use v5.12;
package DebugParser;
use base 'Parser';

use Prelude;

BEGIN {
my @methods = qw(
  all
  any
  rep
  case
  flip
  chr
  rng
  but
  chk
  set
  max
  exclude
  add
  sub
  m
  t
);

for my $method (@methods) {
  eval <<"...";
sub $method {
  debug "$method";
  my \$self = shift;
  \$self->SUPER::$method(\@_);
}
...
}
}

1;

# vim: sw=2:
