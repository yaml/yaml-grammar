###
# This grammar class was generated from https://yaml.org/spec/1.2/spec.html
###

use v5.12;
package Grammar;
use Prelude;

sub TOP {
  my ($self) = @_;
  $self->func('l_yaml_stream');
}
name 'TOP', \&TOP;


# [001]
# c-printable ::=
#   x:9 | x:A | x:D | [x:20-x:7E]
#   | x:85 | [x:A0-x:D7FF] | [x:E000-x:FFFD]
#   | [x:10000-x:10FFFF]

sub c_printable {
  my ($self) = @_;
  debug1("c_printable");
  $self->any(
    $self->chr("\x{09}"),
    $self->chr("\x{0A}"),
    $self->chr("\x{0D}"),
    $self->rng("\x{20}", "\x{7E}"),
    $self->chr("\x{85}"),
    $self->rng("\x{A0}", "\x{D7FF}"),
    $self->rng("\x{E000}", "\x{FFFD}"),
    $self->rng("\x{010000}", "\x{10FFFF}"),
  );
}
name 'c_printable', \&c_printable;



# [002]
# nb-json ::=
#   x:9 | [x:20-x:10FFFF]

sub nb_json {
  my ($self) = @_;
  debug1("nb_json");
  $self->any(
    $self->chr("\x{09}"),
    $self->rng("\x{20}", "\x{10FFFF}"),
  );
}
name 'nb_json', \&nb_json;



# [003]
# c-byte-order-mark ::=
#   x:FEFF

sub c_byte_order_mark {
  my ($self) = @_;
  debug1("c_byte_order_mark");
  $self->chr("\x{FEFF}");
}
name 'c_byte_order_mark', \&c_byte_order_mark;



# [004]
# c-sequence-entry ::=
#   '-'

sub c_sequence_entry {
  my ($self) = @_;
  debug1("c_sequence_entry");
  $self->chr('-');
}
name 'c_sequence_entry', \&c_sequence_entry;



# [005]
# c-mapping-key ::=
#   '?'

sub c_mapping_key {
  my ($self) = @_;
  debug1("c_mapping_key");
  $self->chr('?');
}
name 'c_mapping_key', \&c_mapping_key;



# [006]
# c-mapping-value ::=
#   ':'

sub c_mapping_value {
  my ($self) = @_;
  debug1("c_mapping_value");
  $self->chr(':');
}
name 'c_mapping_value', \&c_mapping_value;



# [007]
# c-collect-entry ::=
#   ','

sub c_collect_entry {
  my ($self) = @_;
  debug1("c_collect_entry");
  $self->chr(',');
}
name 'c_collect_entry', \&c_collect_entry;



# [008]
# c-sequence-start ::=
#   '['

sub c_sequence_start {
  my ($self) = @_;
  debug1("c_sequence_start");
  $self->chr('[');
}
name 'c_sequence_start', \&c_sequence_start;



# [009]
# c-sequence-end ::=
#   ']'

sub c_sequence_end {
  my ($self) = @_;
  debug1("c_sequence_end");
  $self->chr(']');
}
name 'c_sequence_end', \&c_sequence_end;



# [010]
# c-mapping-start ::=
#   '{'

sub c_mapping_start {
  my ($self) = @_;
  debug1("c_mapping_start");
  $self->chr('{');
}
name 'c_mapping_start', \&c_mapping_start;



# [011]
# c-mapping-end ::=
#   '}'

sub c_mapping_end {
  my ($self) = @_;
  debug1("c_mapping_end");
  $self->chr('}');
}
name 'c_mapping_end', \&c_mapping_end;



# [012]
# c-comment ::=
#   '#'

sub c_comment {
  my ($self) = @_;
  debug1("c_comment");
  $self->chr('#');
}
name 'c_comment', \&c_comment;



# [013]
# c-anchor ::=
#   '&'

sub c_anchor {
  my ($self) = @_;
  debug1("c_anchor");
  $self->chr('&');
}
name 'c_anchor', \&c_anchor;



# [014]
# c-alias ::=
#   '*'

sub c_alias {
  my ($self) = @_;
  debug1("c_alias");
  $self->chr('*');
}
name 'c_alias', \&c_alias;



# [015]
# c-tag ::=
#   '!'

sub c_tag {
  my ($self) = @_;
  debug1("c_tag");
  $self->chr('!');
}
name 'c_tag', \&c_tag;



# [016]
# c-literal ::=
#   '|'

sub c_literal {
  my ($self) = @_;
  debug1("c_literal");
  $self->chr('|');
}
name 'c_literal', \&c_literal;



# [017]
# c-folded ::=
#   '>'

sub c_folded {
  my ($self) = @_;
  debug1("c_folded");
  $self->chr('>');
}
name 'c_folded', \&c_folded;



# [018]
# c-single-quote ::=
#   '''

sub c_single_quote {
  my ($self) = @_;
  debug1("c_single_quote");
  $self->chr("'");
}
name 'c_single_quote', \&c_single_quote;



# [019]
# c-double-quote ::=
#   '"'

sub c_double_quote {
  my ($self) = @_;
  debug1("c_double_quote");
  $self->chr('"');
}
name 'c_double_quote', \&c_double_quote;



# [020]
# c-directive ::=
#   '%'

sub c_directive {
  my ($self) = @_;
  debug1("c_directive");
  $self->chr('%');
}
name 'c_directive', \&c_directive;



# [021]
# c-reserved ::=
#   '@' | '`'

sub c_reserved {
  my ($self) = @_;
  debug1("c_reserved");
  $self->any(
    $self->chr('@'),
    $self->chr('`'),
  );
}
name 'c_reserved', \&c_reserved;



# [022]
# c-indicator ::=
#   '-' | '?' | ':' | ',' | '[' | ']' | '{' | '}'
#   | '#' | '&' | '*' | '!' | '|' | '>' | ''' | '"'
#   | '%' | '@' | '`'

sub c_indicator {
  my ($self) = @_;
  debug1("c_indicator");
  $self->any(
    $self->chr('-'),
    $self->chr('?'),
    $self->chr(':'),
    $self->chr(','),
    $self->chr('['),
    $self->chr(']'),
    $self->chr('{'),
    $self->chr('}'),
    $self->chr('#'),
    $self->chr('&'),
    $self->chr('*'),
    $self->chr('!'),
    $self->chr('|'),
    $self->chr('>'),
    $self->chr("'"),
    $self->chr('"'),
    $self->chr('%'),
    $self->chr('@'),
    $self->chr('`'),
  );
}
name 'c_indicator', \&c_indicator;



# [023]
# c-flow-indicator ::=
#   ',' | '[' | ']' | '{' | '}'

sub c_flow_indicator {
  my ($self) = @_;
  debug1("c_flow_indicator");
  $self->any(
    $self->chr(','),
    $self->chr('['),
    $self->chr(']'),
    $self->chr('{'),
    $self->chr('}'),
  );
}
name 'c_flow_indicator', \&c_flow_indicator;



# [024]
# b-line-feed ::=
#   x:A

sub b_line_feed {
  my ($self) = @_;
  debug1("b_line_feed");
  $self->chr("\x{0A}");
}
name 'b_line_feed', \&b_line_feed;



# [025]
# b-carriage-return ::=
#   x:D

sub b_carriage_return {
  my ($self) = @_;
  debug1("b_carriage_return");
  $self->chr("\x{0D}");
}
name 'b_carriage_return', \&b_carriage_return;



# [026]
# b-char ::=
#   b-line-feed | b-carriage-return

sub b_char {
  my ($self) = @_;
  debug1("b_char");
  $self->any(
    $self->func('b_line_feed'),
    $self->func('b_carriage_return'),
  );
}
name 'b_char', \&b_char;



# [027]
# nb-char ::=
#   c-printable - b-char - c-byte-order-mark

sub nb_char {
  my ($self) = @_;
  debug1("nb_char");
  $self->but(
    $self->func('c_printable'),
    $self->func('b_char'),
    $self->func('c_byte_order_mark'),
  );
}
name 'nb_char', \&nb_char;



# [028]
# b-break ::=
#   ( b-carriage-return b-line-feed )
#   | b-carriage-return
#   | b-line-feed

sub b_break {
  my ($self) = @_;
  debug1("b_break");
  $self->any(
    $self->all(
      $self->func('b_carriage_return'),
      $self->func('b_line_feed'),
    ),
    $self->func('b_carriage_return'),
    $self->func('b_line_feed'),
  );
}
name 'b_break', \&b_break;



# [029]
# b-as-line-feed ::=
#   b-break

sub b_as_line_feed {
  my ($self) = @_;
  debug1("b_as_line_feed");
  $self->func('b_break');
}
name 'b_as_line_feed', \&b_as_line_feed;



# [030]
# b-non-content ::=
#   b-break

sub b_non_content {
  my ($self) = @_;
  debug1("b_non_content");
  $self->func('b_break');
}
name 'b_non_content', \&b_non_content;



# [031]
# s-space ::=
#   x:20

sub s_space {
  my ($self) = @_;
  debug1("s_space");
  $self->chr("\x{20}");
}
name 's_space', \&s_space;



# [032]
# s-tab ::=
#   x:9

sub s_tab {
  my ($self) = @_;
  debug1("s_tab");
  $self->chr("\x{09}");
}
name 's_tab', \&s_tab;



# [033]
# s-white ::=
#   s-space | s-tab

sub s_white {
  my ($self) = @_;
  debug1("s_white");
  $self->any(
    $self->func('s_space'),
    $self->func('s_tab'),
  );
}
name 's_white', \&s_white;



# [034]
# ns-char ::=
#   nb-char - s-white

sub ns_char {
  my ($self) = @_;
  debug1("ns_char");
  $self->but(
    $self->func('nb_char'),
    $self->func('s_white'),
  );
}
name 'ns_char', \&ns_char;



# [035]
# ns-dec-digit ::=
#   [x:30-x:39]

sub ns_dec_digit {
  my ($self) = @_;
  debug1("ns_dec_digit");
  $self->rng("\x{30}", "\x{39}");
}
name 'ns_dec_digit', \&ns_dec_digit;



# [036]
# ns-hex-digit ::=
#   ns-dec-digit
#   | [x:41-x:46] | [x:61-x:66]

sub ns_hex_digit {
  my ($self) = @_;
  debug1("ns_hex_digit");
  $self->any(
    $self->func('ns_dec_digit'),
    $self->rng("\x{41}", "\x{46}"),
    $self->rng("\x{61}", "\x{66}"),
  );
}
name 'ns_hex_digit', \&ns_hex_digit;



# [037]
# ns-ascii-letter ::=
#   [x:41-x:5A] | [x:61-x:7A]

sub ns_ascii_letter {
  my ($self) = @_;
  debug1("ns_ascii_letter");
  $self->any(
    $self->rng("\x{41}", "\x{5A}"),
    $self->rng("\x{61}", "\x{7A}"),
  );
}
name 'ns_ascii_letter', \&ns_ascii_letter;



# [038]
# ns-word-char ::=
#   ns-dec-digit | ns-ascii-letter | '-'

sub ns_word_char {
  my ($self) = @_;
  debug1("ns_word_char");
  $self->any(
    $self->func('ns_dec_digit'),
    $self->func('ns_ascii_letter'),
    $self->chr('-'),
  );
}
name 'ns_word_char', \&ns_word_char;



# [039]
# ns-uri-char ::=
#   '%' ns-hex-digit ns-hex-digit | ns-word-char | '#'
#   | ';' | '/' | '?' | ':' | '@' | '&' | '=' | '+' | '$' | ','
#   | '_' | '.' | '!' | '~' | '*' | ''' | '(' | ')' | '[' | ']'

sub ns_uri_char {
  my ($self) = @_;
  debug1("ns_uri_char");
  $self->any(
    $self->all(
      $self->chr('%'),
      $self->func('ns_hex_digit'),
      $self->func('ns_hex_digit'),
    ),
    $self->func('ns_word_char'),
    $self->chr('#'),
    $self->chr(';'),
    $self->chr('/'),
    $self->chr('?'),
    $self->chr(':'),
    $self->chr('@'),
    $self->chr('&'),
    $self->chr('='),
    $self->chr('+'),
    $self->chr('$'),
    $self->chr(','),
    $self->chr('_'),
    $self->chr('.'),
    $self->chr('!'),
    $self->chr('~'),
    $self->chr('*'),
    $self->chr("'"),
    $self->chr('('),
    $self->chr(')'),
    $self->chr('['),
    $self->chr(']'),
  );
}
name 'ns_uri_char', \&ns_uri_char;



