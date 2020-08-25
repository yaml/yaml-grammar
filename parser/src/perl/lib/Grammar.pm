use v5.12;
package Grammar;
use base 'GrammarSpec';
use Prelude;

sub new {
  my ($class) = @_;

  bless {
    m => 0,
    t => 'keep',
  };
}

sub name { Parser::name(@_) }

#----------------------------------------------------------------
# Required hand written rules
#----------------------------------------------------------------
sub start_of_line {
  (
    $_[0]->{pos} == 0 ||
    substr($_[0]->{input}, $_[0]->{pos} - 1, 1) eq "\n"
  ) ? true : false;
}
name 'start_of_line', \&start_of_line;

sub end_of_stream {
  ($_[0]->{pos} >= $_[0]->{len}) ? true : false;
}
name 'end_of_stream', \&end_of_stream;

sub empty { true }
name 'empty', \&empty;

sub auto_detect_indent {
  1;
}
name 'auto_detect_indent', \&auto_detect_indent;

1;
