use v5.12;
package TestMLBridge;
use base 'TestML::Bridge';

use lib 'lib';

use Prelude;
use Parser;
use TestReceiver;

sub parse {
  my ($self, $yaml) = @_;

  my $parser = Parser->new(TestReceiver->new);

  eval { $parser->parse($yaml) };
  return $@
    ? do { warn $@; '' }
    : $parser->{receiver}->output;
}

1;