# [040]
# ns-tag-char ::=
#   ns-uri-char - '!' - c-flow-indicator

sub ns_tag_char {
  my ($self) = @_;
  debug1("ns_tag_char");
  $self->but(
    $self->func('ns_uri_char'),
    $self->chr('!'),
    $self->func('c_flow_indicator'),
  );
}
name 'ns_tag_char', \&ns_tag_char;



# [041]
# c-escape ::=
#   '\'

sub c_escape {
  my ($self) = @_;
  debug1("c_escape");
  $self->chr("\\");
}
name 'c_escape', \&c_escape;



# [042]
# ns-esc-null ::=
#   '0'

sub ns_esc_null {
  my ($self) = @_;
  debug1("ns_esc_null");
  $self->chr('0');
}
name 'ns_esc_null', \&ns_esc_null;



# [043]
# ns-esc-bell ::=
#   'a'

sub ns_esc_bell {
  my ($self) = @_;
  debug1("ns_esc_bell");
  $self->chr('a');
}
name 'ns_esc_bell', \&ns_esc_bell;



# [044]
# ns-esc-backspace ::=
#   'b'

sub ns_esc_backspace {
  my ($self) = @_;
  debug1("ns_esc_backspace");
  $self->chr('b');
}
name 'ns_esc_backspace', \&ns_esc_backspace;



# [045]
# ns-esc-horizontal-tab ::=
#   't' | x:9

sub ns_esc_horizontal_tab {
  my ($self) = @_;
  debug1("ns_esc_horizontal_tab");
  $self->any(
    $self->chr('t'),
    $self->chr("\x{09}"),
  );
}
name 'ns_esc_horizontal_tab', \&ns_esc_horizontal_tab;



# [046]
# ns-esc-line-feed ::=
#   'n'

sub ns_esc_line_feed {
  my ($self) = @_;
  debug1("ns_esc_line_feed");
  $self->chr('n');
}
name 'ns_esc_line_feed', \&ns_esc_line_feed;



# [047]
# ns-esc-vertical-tab ::=
#   'v'

sub ns_esc_vertical_tab {
  my ($self) = @_;
  debug1("ns_esc_vertical_tab");
  $self->chr('v');
}
name 'ns_esc_vertical_tab', \&ns_esc_vertical_tab;



# [048]
# ns-esc-form-feed ::=
#   'f'

sub ns_esc_form_feed {
  my ($self) = @_;
  debug1("ns_esc_form_feed");
  $self->chr('f');
}
name 'ns_esc_form_feed', \&ns_esc_form_feed;



# [049]
# ns-esc-carriage-return ::=
#   'r'

sub ns_esc_carriage_return {
  my ($self) = @_;
  debug1("ns_esc_carriage_return");
  $self->chr('r');
}
name 'ns_esc_carriage_return', \&ns_esc_carriage_return;



# [050]
# ns-esc-escape ::=
#   'e'

sub ns_esc_escape {
  my ($self) = @_;
  debug1("ns_esc_escape");
  $self->chr('e');
}
name 'ns_esc_escape', \&ns_esc_escape;



# [051]
# ns-esc-space ::=
#   x:20

sub ns_esc_space {
  my ($self) = @_;
  debug1("ns_esc_space");
  $self->chr("\x{20}");
}
name 'ns_esc_space', \&ns_esc_space;



# [052]
# ns-esc-double-quote ::=
#   '"'

sub ns_esc_double_quote {
  my ($self) = @_;
  debug1("ns_esc_double_quote");
  $self->chr('"');
}
name 'ns_esc_double_quote', \&ns_esc_double_quote;



# [053]
# ns-esc-slash ::=
#   '/'

sub ns_esc_slash {
  my ($self) = @_;
  debug1("ns_esc_slash");
  $self->chr('/');
}
name 'ns_esc_slash', \&ns_esc_slash;



# [054]
# ns-esc-backslash ::=
#   '\'

sub ns_esc_backslash {
  my ($self) = @_;
  debug1("ns_esc_backslash");
  $self->chr("\\");
}
name 'ns_esc_backslash', \&ns_esc_backslash;



# [055]
# ns-esc-next-line ::=
#   'N'

sub ns_esc_next_line {
  my ($self) = @_;
  debug1("ns_esc_next_line");
  $self->chr('N');
}
name 'ns_esc_next_line', \&ns_esc_next_line;



# [056]
# ns-esc-non-breaking-space ::=
#   '_'

sub ns_esc_non_breaking_space {
  my ($self) = @_;
  debug1("ns_esc_non_breaking_space");
  $self->chr('_');
}
name 'ns_esc_non_breaking_space', \&ns_esc_non_breaking_space;



# [057]
# ns-esc-line-separator ::=
#   'L'

sub ns_esc_line_separator {
  my ($self) = @_;
  debug1("ns_esc_line_separator");
  $self->chr('L');
}
name 'ns_esc_line_separator', \&ns_esc_line_separator;



# [058]
# ns-esc-paragraph-separator ::=
#   'P'

sub ns_esc_paragraph_separator {
  my ($self) = @_;
  debug1("ns_esc_paragraph_separator");
  $self->chr('P');
}
name 'ns_esc_paragraph_separator', \&ns_esc_paragraph_separator;



# [059]
# ns-esc-8-bit ::=
#   'x'
#   ( ns-hex-digit{2} )

sub ns_esc_8_bit {
  my ($self) = @_;
  debug1("ns_esc_8_bit");
  $self->all(
    $self->chr('x'),
    $self->rep($2, $2, $self->func('ns_hex_digit')),
  );
}
name 'ns_esc_8_bit', \&ns_esc_8_bit;



# [060]
# ns-esc-16-bit ::=
#   'u'
#   ( ns-hex-digit{4} )

sub ns_esc_16_bit {
  my ($self) = @_;
  debug1("ns_esc_16_bit");
  $self->all(
    $self->chr('u'),
    $self->rep($4, $4, $self->func('ns_hex_digit')),
  );
}
name 'ns_esc_16_bit', \&ns_esc_16_bit;



# [061]
# ns-esc-32-bit ::=
#   'U'
#   ( ns-hex-digit{8} )

sub ns_esc_32_bit {
  my ($self) = @_;
  debug1("ns_esc_32_bit");
  $self->all(
    $self->chr('U'),
    $self->rep($8, $8, $self->func('ns_hex_digit')),
  );
}
name 'ns_esc_32_bit', \&ns_esc_32_bit;



# [062]
# c-ns-esc-char ::=
#   '\'
#   ( ns-esc-null | ns-esc-bell | ns-esc-backspace
#   | ns-esc-horizontal-tab | ns-esc-line-feed
#   | ns-esc-vertical-tab | ns-esc-form-feed
#   | ns-esc-carriage-return | ns-esc-escape | ns-esc-space
#   | ns-esc-double-quote | ns-esc-slash | ns-esc-backslash
#   | ns-esc-next-line | ns-esc-non-breaking-space
#   | ns-esc-line-separator | ns-esc-paragraph-separator
#   | ns-esc-8-bit | ns-esc-16-bit | ns-esc-32-bit )

sub c_ns_esc_char {
  my ($self) = @_;
  debug1("c_ns_esc_char");
  $self->all(
    $self->chr("\\"),
    $self->any(
      $self->func('ns_esc_null'),
      $self->func('ns_esc_bell'),
      $self->func('ns_esc_backspace'),
      $self->func('ns_esc_horizontal_tab'),
      $self->func('ns_esc_line_feed'),
      $self->func('ns_esc_vertical_tab'),
      $self->func('ns_esc_form_feed'),
      $self->func('ns_esc_carriage_return'),
      $self->func('ns_esc_escape'),
      $self->func('ns_esc_space'),
      $self->func('ns_esc_double_quote'),
      $self->func('ns_esc_slash'),
      $self->func('ns_esc_backslash'),
      $self->func('ns_esc_next_line'),
      $self->func('ns_esc_non_breaking_space'),
      $self->func('ns_esc_line_separator'),
      $self->func('ns_esc_paragraph_separator'),
      $self->func('ns_esc_8_bit'),
      $self->func('ns_esc_16_bit'),
      $self->func('ns_esc_32_bit'),
    ),
  );
}
name 'c_ns_esc_char', \&c_ns_esc_char;



# [063]
# s-indent(n) ::=
#   s-space{n}

sub s_indent {
  my ($self, $n) = @_;
  debug1("s_indent",$n);
  $self->rep($n, $n, $self->func('s_space'));
}
name 's_indent', \&s_indent;



# [064]
# s-indent(<n) ::=
#   s-space{m} <where_m_<_n>

sub s_indent_lt {
  my ($self, $n) = @_;
  debug1("s_indent_lt",$n);
  $self->may(
    $self->all(
      $self->rep(0, 0, $self->func('s_space')),
      $self->lt($self->len($self->func('match')), $n),
    )
  );
}
name 's_indent_lt', \&s_indent_lt;



# [065]
# s-indent(<=n) ::=
#   s-space{m} <where_m_<=_n>

sub s_indent_le {
  my ($self, $n) = @_;
  debug1("s_indent_le",$n);
  $self->may(
    $self->all(
      $self->rep(0, 0, $self->func('s_space')),
      $self->le($self->len($self->func('match')), $self->chr('n')),
    )
  );
}
name 's_indent_le', \&s_indent_le;



# [066]
# s-separate-in-line ::=
#   s-white+ | <start_of_line>

sub s_separate_in_line {
  my ($self) = @_;
  debug1("s_separate_in_line");
  $self->any(
    $self->rep(1, 0, $self->func('s_white')),
    $self->func('start_of_line'),
  );
}
name 's_separate_in_line', \&s_separate_in_line;



# [067]
# s-line-prefix(n,c) ::=
#   ( c = block-out => s-block-line-prefix(n) )
#   ( c = block-in => s-block-line-prefix(n) )
#   ( c = flow-out => s-flow-line-prefix(n) )
#   ( c = flow-in => s-flow-line-prefix(n) )

sub s_line_prefix {
  my ($self, $n, $c) = @_;
  debug1("s_line_prefix",$n,$c);
  $self->case($c, {
    'block-in' => [ $self->func('s_block_line_prefix'), $n ],
    'block-out' => [ $self->func('s_block_line_prefix'), $n ],
    'flow-in' => [ $self->func('s_flow_line_prefix'), $n ],
    'flow-out' => [ $self->func('s_flow_line_prefix'), $n ],
  });
}
name 's_line_prefix', \&s_line_prefix;



# [068]
# s-block-line-prefix(n) ::=
#   s-indent(n)

sub s_block_line_prefix {
  my ($self, $n) = @_;
  debug1("s_block_line_prefix",$n);
  [ $self->func('s_indent'), $n ];
}
name 's_block_line_prefix', \&s_block_line_prefix;



# [069]
# s-flow-line-prefix(n) ::=
#   s-indent(n)
#   s-separate-in-line?

sub s_flow_line_prefix {
  my ($self, $n) = @_;
  debug1("s_flow_line_prefix",$n);
  $self->all(
    [ $self->func('s_indent'), $n ],
    $self->rep(0, 1, $self->func('s_separate_in_line')),
  );
}
name 's_flow_line_prefix', \&s_flow_line_prefix;



# [070]
# l-empty(n,c) ::=
#   ( s-line-prefix(n,c) | s-indent(<n) )
#   b-as-line-feed

sub l_empty {
  my ($self, $n, $c) = @_;
  debug1("l_empty",$n,$c);
  $self->all(
    $self->any(
      [ $self->func('s_line_prefix'), $n, $c ],
      [ $self->func('s_indent_lt'), $n ],
    ),
    $self->func('b_as_line_feed'),
  );
}
name 'l_empty', \&l_empty;



# [071]
# b-l-trimmed(n,c) ::=
#   b-non-content l-empty(n,c)+

sub b_l_trimmed {
  my ($self, $n, $c) = @_;
  debug1("b_l_trimmed",$n,$c);
  $self->all(
    $self->func('b_non_content'),
    $self->rep(1, 0, [ $self->func('l_empty'), $n, $c ]),
  );
}
name 'b_l_trimmed', \&b_l_trimmed;



# [072]
# b-as-space ::=
#   b-break

sub b_as_space {
  my ($self) = @_;
  debug1("b_as_space");
  $self->func('b_break');
}
name 'b_as_space', \&b_as_space;



# [073]
# b-l-folded(n,c) ::=
#   b-l-trimmed(n,c) | b-as-space

