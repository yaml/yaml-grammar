use v5.12;
package DebugParser;
use base 'Parser';

use Prelude;

BEGIN {
  my @methods = qw(
    all any may rep
    case flip
    chr rng but chk
    set max exclude
    add sub
    match len ord if lt le
    m t
    start_of_line end_of_stream empty auto_detect_indent
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