sub b_l_folded {
  my ($self, $n, $c) = @_;
  debug1("b_l_folded",$n,$c);
  $self->any(
    [ $self->func('b_l_trimmed'), $n, $c ],
    $self->func('b_as_space'),
  );
}
name 'b_l_folded', \&b_l_folded;



# [074]
# s-flow-folded(n) ::=
#   s-separate-in-line?
#   b-l-folded(n,flow-in)
#   s-flow-line-prefix(n)

sub s_flow_folded {
  my ($self, $n) = @_;
  debug1("s_flow_folded",$n);
  $self->all(
    $self->rep(0, 1, $self->func('s_separate_in_line')),
    [ $self->func('b_l_folded'), $n, "flow-in" ],
    [ $self->func('s_flow_line_prefix'), $n ],
  );
}
name 's_flow_folded', \&s_flow_folded;



# [075]
# c-nb-comment-text ::=
#   '#' nb-char*

sub c_nb_comment_text {
  my ($self) = @_;
  debug1("c_nb_comment_text");
  $self->all(
    $self->chr('#'),
    $self->rep(0, 0, $self->func('nb_char')),
  );
}
name 'c_nb_comment_text', \&c_nb_comment_text;



# [076]
# b-comment ::=
#   b-non-content | <end_of_file>

sub b_comment {
  my ($self) = @_;
  debug1("b_comment");
  $self->any(
    $self->func('b_non_content'),
    $self->func('end_of_stream'),
  );
}
name 'b_comment', \&b_comment;



# [077]
# s-b-comment ::=
#   ( s-separate-in-line
#   c-nb-comment-text? )?
#   b-comment

sub s_b_comment {
  my ($self) = @_;
  debug1("s_b_comment");
  $self->all(
    $self->rep(0, 1,
      $self->all(
        $self->func('s_separate_in_line'),
        $self->rep(0, 1, $self->func('c_nb_comment_text')),
      )),
    $self->func('b_comment'),
  );
}
name 's_b_comment', \&s_b_comment;



# [078]
# l-comment ::=
#   s-separate-in-line c-nb-comment-text?
#   b-comment

sub l_comment {
  my ($self) = @_;
  debug1("l_comment");
  $self->all(
    $self->func('s_separate_in_line'),
    $self->rep(0, 1, $self->func('c_nb_comment_text')),
    $self->func('b_comment'),
  );
}
name 'l_comment', \&l_comment;



# [079]
# s-l-comments ::=
#   ( s-b-comment | <start_of_line> )
#   l-comment*

sub s_l_comments {
  my ($self) = @_;
  debug1("s_l_comments");
  $self->all(
    $self->any(
      $self->func('s_b_comment'),
      $self->func('start_of_line'),
    ),
    $self->rep(0, 0, $self->func('l_comment')),
  );
}
name 's_l_comments', \&s_l_comments;



# [080]
# s-separate(n,c) ::=
#   ( c = block-out => s-separate-lines(n) )
#   ( c = block-in => s-separate-lines(n) )
#   ( c = flow-out => s-separate-lines(n) )
#   ( c = flow-in => s-separate-lines(n) )
#   ( c = block-key => s-separate-in-line )
#   ( c = flow-key => s-separate-in-line )

sub s_separate {
  my ($self, $n, $c) = @_;
  debug1("s_separate",$n,$c);
  $self->case($c, {
    'block-in' => [ $self->func('s_separate_lines'), $n ],
    'block-key' => $self->func('s_separate_in_line'),
    'block-out' => [ $self->func('s_separate_lines'), $n ],
    'flow-in' => [ $self->func('s_separate_lines'), $n ],
    'flow-key' => $self->func('s_separate_in_line'),
    'flow-out' => [ $self->func('s_separate_lines'), $n ],
  });
}
name 's_separate', \&s_separate;



# [081]
# s-separate-lines(n) ::=
#   ( s-l-comments
#   s-flow-line-prefix(n) )
#   | s-separate-in-line

sub s_separate_lines {
  my ($self, $n) = @_;
  debug1("s_separate_lines",$n);
  $self->any(
    $self->all(
      $self->func('s_l_comments'),
      [ $self->func('s_flow_line_prefix'), $n ],
    ),
    $self->func('s_separate_in_line'),
  );
}
name 's_separate_lines', \&s_separate_lines;



# [082]
# l-directive ::=
#   '%'
#   ( ns-yaml-directive
#   | ns-tag-directive
#   | ns-reserved-directive )
#   s-l-comments

sub l_directive {
  my ($self) = @_;
  debug1("l_directive");
  $self->all(
    $self->chr('%'),
    $self->any(
      $self->func('ns_yaml_directive'),
      $self->func('ns_tag_directive'),
      $self->func('ns_reserved_directive'),
    ),
    $self->func('s_l_comments'),
  );
}
name 'l_directive', \&l_directive;



# [083]
# ns-reserved-directive ::=
#   ns-directive-name
#   ( s-separate-in-line ns-directive-parameter )*

sub ns_reserved_directive {
  my ($self) = @_;
  debug1("ns_reserved_directive");
  $self->all(
    $self->func('ns_directive_name'),
    $self->rep(0, 0,
      $self->all(
        $self->func('s_separate_in_line'),
        $self->func('ns_directive_parameter'),
      )),
  );
}
name 'ns_reserved_directive', \&ns_reserved_directive;



# [084]
# ns-directive-name ::=
#   ns-char+

sub ns_directive_name {
  my ($self) = @_;
  debug1("ns_directive_name");
  $self->rep(1, 0, $self->func('ns_char'));
}
name 'ns_directive_name', \&ns_directive_name;



# [085]
# ns-directive-parameter ::=
#   ns-char+

sub ns_directive_parameter {
  my ($self) = @_;
  debug1("ns_directive_parameter");
  $self->rep(1, 0, $self->func('ns_char'));
}
name 'ns_directive_parameter', \&ns_directive_parameter;



# [086]
# ns-yaml-directive ::=
#   'Y' 'A' 'M' 'L'
#   s-separate-in-line ns-yaml-version

sub ns_yaml_directive {
  my ($self) = @_;
  debug1("ns_yaml_directive");
  $self->all(
    $self->chr('Y'),
    $self->chr('A'),
    $self->chr('M'),
    $self->chr('L'),
    $self->func('s_separate_in_line'),
    $self->func('ns_yaml_version'),
  );
}
name 'ns_yaml_directive', \&ns_yaml_directive;



# [087]
# ns-yaml-version ::=
#   ns-dec-digit+ '.' ns-dec-digit+

sub ns_yaml_version {
  my ($self) = @_;
  debug1("ns_yaml_version");
  $self->all(
    $self->rep(1, 0, $self->func('ns_dec_digit')),
    $self->chr('.'),
    $self->rep(1, 0, $self->func('ns_dec_digit')),
  );
}
name 'ns_yaml_version', \&ns_yaml_version;



# [088]
# ns-tag-directive ::=
#   'T' 'A' 'G'
#   s-separate-in-line c-tag-handle
#   s-separate-in-line ns-tag-prefix

sub ns_tag_directive {
  my ($self) = @_;
  debug1("ns_tag_directive");
  $self->all(
    $self->chr('T'),
    $self->chr('A'),
    $self->chr('G'),
    $self->func('s_separate_in_line'),
    $self->func('c_tag_handle'),
    $self->func('s_separate_in_line'),
    $self->func('ns_tag_prefix'),
  );
}
name 'ns_tag_directive', \&ns_tag_directive;



# [089]
# c-tag-handle ::=
#   c-named-tag-handle
#   | c-secondary-tag-handle
#   | c-primary-tag-handle

sub c_tag_handle {
  my ($self) = @_;
  debug1("c_tag_handle");
  $self->any(
    $self->func('c_named_tag_handle'),
    $self->func('c_secondary_tag_handle'),
    $self->func('c_primary_tag_handle'),
  );
}
name 'c_tag_handle', \&c_tag_handle;



# [090]
# c-primary-tag-handle ::=
#   '!'

sub c_primary_tag_handle {
  my ($self) = @_;
  debug1("c_primary_tag_handle");
  $self->chr('!');
}
name 'c_primary_tag_handle', \&c_primary_tag_handle;



# [091]
# c-secondary-tag-handle ::=
#   '!' '!'

sub c_secondary_tag_handle {
  my ($self) = @_;
  debug1("c_secondary_tag_handle");
  $self->all(
    $self->chr('!'),
    $self->chr('!'),
  );
}
name 'c_secondary_tag_handle', \&c_secondary_tag_handle;



# [092]
# c-named-tag-handle ::=
#   '!' ns-word-char+ '!'

sub c_named_tag_handle {
  my ($self) = @_;
  debug1("c_named_tag_handle");
  $self->all(
    $self->chr('!'),
    $self->rep(1, 0, $self->func('ns_word_char')),
    $self->chr('!'),
  );
}
name 'c_named_tag_handle', \&c_named_tag_handle;



# [093]
# ns-tag-prefix ::=
#   c-ns-local-tag-prefix | ns-global-tag-prefix

sub ns_tag_prefix {
  my ($self) = @_;
  debug1("ns_tag_prefix");
  $self->any(
    $self->func('c_ns_local_tag_prefix'),
    $self->func('ns_global_tag_prefix'),
  );
}
name 'ns_tag_prefix', \&ns_tag_prefix;



# [094]
# c-ns-local-tag-prefix ::=
#   '!' ns-uri-char*

sub c_ns_local_tag_prefix {
  my ($self) = @_;
  debug1("c_ns_local_tag_prefix");
  $self->all(
    $self->chr('!'),
    $self->rep(0, 0, $self->func('ns_uri_char')),
  );
}
name 'c_ns_local_tag_prefix', \&c_ns_local_tag_prefix;



# [095]
# ns-global-tag-prefix ::=
#   ns-tag-char ns-uri-char*

sub ns_global_tag_prefix {
  my ($self) = @_;
  debug1("ns_global_tag_prefix");
  $self->all(
    $self->func('ns_tag_char'),
    $self->rep(0, 0, $self->func('ns_uri_char')),
  );
}
name 'ns_global_tag_prefix', \&ns_global_tag_prefix;



# [096]
# c-ns-properties(n,c) ::=
#   ( c-ns-tag-property
#   ( s-separate(n,c) c-ns-anchor-property )? )
#   | ( c-ns-anchor-property
#   ( s-separate(n,c) c-ns-tag-property )? )

sub c_ns_properties {
  my ($self, $n, $c) = @_;
  debug1("c_ns_properties",$n,$c);
  $self->any(
    $self->all(
      $self->func('c_ns_tag_property'),
      $self->rep(0, 1,
        $self->all(
          [ $self->func('s_separate'), $n, $c ],
          $self->func('c_ns_anchor_property'),
        )),
    ),
    $self->all(
      $self->func('c_ns_anchor_property'),
      $self->rep(0, 1,
        $self->all(
          [ $self->func('s_separate'), $n, $c ],
          $self->func('c_ns_tag_property'),
        )),
    ),
  );
}
name 'c_ns_properties', \&c_ns_properties;



# [097]
# c-ns-tag-property ::=
#   c-verbatim-tag
#   | c-ns-shorthand-tag
#   | c-non-specific-tag

sub c_ns_tag_property {
  my ($self) = @_;
  debug1("c_ns_tag_property");
  $self->any(
    $self->func('c_verbatim_tag'),
    $self->func('c_ns_shorthand_tag'),
    $self->func('c_non_specific_tag'),
  );
}
name 'c_ns_tag_property', \&c_ns_tag_property;



# [098]
# c-verbatim-tag ::=
#   '!' '<' ns-uri-char+ '>'

sub c_verbatim_tag {
  my ($self) = @_;
  debug1("c_verbatim_tag");
  $self->all(
    $self->chr('!'),
    $self->chr('<'),
    $self->rep(1, 0, $self->func('ns_uri_char')),
    $self->chr('>'),
  );
}
name 'c_verbatim_tag', \&c_verbatim_tag;



# [099]
# c-ns-shorthand-tag ::=
#   c-tag-handle ns-tag-char+

sub c_ns_shorthand_tag {
  my ($self) = @_;
  debug1("c_ns_shorthand_tag");
  $self->all(
    $self->func('c_tag_handle'),
    $self->rep(1, 0, $self->func('ns_tag_char')),
  );
}
name 'c_ns_shorthand_tag', \&c_ns_shorthand_tag;



# [100]
# c-non-specific-tag ::=
#   '!'

sub c_non_specific_tag {
  my ($self) = @_;
  debug1("c_non_specific_tag");
  $self->chr('!');
}
name 'c_non_specific_tag', \&c_non_specific_tag;



# [101]
# c-ns-anchor-property ::=
#   '&' ns-anchor-name

sub c_ns_anchor_property {
  my ($self) = @_;
  debug1("c_ns_anchor_property");
  $self->all(
    $self->chr('&'),
    $self->func('ns_anchor_name'),
  );
}
name 'c_ns_anchor_property', \&c_ns_anchor_property;



# [102]
# ns-anchor-char ::=
#   ns-char - c-flow-indicator

sub ns_anchor_char {
  my ($self) = @_;
  debug1("ns_anchor_char");
  $self->but(
    $self->func('ns_char'),
    $self->func('c_flow_indicator'),
  );
}
name 'ns_anchor_char', \&ns_anchor_char;



# [103]
# ns-anchor-name ::=
#   ns-anchor-char+

sub ns_anchor_name {
  my ($self) = @_;
  debug1("ns_anchor_name");
  $self->rep(1, 0, $self->func('ns_anchor_char'));
}
name 'ns_anchor_name', \&ns_anchor_name;



# [104]
# c-ns-alias-node ::=
#   '*' ns-anchor-name

sub c_ns_alias_node {
  my ($self) = @_;
  debug1("c_ns_alias_node");
  $self->all(
    $self->chr('*'),
    $self->func('ns_anchor_name'),
  );
}
name 'c_ns_alias_node', \&c_ns_alias_node;



# [105]
# e-scalar ::=
#   <empty>

sub e_scalar {
  my ($self) = @_;
  debug1("e_scalar");
  $self->func('empty');
}
name 'e_scalar', \&e_scalar;



# [106]
# e-node ::=
#   e-scalar

sub e_node {
  my ($self) = @_;
  debug1("e_node");
  $self->func('e_scalar');
}
name 'e_node', \&e_node;



# [107]
# nb-double-char ::=
#   c-ns-esc-char | ( nb-json - '\' - '"' )

sub nb_double_char {
  my ($self) = @_;
  debug1("nb_double_char");
  $self->any(
    $self->func('c_ns_esc_char'),
    $self->but(
      $self->func('nb_json'),
      $self->chr("\\"),
      $self->chr('"'),
    ),
  );
}
name 'nb_double_char', \&nb_double_char;



# [108]
# ns-double-char ::=
#   nb-double-char - s-white

sub ns_double_char {
  my ($self) = @_;
  debug1("ns_double_char");
  $self->but(
    $self->func('nb_double_char'),
    $self->func('s_white'),
  );
}
name 'ns_double_char', \&ns_double_char;



# [109]
# c-double-quoted(n,c) ::=
#   '"' nb-double-text(n,c)
#   '"'

sub c_double_quoted {
  my ($self, $n, $c) = @_;
  debug1("c_double_quoted",$n,$c);
  $self->all(
    $self->chr('"'),
    [ $self->func('nb_double_text'), $n, $c ],
    $self->chr('"'),
  );
}
name 'c_double_quoted', \&c_double_quoted;



# [110]
# nb-double-text(n,c) ::=
#   ( c = flow-out => nb-double-multi-line(n) )
#   ( c = flow-in => nb-double-multi-line(n) )
#   ( c = block-key => nb-double-one-line )
#   ( c = flow-key => nb-double-one-line )

sub nb_double_text {
  my ($self, $n, $c) = @_;
  debug1("nb_double_text",$n,$c);
  $self->case($c, {
    'block-key' => $self->func('nb_double_one_line'),
    'flow-in' => [ $self->func('nb_double_multi_line'), $n ],
    'flow-key' => $self->func('nb_double_one_line'),
    'flow-out' => [ $self->func('nb_double_multi_line'), $n ],
  });
}
name 'nb_double_text', \&nb_double_text;



# [111]
# nb-double-one-line ::=
#   nb-double-char*

sub nb_double_one_line {
  my ($self) = @_;
  debug1("nb_double_one_line");
  $self->rep(0, 0, $self->func('nb_double_char'));
}
name 'nb_double_one_line', \&nb_double_one_line;



# [112]
# s-double-escaped(n) ::=
#   s-white* '\'
#   b-non-content
#   l-empty(n,flow-in)* s-flow-line-prefix(n)

sub s_double_escaped {
  my ($self, $n) = @_;
  debug1("s_double_escaped",$n);
  $self->all(
    $self->rep(0, 0, $self->func('s_white')),
    $self->chr("\\"),
    $self->func('b_non_content'),
    $self->rep(0, 0, [ $self->func('l_empty'), $n, "flow-in" ]),
    [ $self->func('s_flow_line_prefix'), $n ],
  );
}
name 's_double_escaped', \&s_double_escaped;



# [113]
# s-double-break(n) ::=
#   s-double-escaped(n) | s-flow-folded(n)

sub s_double_break {
  my ($self, $n) = @_;
  debug1("s_double_break",$n);
  $self->any(
    [ $self->func('s_double_escaped'), $n ],
    [ $self->func('s_flow_folded'), $n ],
  );
}
name 's_double_break', \&s_double_break;



# [114]
# nb-ns-double-in-line ::=
#   ( s-white* ns-double-char )*

sub nb_ns_double_in_line {
  my ($self) = @_;
  debug1("nb_ns_double_in_line");
  $self->rep(0, 0,
    $self->all(
      $self->rep(0, 0, $self->func('s_white')),
      $self->func('ns_double_char'),
    ));
}
name 'nb_ns_double_in_line', \&nb_ns_double_in_line;



# [115]
# s-double-next-line(n) ::=
#   s-double-break(n)
#   ( ns-double-char nb-ns-double-in-line
#   ( s-double-next-line(n) | s-white* ) )?

sub s_double_next_line {
  my ($self, $n) = @_;
  debug1("s_double_next_line",$n);
  $self->all(
    [ $self->func('s_double_break'), $n ],
    $self->rep(0, 1,
      $self->all(
        $self->func('ns_double_char'),
        $self->func('nb_ns_double_in_line'),
        $self->any(
          [ $self->func('s_double_next_line'), $n ],
          $self->rep(0, 0, $self->func('s_white')),
        ),
      )),
  );
}
name 's_double_next_line', \&s_double_next_line;



# [116]
# nb-double-multi-line(n) ::=
#   nb-ns-double-in-line
#   ( s-double-next-line(n) | s-white* )

sub nb_double_multi_line {
  my ($self, $n) = @_;
  debug1("nb_double_multi_line",$n);
  $self->all(
    $self->func('nb_ns_double_in_line'),
    $self->any(
      [ $self->func('s_double_next_line'), $n ],
      $self->rep(0, 0, $self->func('s_white')),
    ),
  );
}
name 'nb_double_multi_line', \&nb_double_multi_line;



# [117]
# c-quoted-quote ::=
#   ''' '''

sub c_quoted_quote {
  my ($self) = @_;
  debug1("c_quoted_quote");
  $self->all(
    $self->chr("'"),
    $self->chr("'"),
  );
}
name 'c_quoted_quote', \&c_quoted_quote;



# [118]
# nb-single-char ::=
#   c-quoted-quote | ( nb-json - ''' )

sub nb_single_char {
  my ($self) = @_;
  debug1("nb_single_char");
  $self->any(
    $self->func('c_quoted_quote'),
    $self->but(
      $self->func('nb_json'),
      $self->chr("'"),
    ),
  );
}
name 'nb_single_char', \&nb_single_char;



# [119]
# ns-single-char ::=
#   nb-single-char - s-white

sub ns_single_char {
  my ($self) = @_;
  debug1("ns_single_char");
  $self->but(
    $self->func('nb_single_char'),
    $self->func('s_white'),
  );
}
name 'ns_single_char', \&ns_single_char;



# [120]
# c-single-quoted(n,c) ::=
#   ''' nb-single-text(n,c)
#   '''

sub c_single_quoted {
  my ($self, $n, $c) = @_;
  debug1("c_single_quoted",$n,$c);
  $self->all(
    $self->chr("'"),
    [ $self->func('nb_single_text'), $n, $c ],
    $self->chr("'"),
  );
}
name 'c_single_quoted', \&c_single_quoted;



# [121]
# nb-single-text(n,c) ::=
#   ( c = flow-out => nb-single-multi-line(n) )
#   ( c = flow-in => nb-single-multi-line(n) )
#   ( c = block-key => nb-single-one-line )
#   ( c = flow-key => nb-single-one-line )

sub nb_single_text {
  my ($self, $n, $c) = @_;
  debug1("nb_single_text",$n,$c);
  $self->case($c, {
    'block-key' => $self->func('nb_single_one_line'),
    'flow-in' => [ $self->func('nb_single_multi_line'), $n ],
    'flow-key' => $self->func('nb_single_one_line'),
    'flow-out' => [ $self->func('nb_single_multi_line'), $n ],
  });
}
name 'nb_single_text', \&nb_single_text;



# [122]
# nb-single-one-line ::=
#   nb-single-char*

sub nb_single_one_line {
  my ($self) = @_;
  debug1("nb_single_one_line");
  $self->rep(0, 0, $self->func('nb_single_char'));
}
name 'nb_single_one_line', \&nb_single_one_line;



# [123]
# nb-ns-single-in-line ::=
#   ( s-white* ns-single-char )*

sub nb_ns_single_in_line {
  my ($self) = @_;
  debug1("nb_ns_single_in_line");
  $self->rep(0, 0,
    $self->all(
      $self->rep(0, 0, $self->func('s_white')),
      $self->func('ns_single_char'),
    ));
}
name 'nb_ns_single_in_line', \&nb_ns_single_in_line;



# [124]
# s-single-next-line(n) ::=
#   s-flow-folded(n)
#   ( ns-single-char nb-ns-single-in-line
#   ( s-single-next-line(n) | s-white* ) )?

sub s_single_next_line {
  my ($self, $n) = @_;
  debug1("s_single_next_line",$n);
  $self->all(
    [ $self->func('s_flow_folded'), $n ],
    $self->rep(0, 1,
      $self->all(
        $self->func('ns_single_char'),
        $self->func('nb_ns_single_in_line'),
        $self->any(
          [ $self->func('s_single_next_line'), $n ],
          $self->rep(0, 0, $self->func('s_white')),
        ),
      )),
  );
}
name 's_single_next_line', \&s_single_next_line;



# [125]
# nb-single-multi-line(n) ::=
#   nb-ns-single-in-line
#   ( s-single-next-line(n) | s-white* )

sub nb_single_multi_line {
  my ($self, $n) = @_;
  debug1("nb_single_multi_line",$n);
  $self->all(
    $self->func('nb_ns_single_in_line'),
    $self->any(
      [ $self->func('s_single_next_line'), $n ],
      $self->rep(0, 0, $self->func('s_white')),
    ),
  );
}
name 'nb_single_multi_line', \&nb_single_multi_line;



# [126]
# ns-plain-first(c) ::=
#   ( ns-char - c-indicator )
#   | ( ( '?' | ':' | '-' )
#   <followed_by_an_ns-plain-safe(c)> )

sub ns_plain_first {
  my ($self, $c) = @_;
  debug1("ns_plain_first",$c);
  $self->any(
    $self->but(
      $self->func('ns_char'),
      $self->func('c_indicator'),
    ),
    $self->all(
      $self->any(
        $self->chr('?'),
        $self->chr(':'),
        $self->chr('-'),
      ),
      $self->chk('=', [ $self->func('ns_plain_safe'), $c ]),
    ),
  );
}
name 'ns_plain_first', \&ns_plain_first;



# [127]
# ns-plain-safe(c) ::=
#   ( c = flow-out => ns-plain-safe-out )
#   ( c = flow-in => ns-plain-safe-in )
#   ( c = block-key => ns-plain-safe-out )
#   ( c = flow-key => ns-plain-safe-in )

sub ns_plain_safe {
  my ($self, $c) = @_;
  debug1("ns_plain_safe",$c);
  $self->case($c, {
    'block-key' => $self->func('ns_plain_safe_out'),
    'flow-in' => $self->func('ns_plain_safe_in'),
    'flow-key' => $self->func('ns_plain_safe_in'),
    'flow-out' => $self->func('ns_plain_safe_out'),
  });
}
name 'ns_plain_safe', \&ns_plain_safe;



# [128]
# ns-plain-safe-out ::=
#   ns-char

sub ns_plain_safe_out {
  my ($self) = @_;
  debug1("ns_plain_safe_out");
  $self->func('ns_char');
}
name 'ns_plain_safe_out', \&ns_plain_safe_out;



# [129]
# ns-plain-safe-in ::=
#   ns-char - c-flow-indicator

sub ns_plain_safe_in {
  my ($self) = @_;
  debug1("ns_plain_safe_in");
  $self->but(
    $self->func('ns_char'),
    $self->func('c_flow_indicator'),
  );
}
name 'ns_plain_safe_in', \&ns_plain_safe_in;



# [130]
# ns-plain-char(c) ::=
#   ( ns-plain-safe(c) - ':' - '#' )
#   | ( <an_ns-char_preceding> '#' )
#   | ( ':' <followed_by_an_ns-plain-safe(c)> )

sub ns_plain_char {
  my ($self, $c) = @_;
  debug1("ns_plain_char",$c);
  $self->any(
    $self->but(
      [ $self->func('ns_plain_safe'), $c ],
      $self->chr(':'),
      $self->chr('#'),
    ),
    $self->all(
      $self->chk('<=', $self->func('ns_char')),
      $self->chr('#'),
    ),
    $self->all(
      $self->chr(':'),
      $self->chk('=', [ $self->func('ns_plain_safe'), $c ]),
    ),
  );
}
name 'ns_plain_char', \&ns_plain_char;



# [131]
# ns-plain(n,c) ::=
#   ( c = flow-out => ns-plain-multi-line(n,c) )
#   ( c = flow-in => ns-plain-multi-line(n,c) )
#   ( c = block-key => ns-plain-one-line(c) )
#   ( c = flow-key => ns-plain-one-line(c) )

sub ns_plain {
  my ($self, $n, $c) = @_;
  debug1("ns_plain",$n,$c);
  $self->case($c, {
    'block-key' => [ $self->func('ns_plain_one_line'), $c ],
    'flow-in' => [ $self->func('ns_plain_multi_line'), $n, $c ],
    'flow-key' => [ $self->func('ns_plain_one_line'), $c ],
    'flow-out' => [ $self->func('ns_plain_multi_line'), $n, $c ],
  });
}
name 'ns_plain', \&ns_plain;



# [132]
# nb-ns-plain-in-line(c) ::=
#   ( s-white*
#   ns-plain-char(c) )*

sub nb_ns_plain_in_line {
  my ($self, $c) = @_;
  debug1("nb_ns_plain_in_line",$c);
  $self->rep(0, 0,
    $self->all(
      $self->rep(0, 0, $self->func('s_white')),
      [ $self->func('ns_plain_char'), $c ],
    ));
}
name 'nb_ns_plain_in_line', \&nb_ns_plain_in_line;



# [133]
# ns-plain-one-line(c) ::=
#   ns-plain-first(c)
#   nb-ns-plain-in-line(c)

sub ns_plain_one_line {
  my ($self, $c) = @_;
  debug1("ns_plain_one_line",$c);
  $self->all(
    [ $self->func('ns_plain_first'), $c ],
    [ $self->func('nb_ns_plain_in_line'), $c ],
  );
}
name 'ns_plain_one_line', \&ns_plain_one_line;



# [134]
# s-ns-plain-next-line(n,c) ::=
#   s-flow-folded(n)
#   ns-plain-char(c) nb-ns-plain-in-line(c)

sub s_ns_plain_next_line {
  my ($self, $n, $c) = @_;
  debug1("s_ns_plain_next_line",$n,$c);
  $self->all(
    [ $self->func('s_flow_folded'), $n ],
    [ $self->func('ns_plain_char'), $c ],
    [ $self->func('nb_ns_plain_in_line'), $c ],
  );
}
name 's_ns_plain_next_line', \&s_ns_plain_next_line;



# [135]
# ns-plain-multi-line(n,c) ::=
#   ns-plain-one-line(c)
#   s-ns-plain-next-line(n,c)*

sub ns_plain_multi_line {
  my ($self, $n, $c) = @_;
  debug1("ns_plain_multi_line",$n,$c);
  $self->all(
    [ $self->func('ns_plain_one_line'), $c ],
    $self->rep(0, 0, [ $self->func('s_ns_plain_next_line'), $n, $c ]),
  );
}
name 'ns_plain_multi_line', \&ns_plain_multi_line;



# [136]
# in-flow(c) ::=
#   ( c = flow-out => flow-in )
#   ( c = flow-in => flow-in )
#   ( c = block-key => flow-key )
#   ( c = flow-key => flow-key )

sub in_flow {
  my ($self, $c) = @_;
  debug1("in_flow",$c);
  $self->flip($c, {
    'block-key' => "flow-key",
    'flow-in' => "flow-in",
    'flow-key' => "flow-key",
    'flow-out' => "flow-in",
  });
}
name 'in_flow', \&in_flow;



# [137]
# c-flow-sequence(n,c) ::=
#   '[' s-separate(n,c)?
#   ns-s-flow-seq-entries(n,in-flow(c))? ']'

sub c_flow_sequence {
  my ($self, $n, $c) = @_;
  debug1("c_flow_sequence",$n,$c);
  $self->all(
    $self->chr('['),
    $self->rep(0, 1, [ $self->func('s_separate'), $n, $c ]),
    $self->rep(0, 1, [ $self->func('ns_s_flow_seq_entries'), $n, [ $self->func('in_flow'), $c ] ]),
    $self->chr(']'),
  );
}
name 'c_flow_sequence', \&c_flow_sequence;



# [138]
# ns-s-flow-seq-entries(n,c) ::=
#   ns-flow-seq-entry(n,c)
#   s-separate(n,c)?
#   ( ',' s-separate(n,c)?
#   ns-s-flow-seq-entries(n,c)? )?

sub ns_s_flow_seq_entries {
  my ($self, $n, $c) = @_;
  debug1("ns_s_flow_seq_entries",$n,$c);
  $self->all(
    [ $self->func('ns_flow_seq_entry'), $n, $c ],
    $self->rep(0, 1, [ $self->func('s_separate'), $n, $c ]),
    $self->rep(0, 1,
      $self->all(
        $self->chr(','),
        $self->rep(0, 1, [ $self->func('s_separate'), $n, $c ]),
        $self->rep(0, 1, [ $self->func('ns_s_flow_seq_entries'), $n, $c ]),
      )),
  );
}
name 'ns_s_flow_seq_entries', \&ns_s_flow_seq_entries;



# [139]
# ns-flow-seq-entry(n,c) ::=
#   ns-flow-pair(n,c) | ns-flow-node(n,c)

sub ns_flow_seq_entry {
  my ($self, $n, $c) = @_;
  debug1("ns_flow_seq_entry",$n,$c);
  $self->any(
    [ $self->func('ns_flow_pair'), $n, $c ],
    [ $self->func('ns_flow_node'), $n, $c ],
  );
}
name 'ns_flow_seq_entry', \&ns_flow_seq_entry;



# [140]
# c-flow-mapping(n,c) ::=
#   '{' s-separate(n,c)?
#   ns-s-flow-map-entries(n,in-flow(c))? '}'

sub c_flow_mapping {
  my ($self, $n, $c) = @_;
  debug1("c_flow_mapping",$n,$c);
  $self->all(
    $self->chr('{'),
    $self->rep(0, 1, [ $self->func('s_separate'), $n, $c ]),
    $self->rep(0, 1, [ $self->func('ns_s_flow_map_entries'), $n, [ $self->func('in_flow'), $c ] ]),
    $self->chr('}'),
  );
}
name 'c_flow_mapping', \&c_flow_mapping;



# [141]
# ns-s-flow-map-entries(n,c) ::=
#   ns-flow-map-entry(n,c)
#   s-separate(n,c)?
#   ( ',' s-separate(n,c)?
#   ns-s-flow-map-entries(n,c)? )?

sub ns_s_flow_map_entries {
  my ($self, $n, $c) = @_;
  debug1("ns_s_flow_map_entries",$n,$c);
  $self->all(
    [ $self->func('ns_flow_map_entry'), $n, $c ],
    $self->rep(0, 1, [ $self->func('s_separate'), $n, $c ]),
    $self->rep(0, 1,
      $self->all(
        $self->chr(','),
        $self->rep(0, 1, [ $self->func('s_separate'), $n, $c ]),
        $self->rep(0, 1, [ $self->func('ns_s_flow_map_entries'), $n, $c ]),
      )),
  );
}
name 'ns_s_flow_map_entries', \&ns_s_flow_map_entries;



# [142]
# ns-flow-map-entry(n,c) ::=
#   ( '?' s-separate(n,c)
#   ns-flow-map-explicit-entry(n,c) )
#   | ns-flow-map-implicit-entry(n,c)

sub ns_flow_map_entry {
  my ($self, $n, $c) = @_;
  debug1("ns_flow_map_entry",$n,$c);
  $self->any(
    $self->all(
      $self->chr('?'),
      [ $self->func('s_separate'), $n, $c ],
      [ $self->func('ns_flow_map_explicit_entry'), $n, $c ],
    ),
    [ $self->func('ns_flow_map_implicit_entry'), $n, $c ],
  );
}
name 'ns_flow_map_entry', \&ns_flow_map_entry;



# [143]
# ns-flow-map-explicit-entry(n,c) ::=
#   ns-flow-map-implicit-entry(n,c)
#   | ( e-node
#   e-node )

sub ns_flow_map_explicit_entry {
  my ($self, $n, $c) = @_;
  debug1("ns_flow_map_explicit_entry",$n,$c);
  $self->any(
    [ $self->func('ns_flow_map_implicit_entry'), $n, $c ],
    $self->all(
      $self->func('e_node'),
      $self->func('e_node'),
    ),
  );
}
name 'ns_flow_map_explicit_entry', \&ns_flow_map_explicit_entry;



# [144]
# ns-flow-map-implicit-entry(n,c) ::=
#   ns-flow-map-yaml-key-entry(n,c)
#   | c-ns-flow-map-empty-key-entry(n,c)
#   | c-ns-flow-map-json-key-entry(n,c)

sub ns_flow_map_implicit_entry {
  my ($self, $n, $c) = @_;
  debug1("ns_flow_map_implicit_entry",$n,$c);
  $self->any(
    [ $self->func('ns_flow_map_yaml_key_entry'), $n, $c ],
    [ $self->func('c_ns_flow_map_empty_key_entry'), $n, $c ],
    [ $self->func('c_ns_flow_map_json_key_entry'), $n, $c ],
  );
}
name 'ns_flow_map_implicit_entry', \&ns_flow_map_implicit_entry;



# [145]
# ns-flow-map-yaml-key-entry(n,c) ::=
#   ns-flow-yaml-node(n,c)
#   ( ( s-separate(n,c)?
#   c-ns-flow-map-separate-value(n,c) )
#   | e-node )

sub ns_flow_map_yaml_key_entry {
  my ($self, $n, $c) = @_;
  debug1("ns_flow_map_yaml_key_entry",$n,$c);
  $self->all(
    [ $self->func('ns_flow_yaml_node'), $n, $c ],
    $self->any(
      $self->all(
        $self->rep(0, 1, [ $self->func('s_separate'), $n, $c ]),
        [ $self->func('c_ns_flow_map_separate_value'), $n, $c ],
      ),
      $self->func('e_node'),
    ),
  );
}
name 'ns_flow_map_yaml_key_entry', \&ns_flow_map_yaml_key_entry;



# [146]
# c-ns-flow-map-empty-key-entry(n,c) ::=
#   e-node
#   c-ns-flow-map-separate-value(n,c)

sub c_ns_flow_map_empty_key_entry {
  my ($self, $n, $c) = @_;
  debug1("c_ns_flow_map_empty_key_entry",$n,$c);
  $self->all(
    $self->func('e_node'),
    [ $self->func('c_ns_flow_map_separate_value'), $n, $c ],
  );
}
name 'c_ns_flow_map_empty_key_entry', \&c_ns_flow_map_empty_key_entry;



# [147]
# c-ns-flow-map-separate-value(n,c) ::=
#   ':' <not_followed_by_an_ns-plain-safe(c)>
#   ( ( s-separate(n,c) ns-flow-node(n,c) )
#   | e-node )

sub c_ns_flow_map_separate_value {
  my ($self, $n, $c) = @_;
  debug1("c_ns_flow_map_separate_value",$n,$c);
  $self->all(
    $self->chr(':'),
    $self->chk('!', [ $self->func('ns_plain_safe'), $c ]),
    $self->any(
      $self->all(
        [ $self->func('s_separate'), $n, $c ],
        [ $self->func('ns_flow_node'), $n, $c ],
      ),
      $self->func('e_node'),
    ),
  );
}
name 'c_ns_flow_map_separate_value', \&c_ns_flow_map_separate_value;



# [148]
# c-ns-flow-map-json-key-entry(n,c) ::=
#   c-flow-json-node(n,c)
#   ( ( s-separate(n,c)?
#   c-ns-flow-map-adjacent-value(n,c) )
#   | e-node )

sub c_ns_flow_map_json_key_entry {
  my ($self, $n, $c) = @_;
  debug1("c_ns_flow_map_json_key_entry",$n,$c);
  $self->all(
    [ $self->func('c_flow_json_node'), $n, $c ],
    $self->any(
      $self->all(
        $self->rep(0, 1, [ $self->func('s_separate'), $n, $c ]),
        [ $self->func('c_ns_flow_map_adjacent_value'), $n, $c ],
      ),
      $self->func('e_node'),
    ),
  );
}
name 'c_ns_flow_map_json_key_entry', \&c_ns_flow_map_json_key_entry;



# [149]
# c-ns-flow-map-adjacent-value(n,c) ::=
#   ':' ( (
#   s-separate(n,c)?
#   ns-flow-node(n,c) )
#   | e-node )

sub c_ns_flow_map_adjacent_value {
  my ($self, $n, $c) = @_;
  debug1("c_ns_flow_map_adjacent_value",$n,$c);
  $self->all(
    $self->chr(':'),
    $self->any(
      $self->all(
        $self->rep(0, 1, [ $self->func('s_separate'), $n, $c ]),
        [ $self->func('ns_flow_node'), $n, $c ],
      ),
      $self->func('e_node'),
    ),
  );
}
name 'c_ns_flow_map_adjacent_value', \&c_ns_flow_map_adjacent_value;



# [150]
# ns-flow-pair(n,c) ::=
#   ( '?' s-separate(n,c)
#   ns-flow-map-explicit-entry(n,c) )
#   | ns-flow-pair-entry(n,c)

sub ns_flow_pair {
  my ($self, $n, $c) = @_;
  debug1("ns_flow_pair",$n,$c);
  $self->any(
    $self->all(
      $self->chr('?'),
      [ $self->func('s_separate'), $n, $c ],
      [ $self->func('ns_flow_map_explicit_entry'), $n, $c ],
    ),
    [ $self->func('ns_flow_pair_entry'), $n, $c ],
  );
}
name 'ns_flow_pair', \&ns_flow_pair;



# [151]
# ns-flow-pair-entry(n,c) ::=
#   ns-flow-pair-yaml-key-entry(n,c)
#   | c-ns-flow-map-empty-key-entry(n,c)
#   | c-ns-flow-pair-json-key-entry(n,c)

sub ns_flow_pair_entry {
  my ($self, $n, $c) = @_;
  debug1("ns_flow_pair_entry",$n,$c);
  $self->any(
    [ $self->func('ns_flow_pair_yaml_key_entry'), $n, $c ],
    [ $self->func('c_ns_flow_map_empty_key_entry'), $n, $c ],
    [ $self->func('c_ns_flow_pair_json_key_entry'), $n, $c ],
  );
}
name 'ns_flow_pair_entry', \&ns_flow_pair_entry;



# [152]
# ns-flow-pair-yaml-key-entry(n,c) ::=
#   ns-s-implicit-yaml-key(flow-key)
#   c-ns-flow-map-separate-value(n,c)

sub ns_flow_pair_yaml_key_entry {
  my ($self, $n, $c) = @_;
  debug1("ns_flow_pair_yaml_key_entry",$n,$c);
  $self->all(
    [ $self->func('ns_s_implicit_yaml_key'), "flow-key" ],
    [ $self->func('c_ns_flow_map_separate_value'), $n, $c ],
  );
}
name 'ns_flow_pair_yaml_key_entry', \&ns_flow_pair_yaml_key_entry;



# [153]
# c-ns-flow-pair-json-key-entry(n,c) ::=
#   c-s-implicit-json-key(flow-key)
#   c-ns-flow-map-adjacent-value(n,c)

sub c_ns_flow_pair_json_key_entry {
  my ($self, $n, $c) = @_;
  debug1("c_ns_flow_pair_json_key_entry",$n,$c);
  $self->all(
    [ $self->func('c_s_implicit_json_key'), "flow-key" ],
    [ $self->func('c_ns_flow_map_adjacent_value'), $n, $c ],
  );
}
name 'c_ns_flow_pair_json_key_entry', \&c_ns_flow_pair_json_key_entry;



# [154]
# ns-s-implicit-yaml-key(c) ::=
#   ns-flow-yaml-node(n/a,c)
#   s-separate-in-line?
#   <at_most_1024_characters_altogether>

sub ns_s_implicit_yaml_key {
  my ($self, $c) = @_;
  debug1("ns_s_implicit_yaml_key",$c);
  $self->all(
    $self->max(1024),
    [ $self->func('ns_flow_yaml_node'), undef, $c ],
    $self->rep(0, 1, $self->func('s_separate_in_line')),
  );
}
name 'ns_s_implicit_yaml_key', \&ns_s_implicit_yaml_key;



# [155]
# c-s-implicit-json-key(c) ::=
#   c-flow-json-node(n/a,c)
#   s-separate-in-line?
#   <at_most_1024_characters_altogether>

sub c_s_implicit_json_key {
  my ($self, $c) = @_;
  debug1("c_s_implicit_json_key",$c);
  $self->all(
    $self->max(1024),
    [ $self->func('c_flow_json_node'), undef, $c ],
    $self->rep(0, 1, $self->func('s_separate_in_line')),
  );
}
name 'c_s_implicit_json_key', \&c_s_implicit_json_key;



# [156]
# ns-flow-yaml-content(n,c) ::=
#   ns-plain(n,c)

sub ns_flow_yaml_content {
  my ($self, $n, $c) = @_;
  debug1("ns_flow_yaml_content",$n,$c);
  [ $self->func('ns_plain'), $n, $c ];
}
name 'ns_flow_yaml_content', \&ns_flow_yaml_content;



# [157]
# c-flow-json-content(n,c) ::=
#   c-flow-sequence(n,c) | c-flow-mapping(n,c)
#   | c-single-quoted(n,c) | c-double-quoted(n,c)

sub c_flow_json_content {
  my ($self, $n, $c) = @_;
  debug1("c_flow_json_content",$n,$c);
  $self->any(
    [ $self->func('c_flow_sequence'), $n, $c ],
    [ $self->func('c_flow_mapping'), $n, $c ],
    [ $self->func('c_single_quoted'), $n, $c ],
    [ $self->func('c_double_quoted'), $n, $c ],
  );
}
name 'c_flow_json_content', \&c_flow_json_content;



# [158]
# ns-flow-content(n,c) ::=
#   ns-flow-yaml-content(n,c) | c-flow-json-content(n,c)

sub ns_flow_content {
  my ($self, $n, $c) = @_;
  debug1("ns_flow_content",$n,$c);
  $self->any(
    [ $self->func('ns_flow_yaml_content'), $n, $c ],
    [ $self->func('c_flow_json_content'), $n, $c ],
  );
}
name 'ns_flow_content', \&ns_flow_content;



# [159]
# ns-flow-yaml-node(n,c) ::=
#   c-ns-alias-node
#   | ns-flow-yaml-content(n,c)
#   | ( c-ns-properties(n,c)
#   ( ( s-separate(n,c)
#   ns-flow-yaml-content(n,c) )
#   | e-scalar ) )

sub ns_flow_yaml_node {
  my ($self, $n, $c) = @_;
  debug1("ns_flow_yaml_node",$n,$c);
  $self->any(
    $self->func('c_ns_alias_node'),
    [ $self->func('ns_flow_yaml_content'), $n, $c ],
    $self->all(
      [ $self->func('c_ns_properties'), $n, $c ],
      $self->any(
        $self->all(
          [ $self->func('s_separate'), $n, $c ],
          [ $self->func('ns_flow_yaml_content'), $n, $c ],
        ),
        $self->func('e_scalar'),
      ),
    ),
  );
}
name 'ns_flow_yaml_node', \&ns_flow_yaml_node;



# [160]
# c-flow-json-node(n,c) ::=
#   ( c-ns-properties(n,c)
#   s-separate(n,c) )?
#   c-flow-json-content(n,c)

sub c_flow_json_node {
  my ($self, $n, $c) = @_;
  debug1("c_flow_json_node",$n,$c);
  $self->all(
    $self->rep(0, 1,
      $self->all(
        [ $self->func('c_ns_properties'), $n, $c ],
        [ $self->func('s_separate'), $n, $c ],
      )),
    [ $self->func('c_flow_json_content'), $n, $c ],
  );
}
name 'c_flow_json_node', \&c_flow_json_node;



# [161]
# ns-flow-node(n,c) ::=
#   c-ns-alias-node
#   | ns-flow-content(n,c)
#   | ( c-ns-properties(n,c)
#   ( ( s-separate(n,c)
#   ns-flow-content(n,c) )
#   | e-scalar ) )

sub ns_flow_node {
  my ($self, $n, $c) = @_;
  debug1("ns_flow_node",$n,$c);
  $self->any(
    $self->func('c_ns_alias_node'),
    [ $self->func('ns_flow_content'), $n, $c ],
    $self->all(
      [ $self->func('c_ns_properties'), $n, $c ],
      $self->any(
        $self->all(
          [ $self->func('s_separate'), $n, $c ],
          [ $self->func('ns_flow_content'), $n, $c ],
        ),
        $self->func('e_scalar'),
      ),
    ),
  );
}
name 'ns_flow_node', \&ns_flow_node;



# [162]
# c-b-block-header(m,t) ::=
#   ( ( c-indentation-indicator(m)
#   c-chomping-indicator(t) )
#   | ( c-chomping-indicator(t)
#   c-indentation-indicator(m) ) )
#   s-b-comment

sub c_b_block_header {
  my ($self, $m, $t) = @_;
  debug1("c_b_block_header",$m,$t);
  $self->all(
    $self->any(
      $self->all(
        [ $self->func('c_indentation_indicator'), $m ],
        [ $self->func('c_chomping_indicator'), $t ],
      ),
      $self->all(
        [ $self->func('c_chomping_indicator'), $t ],
        [ $self->func('c_indentation_indicator'), $m ],
      ),
    ),
    $self->func('s_b_comment'),
  );
}
name 'c_b_block_header', \&c_b_block_header;



# [163]
# c-indentation-indicator(m) ::=
#   ( ns-dec-digit => m = ns-dec-digit - x:30 )
#   ( <empty> => m = auto-detect() )

sub c_indentation_indicator {
  my ($self, $m) = @_;
  debug1("c_indentation_indicator",$m);
  $self->any(
    $self->if($self->func('ns_dec_digit'), $self->set('m', $self->ord($self->func('match')))),
    $self->if($self->func('empty'), $self->set('m', "auto-detect")),
  );
}
name 'c_indentation_indicator', \&c_indentation_indicator;



# [164]
# c-chomping-indicator(t) ::=
#   ( '-' => t = strip )
#   ( '+' => t = keep )
#   ( <empty> => t = clip )

sub c_chomping_indicator {
  my ($self, $t) = @_;
  debug1("c_chomping_indicator",$t);
  $self->any(
    $self->if($self->chr('-'), $self->set('t', "strip")),
    $self->if($self->chr('+'), $self->set('t', "keep")),
    $self->if($self->func('empty'), $self->set('t', "clip")),
  );
}
name 'c_chomping_indicator', \&c_chomping_indicator;



# [165]
# b-chomped-last(t) ::=
#   ( t = strip => b-non-content | <end_of_file> )
#   ( t = clip => b-as-line-feed | <end_of_file> )
#   ( t = keep => b-as-line-feed | <end_of_file> )

sub b_chomped_last {
  my ($self, $t) = @_;
  debug1("b_chomped_last",$t);
  $self->case($t, {
    'clip' => $self->any( $self->func('b_as_line_feed'), $self->func('end_of_stream') ),
    'keep' => $self->any( $self->func('b_as_line_feed'), $self->func('end_of_stream') ),
    'strip' => $self->any( $self->func('b_non_content'), $self->func('end_of_stream') ),
  });
}
name 'b_chomped_last', \&b_chomped_last;



# [166]
# l-chomped-empty(n,t) ::=
#   ( t = strip => l-strip-empty(n) )
#   ( t = clip => l-strip-empty(n) )
#   ( t = keep => l-keep-empty(n) )

sub l_chomped_empty {
  my ($self, $n, $t) = @_;
  debug1("l_chomped_empty",$n,$t);
  $self->case($t, {
    'clip' => [ $self->func('l_strip_empty'), $n ],
    'keep' => [ $self->func('l_keep_empty'), $n ],
    'strip' => [ $self->func('l_strip_empty'), $n ],
  });
}
name 'l_chomped_empty', \&l_chomped_empty;



# [167]
# l-strip-empty(n) ::=
#   ( s-indent(<=n) b-non-content )*
#   l-trail-comments(n)?

sub l_strip_empty {
  my ($self, $n) = @_;
  debug1("l_strip_empty",$n);
  $self->all(
    $self->rep(0, 0,
      $self->all(
        [ $self->func('s_indent_le'), $n ],
        $self->func('b_non_content'),
      )),
    $self->rep(0, 1, [ $self->func('l_trail_comments'), $n ]),
  );
}
name 'l_strip_empty', \&l_strip_empty;



# [168]
# l-keep-empty(n) ::=
#   l-empty(n,block-in)*
#   l-trail-comments(n)?

sub l_keep_empty {
  my ($self, $n) = @_;
  debug1("l_keep_empty",$n);
  $self->all(
    $self->rep(0, 0, [ $self->func('l_empty'), $n, "block-in" ]),
    $self->rep(0, 1, [ $self->func('l_trail_comments'), $n ]),
  );
}
name 'l_keep_empty', \&l_keep_empty;



# [169]
# l-trail-comments(n) ::=
#   s-indent(<n)
#   c-nb-comment-text b-comment
#   l-comment*

sub l_trail_comments {
  my ($self, $n) = @_;
  debug1("l_trail_comments",$n);
  $self->all(
    [ $self->func('s_indent_lt'), $n ],
    $self->func('c_nb_comment_text'),
    $self->func('b_comment'),
    $self->rep(0, 0, $self->func('l_comment')),
  );
}
name 'l_trail_comments', \&l_trail_comments;



# [170]
# c-l+literal(n) ::=
#   '|' c-b-block-header(m,t)
#   l-literal-content(n+m,t)

sub c_l_literal {
  my ($self, $n) = @_;
  debug1("c_l_literal",$n);
  $self->all(
    $self->chr('|'),
    [ $self->func('c_b_block_header'), $self->m, $self->t ],
    [ $self->func('l_literal_content'), $self->add($n, $self->m), $self->t ],
  );
}
name 'c_l_literal', \&c_l_literal;



# [171]
# l-nb-literal-text(n) ::=
#   l-empty(n,block-in)*
#   s-indent(n) nb-char+

sub l_nb_literal_text {
  my ($self, $n) = @_;
  debug1("l_nb_literal_text",$n);
  $self->all(
    $self->rep(0, 0, [ $self->func('l_empty'), $n, "block-in" ]),
    [ $self->func('s_indent'), $n ],
    $self->rep(1, 0, $self->func('nb_char')),
  );
}
name 'l_nb_literal_text', \&l_nb_literal_text;



# [172]
# b-nb-literal-next(n) ::=
#   b-as-line-feed
#   l-nb-literal-text(n)

sub b_nb_literal_next {
  my ($self, $n) = @_;
  debug1("b_nb_literal_next",$n);
  $self->all(
    $self->func('b_as_line_feed'),
    [ $self->func('l_nb_literal_text'), $n ],
  );
}
name 'b_nb_literal_next', \&b_nb_literal_next;



# [173]
# l-literal-content(n,t) ::=
#   ( l-nb-literal-text(n)
#   b-nb-literal-next(n)*
#   b-chomped-last(t) )?
#   l-chomped-empty(n,t)

sub l_literal_content {
  my ($self, $n, $t) = @_;
  debug1("l_literal_content",$n,$t);
  $self->all(
    $self->rep(0, 1,
      $self->all(
        [ $self->func('l_nb_literal_text'), $n ],
        $self->rep(0, 0, [ $self->func('b_nb_literal_next'), $n ]),
        [ $self->func('b_chomped_last'), $t ],
      )),
    [ $self->func('l_chomped_empty'), $n, $t ],
  );
}
name 'l_literal_content', \&l_literal_content;



# [174]
# c-l+folded(n) ::=
#   '>' c-b-block-header(m,t)
#   l-folded-content(n+m,t)

sub c_l_folded {
  my ($self, $n) = @_;
  debug1("c_l_folded",$n);
  $self->all(
    $self->chr('>'),
    [ $self->func('c_b_block_header'), $self->m, $self->t ],
    [ $self->func('l_folded_content'), $self->add($n, $self->m), $self->t ],
  );
}
name 'c_l_folded', \&c_l_folded;



# [175]
# s-nb-folded-text(n) ::=
#   s-indent(n) ns-char
#   nb-char*

sub s_nb_folded_text {
  my ($self, $n) = @_;
  debug1("s_nb_folded_text",$n);
  $self->all(
    [ $self->func('s_indent'), $n ],
    $self->func('ns_char'),
    $self->rep(0, 0, $self->func('nb_char')),
  );
}
name 's_nb_folded_text', \&s_nb_folded_text;



# [176]
# l-nb-folded-lines(n) ::=
#   s-nb-folded-text(n)
#   ( b-l-folded(n,block-in) s-nb-folded-text(n) )*

sub l_nb_folded_lines {
  my ($self, $n) = @_;
  debug1("l_nb_folded_lines",$n);
  $self->all(
    [ $self->func('s_nb_folded_text'), $n ],
    $self->rep(0, 0,
      $self->all(
        [ $self->func('b_l_folded'), $n, "block-in" ],
        [ $self->func('s_nb_folded_text'), $n ],
      )),
  );
}
name 'l_nb_folded_lines', \&l_nb_folded_lines;



# [177]
# s-nb-spaced-text(n) ::=
#   s-indent(n) s-white
#   nb-char*

sub s_nb_spaced_text {
  my ($self, $n) = @_;
  debug1("s_nb_spaced_text",$n);
  $self->all(
    [ $self->func('s_indent'), $n ],
    $self->func('s_white'),
    $self->rep(0, 0, $self->func('nb_char')),
  );
}
name 's_nb_spaced_text', \&s_nb_spaced_text;



# [178]
# b-l-spaced(n) ::=
#   b-as-line-feed
#   l-empty(n,block-in)*

sub b_l_spaced {
  my ($self, $n) = @_;
  debug1("b_l_spaced",$n);
  $self->all(
    $self->func('b_as_line_feed'),
    $self->rep(0, 0, [ $self->func('l_empty'), $n, "block-in" ]),
  );
}
name 'b_l_spaced', \&b_l_spaced;



# [179]
# l-nb-spaced-lines(n) ::=
#   s-nb-spaced-text(n)
#   ( b-l-spaced(n) s-nb-spaced-text(n) )*

sub l_nb_spaced_lines {
  my ($self, $n) = @_;
  debug1("l_nb_spaced_lines",$n);
  $self->all(
    [ $self->func('s_nb_spaced_text'), $n ],
    $self->rep(0, 0,
      $self->all(
        [ $self->func('b_l_spaced'), $n ],
        [ $self->func('s_nb_spaced_text'), $n ],
      )),
  );
}
name 'l_nb_spaced_lines', \&l_nb_spaced_lines;



# [180]
# l-nb-same-lines(n) ::=
#   l-empty(n,block-in)*
#   ( l-nb-folded-lines(n) | l-nb-spaced-lines(n) )

sub l_nb_same_lines {
  my ($self, $n) = @_;
  debug1("l_nb_same_lines",$n);
  $self->all(
    $self->rep(0, 0, [ $self->func('l_empty'), $n, "block-in" ]),
    $self->any(
      [ $self->func('l_nb_folded_lines'), $n ],
      [ $self->func('l_nb_spaced_lines'), $n ],
    ),
  );
}
name 'l_nb_same_lines', \&l_nb_same_lines;



# [181]
# l-nb-diff-lines(n) ::=
#   l-nb-same-lines(n)
#   ( b-as-line-feed l-nb-same-lines(n) )*

sub l_nb_diff_lines {
  my ($self, $n) = @_;
  debug1("l_nb_diff_lines",$n);
  $self->all(
    [ $self->func('l_nb_same_lines'), $n ],
    $self->rep(0, 0,
      $self->all(
        $self->func('b_as_line_feed'),
        [ $self->func('l_nb_same_lines'), $n ],
      )),
  );
}
name 'l_nb_diff_lines', \&l_nb_diff_lines;



# [182]
# l-folded-content(n,t) ::=
#   ( l-nb-diff-lines(n)
#   b-chomped-last(t) )?
#   l-chomped-empty(n,t)

sub l_folded_content {
  my ($self, $n, $t) = @_;
  debug1("l_folded_content",$n,$t);
  $self->all(
    $self->rep(0, 1,
      $self->all(
        [ $self->func('l_nb_diff_lines'), $n ],
        [ $self->func('b_chomped_last'), $t ],
      )),
    [ $self->func('l_chomped_empty'), $n, $t ],
  );
}
name 'l_folded_content', \&l_folded_content;



# [183]
# l+block-sequence(n) ::=
#   ( s-indent(n+m)
#   c-l-block-seq-entry(n+m) )+
#   <for_some_fixed_auto-detected_m_>_0>

sub l_block_sequence {
  my ($self, $n) = @_;
  debug1("l_block_sequence",$n);
  $self->all(
    $self->set('m', $self->func('auto_detect_indent')),
    $self->rep(1, 0,
      $self->all(
        [ $self->func('s_indent'), $self->add($n, $self->m) ],
        [ $self->func('c_l_block_seq_entry'), $self->add($n, $self->m) ],
      )),
  );
}
name 'l_block_sequence', \&l_block_sequence;



# [184]
# c-l-block-seq-entry(n) ::=
#   '-' <not_followed_by_an_ns-char>
#   s-l+block-indented(n,block-in)

sub c_l_block_seq_entry {
  my ($self, $n) = @_;
  debug1("c_l_block_seq_entry",$n);
  $self->all(
    $self->chr('-'),
    $self->chk('!', $self->func('ns_char')),
    [ $self->func('s_l_block_indented'), $n, "block-in" ],
  );
}
name 'c_l_block_seq_entry', \&c_l_block_seq_entry;



# [185]
# s-l+block-indented(n,c) ::=
#   ( s-indent(m)
#   ( ns-l-compact-sequence(n+1+m)
#   | ns-l-compact-mapping(n+1+m) ) )
#   | s-l+block-node(n,c)
#   | ( e-node s-l-comments )

sub s_l_block_indented {
  my ($self, $n, $c) = @_;
  debug1("s_l_block_indented",$n,$c);
  $self->any(
    $self->all(
      [ $self->func('s_indent'), $self->m ],
      $self->any(
        [ $self->func('ns_l_compact_sequence'), $self->add($n, $self->add(1, $self->m)) ],
        [ $self->func('ns_l_compact_mapping'), $self->add($n, $self->add(1, $self->m)) ],
      ),
    ),
    [ $self->func('s_l_block_node'), $n, $c ],
    $self->all(
      $self->func('e_node'),
      $self->func('s_l_comments'),
    ),
  );
}
name 's_l_block_indented', \&s_l_block_indented;



# [186]
# ns-l-compact-sequence(n) ::=
#   c-l-block-seq-entry(n)
#   ( s-indent(n) c-l-block-seq-entry(n) )*

sub ns_l_compact_sequence {
  my ($self, $n) = @_;
  debug1("ns_l_compact_sequence",$n);
  $self->all(
    [ $self->func('c_l_block_seq_entry'), $n ],
    $self->rep(0, 0,
      $self->all(
        [ $self->func('s_indent'), $n ],
        [ $self->func('c_l_block_seq_entry'), $n ],
      )),
  );
}
name 'ns_l_compact_sequence', \&ns_l_compact_sequence;



# [187]
# l+block-mapping(n) ::=
#   ( s-indent(n+m)
#   ns-l-block-map-entry(n+m) )+
#   <for_some_fixed_auto-detected_m_>_0>

sub l_block_mapping {
  my ($self, $n) = @_;
  debug1("l_block_mapping",$n);
  $self->all(
    $self->set('m', $self->func('auto_detect_indent')),
    $self->rep(1, 0,
      $self->all(
        [ $self->func('s_indent'), $self->add($n, $self->m) ],
        [ $self->func('ns_l_block_map_entry'), $self->add($n, $self->m) ],
      )),
  );
}
name 'l_block_mapping', \&l_block_mapping;



# [188]
# ns-l-block-map-entry(n) ::=
#   c-l-block-map-explicit-entry(n)
#   | ns-l-block-map-implicit-entry(n)

sub ns_l_block_map_entry {
  my ($self, $n) = @_;
  debug1("ns_l_block_map_entry",$n);
  $self->any(
    [ $self->func('c_l_block_map_explicit_entry'), $n ],
    [ $self->func('ns_l_block_map_implicit_entry'), $n ],
  );
}
name 'ns_l_block_map_entry', \&ns_l_block_map_entry;



# [189]
# c-l-block-map-explicit-entry(n) ::=
#   c-l-block-map-explicit-key(n)
#   ( l-block-map-explicit-value(n)
#   | e-node )

sub c_l_block_map_explicit_entry {
  my ($self, $n) = @_;
  debug1("c_l_block_map_explicit_entry",$n);
  $self->all(
    [ $self->func('c_l_block_map_explicit_key'), $n ],
    $self->any(
      [ $self->func('l_block_map_explicit_value'), $n ],
      $self->func('e_node'),
    ),
  );
}
name 'c_l_block_map_explicit_entry', \&c_l_block_map_explicit_entry;



# [190]
# c-l-block-map-explicit-key(n) ::=
#   '?'
#   s-l+block-indented(n,block-out)

sub c_l_block_map_explicit_key {
  my ($self, $n) = @_;
  debug1("c_l_block_map_explicit_key",$n);
  $self->all(
    $self->chr('?'),
    [ $self->func('s_l_block_indented'), $n, "block-out" ],
  );
}
name 'c_l_block_map_explicit_key', \&c_l_block_map_explicit_key;



# [191]
# l-block-map-explicit-value(n) ::=
#   s-indent(n)
#   ':' s-l+block-indented(n,block-out)

sub l_block_map_explicit_value {
  my ($self, $n) = @_;
  debug1("l_block_map_explicit_value",$n);
  $self->all(
    [ $self->func('s_indent'), $n ],
    $self->chr(':'),
    [ $self->func('s_l_block_indented'), $n, "block-out" ],
  );
}
name 'l_block_map_explicit_value', \&l_block_map_explicit_value;



# [192]
# ns-l-block-map-implicit-entry(n) ::=
#   (
#   ns-s-block-map-implicit-key
#   | e-node )
#   c-l-block-map-implicit-value(n)

sub ns_l_block_map_implicit_entry {
  my ($self, $n) = @_;
  debug1("ns_l_block_map_implicit_entry",$n);
  $self->all(
    $self->any(
      $self->func('ns_s_block_map_implicit_key'),
      $self->func('e_node'),
    ),
    [ $self->func('c_l_block_map_implicit_value'), $n ],
  );
}
name 'ns_l_block_map_implicit_entry', \&ns_l_block_map_implicit_entry;



# [193]
# ns-s-block-map-implicit-key ::=
#   c-s-implicit-json-key(block-key)
#   | ns-s-implicit-yaml-key(block-key)

sub ns_s_block_map_implicit_key {
  my ($self) = @_;
  debug1("ns_s_block_map_implicit_key");
  $self->any(
    [ $self->func('c_s_implicit_json_key'), "block-key" ],
    [ $self->func('ns_s_implicit_yaml_key'), "block-key" ],
  );
}
name 'ns_s_block_map_implicit_key', \&ns_s_block_map_implicit_key;



# [194]
# c-l-block-map-implicit-value(n) ::=
#   ':' (
#   s-l+block-node(n,block-out)
#   | ( e-node s-l-comments ) )

sub c_l_block_map_implicit_value {
  my ($self, $n) = @_;
  debug1("c_l_block_map_implicit_value",$n);
  $self->all(
    $self->chr(':'),
    $self->any(
      [ $self->func('s_l_block_node'), $n, "block-out" ],
      $self->all(
        $self->func('e_node'),
        $self->func('s_l_comments'),
      ),
    ),
  );
}
name 'c_l_block_map_implicit_value', \&c_l_block_map_implicit_value;



# [195]
# ns-l-compact-mapping(n) ::=
#   ns-l-block-map-entry(n)
#   ( s-indent(n) ns-l-block-map-entry(n) )*

sub ns_l_compact_mapping {
  my ($self, $n) = @_;
  debug1("ns_l_compact_mapping",$n);
  $self->all(
    [ $self->func('ns_l_block_map_entry'), $n ],
    $self->rep(0, 0,
      $self->all(
        [ $self->func('s_indent'), $n ],
        [ $self->func('ns_l_block_map_entry'), $n ],
      )),
  );
}
name 'ns_l_compact_mapping', \&ns_l_compact_mapping;



# [196]
# s-l+block-node(n,c) ::=
#   s-l+block-in-block(n,c) | s-l+flow-in-block(n)

sub s_l_block_node {
  my ($self, $n, $c) = @_;
  debug1("s_l_block_node",$n,$c);
  $self->any(
    [ $self->func('s_l_block_in_block'), $n, $c ],
    [ $self->func('s_l_flow_in_block'), $n ],
  );
}
name 's_l_block_node', \&s_l_block_node;



# [197]
# s-l+flow-in-block(n) ::=
#   s-separate(n+1,flow-out)
#   ns-flow-node(n+1,flow-out) s-l-comments

sub s_l_flow_in_block {
  my ($self, $n) = @_;
  debug1("s_l_flow_in_block",$n);
  $self->all(
    [ $self->func('s_separate'), $self->add($n, 1), "flow-out" ],
    [ $self->func('ns_flow_node'), $self->add($n, 1), "flow-out" ],
    $self->func('s_l_comments'),
  );
}
name 's_l_flow_in_block', \&s_l_flow_in_block;



# [198]
# s-l+block-in-block(n,c) ::=
#   s-l+block-scalar(n,c) | s-l+block-collection(n,c)

sub s_l_block_in_block {
  my ($self, $n, $c) = @_;
  debug1("s_l_block_in_block",$n,$c);
  $self->any(
    [ $self->func('s_l_block_scalar'), $n, $c ],
    [ $self->func('s_l_block_collection'), $n, $c ],
  );
}
name 's_l_block_in_block', \&s_l_block_in_block;



# [199]
# s-l+block-scalar(n,c) ::=
#   s-separate(n+1,c)
#   ( c-ns-properties(n+1,c) s-separate(n+1,c) )?
#   ( c-l+literal(n) | c-l+folded(n) )

sub s_l_block_scalar {
  my ($self, $n, $c) = @_;
  debug1("s_l_block_scalar",$n,$c);
  $self->all(
    [ $self->func('s_separate'), $self->add($n, 1), $c ],
    $self->rep(0, 1,
      $self->all(
        [ $self->func('c_ns_properties'), $self->add($n, 1), $c ],
        [ $self->func('s_separate'), $self->add($n, 1), $c ],
      )),
    $self->any(
      [ $self->func('c_l_literal'), $n ],
      [ $self->func('c_l_folded'), $n ],
    ),
  );
}
name 's_l_block_scalar', \&s_l_block_scalar;



# [200]
# s-l+block-collection(n,c) ::=
#   ( s-separate(n+1,c)
#   c-ns-properties(n+1,c) )?
#   s-l-comments
#   ( l+block-sequence(seq-spaces(n,c))
#   | l+block-mapping(n) )

sub s_l_block_collection {
  my ($self, $n, $c) = @_;
  debug1("s_l_block_collection",$n,$c);
  $self->all(
    $self->rep(0, 1,
      $self->all(
        [ $self->func('s_separate'), $self->add($n, 1), $c ],
        [ $self->func('c_ns_properties'), $self->add($n, 1), $c ],
      )),
    $self->func('s_l_comments'),
    $self->any(
      [ $self->func('l_block_sequence'), [ $self->func('seq_spaces'), $n, $c ] ],
      [ $self->func('l_block_mapping'), $n ],
    ),
  );
}
name 's_l_block_collection', \&s_l_block_collection;



# [201]
# seq-spaces(n,c) ::=
#   ( c = block-out => n-1 )
#   ( c = block-in => n )

sub seq_spaces {
  my ($self, $n, $c) = @_;
  debug1("seq_spaces",$n,$c);
  $self->flip($c, {
    'block-in' => $n,
    'block-out' => $self->sub($n, 1),
  });
}
name 'seq_spaces', \&seq_spaces;



# [202]
# l-document-prefix ::=
#   c-byte-order-mark? l-comment*

sub l_document_prefix {
  my ($self) = @_;
  debug1("l_document_prefix");
  $self->all(
    $self->rep(0, 1, $self->func('c_byte_order_mark')),
    $self->rep(0, 0, $self->func('l_comment')),
  );
}
name 'l_document_prefix', \&l_document_prefix;



# [203]
# c-directives-end ::=
#   '-' '-' '-'

sub c_directives_end {
  my ($self) = @_;
  debug1("c_directives_end");
  $self->all(
    $self->chr('-'),
    $self->chr('-'),
    $self->chr('-'),
  );
}
name 'c_directives_end', \&c_directives_end;



# [204]
# c-document-end ::=
#   '.' '.' '.'

sub c_document_end {
  my ($self) = @_;
  debug1("c_document_end");
  $self->all(
    $self->chr('.'),
    $self->chr('.'),
    $self->chr('.'),
  );
}
name 'c_document_end', \&c_document_end;



# [205]
# l-document-suffix ::=
#   c-document-end s-l-comments

sub l_document_suffix {
  my ($self) = @_;
  debug1("l_document_suffix");
  $self->all(
    $self->func('c_document_end'),
    $self->func('s_l_comments'),
  );
}
name 'l_document_suffix', \&l_document_suffix;



# [206]
# c-forbidden ::=
#   <start_of_line>
#   ( c-directives-end | c-document-end )
#   ( b-char | s-white | <end_of_file> )

sub c_forbidden {
  my ($self) = @_;
  debug1("c_forbidden");
  $self->all(
    $self->func('start_of_line'),
    $self->any(
      $self->func('c_directives_end'),
      $self->func('c_document_end'),
    ),
    $self->any(
      $self->func('b_char'),
      $self->func('s_white'),
      $self->func('end_of_stream'),
    ),
  );
}
name 'c_forbidden', \&c_forbidden;



# [207]
# l-bare-document ::=
#   s-l+block-node(-1,block-in)
#   <excluding_c-forbidden_content>

sub l_bare_document {
  my ($self) = @_;
  debug1("l_bare_document");
  $self->all(
    $self->exclude($self->func('c_forbidden')),
    [ $self->func('s_l_block_node'), -1, "block-in" ],
  );
}
name 'l_bare_document', \&l_bare_document;



# [208]
# l-explicit-document ::=
#   c-directives-end
#   ( l-bare-document
#   | ( e-node s-l-comments ) )

sub l_explicit_document {
  my ($self) = @_;
  debug1("l_explicit_document");
  $self->all(
    $self->func('c_directives_end'),
    $self->any(
      $self->func('l_bare_document'),
      $self->all(
        $self->func('e_node'),
        $self->func('s_l_comments'),
      ),
    ),
  );
}
name 'l_explicit_document', \&l_explicit_document;



# [209]
# l-directive-document ::=
#   l-directive+
#   l-explicit-document

sub l_directive_document {
  my ($self) = @_;
  debug1("l_directive_document");
  $self->all(
    $self->rep(1, 0, $self->func('l_directive')),
    $self->func('l_explicit_document'),
  );
}
name 'l_directive_document', \&l_directive_document;



# [210]
# l-any-document ::=
#   l-directive-document
#   | l-explicit-document
#   | l-bare-document

sub l_any_document {
  my ($self) = @_;
  debug1("l_any_document");
  $self->any(
    $self->func('l_directive_document'),
    $self->func('l_explicit_document'),
    $self->func('l_bare_document'),
  );
}
name 'l_any_document', \&l_any_document;



# [211]
# l-yaml-stream ::=
#   l-document-prefix* l-any-document?
#   ( ( l-document-suffix+ l-document-prefix*
#   l-any-document? )
#   | ( l-document-prefix* l-explicit-document? ) )*

sub l_yaml_stream {
  my ($self) = @_;
  debug1("l_yaml_stream");
  $self->all(
    $self->rep(0, 0, $self->func('l_document_prefix')),
    $self->rep(0, 1, $self->func('l_any_document')),
    $self->rep(0, 0,
      $self->any(
        $self->all(
          $self->rep(1, 0, $self->func('l_document_suffix')),
          $self->rep(0, 0, $self->func('l_document_prefix')),
          $self->rep(0, 1, $self->func('l_any_document')),
        ),
        $self->all(
          $self->rep(0, 0, $self->func('l_document_prefix')),
          $self->rep(0, 1, $self->func('l_explicit_document')),
        ),
      )),
  );
}
name 'l_yaml_stream', \&l_yaml_stream;



1;