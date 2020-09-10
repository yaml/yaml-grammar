###
# This grammar class was generated from https://yaml.org/spec/1.2/spec.html
###

use v5.12;
package Grammar;
use Prelude;

use constant DEBUG => $ENV{DEBUG};

rule '000', TOP => sub {
  my ($self) = @_;
  $self->func('l_yaml_stream');
};


# [001]
# c-printable ::=
#   x:9 | x:A | x:D | [x:20-x:7E]
#   | x:85 | [x:A0-x:D7FF] | [x:E000-x:FFFD]
#   | [x:10000-x:10FFFF]

rule '001', c_printable => sub {
  my ($self) = @_;
  debug_rule("c_printable") if DEBUG;
  $self->any(
    $self->chr("\x{09}"),
    $self->chr("\x{0A}"),
    $self->chr("\x{0D}"),
    $self->rng("\x{20}", "\x{7E}"),
    $self->chr("\x{85}"),
    $self->rng("\x{A0}", "\x{D7FF}"),
    $self->rng("\x{E000}", "\x{FFFD}"),
    $self->rng("\x{010000}", "\x{10FFFF}")
  );
};



# [002]
# nb-json ::=
#   x:9 | [x:20-x:10FFFF]

rule '002', nb_json => sub {
  my ($self) = @_;
  debug_rule("nb_json") if DEBUG;
  $self->any(
    $self->chr("\x{09}"),
    $self->rng("\x{20}", "\x{10FFFF}")
  );
};



# [003]
# c-byte-order-mark ::=
#   x:FEFF

rule '003', c_byte_order_mark => sub {
  my ($self) = @_;
  debug_rule("c_byte_order_mark") if DEBUG;
  $self->chr("\x{FEFF}");
};



# [004]
# c-sequence-entry ::=
#   '-'

rule '004', c_sequence_entry => sub {
  my ($self) = @_;
  debug_rule("c_sequence_entry") if DEBUG;
  $self->chr('-');
};



# [005]
# c-mapping-key ::=
#   '?'

rule '005', c_mapping_key => sub {
  my ($self) = @_;
  debug_rule("c_mapping_key") if DEBUG;
  $self->chr('?');
};



# [006]
# c-mapping-value ::=
#   ':'

rule '006', c_mapping_value => sub {
  my ($self) = @_;
  debug_rule("c_mapping_value") if DEBUG;
  $self->chr(':');
};



# [007]
# c-collect-entry ::=
#   ','

rule '007', c_collect_entry => sub {
  my ($self) = @_;
  debug_rule("c_collect_entry") if DEBUG;
  $self->chr(',');
};



# [008]
# c-sequence-start ::=
#   '['

rule '008', c_sequence_start => sub {
  my ($self) = @_;
  debug_rule("c_sequence_start") if DEBUG;
  $self->chr('[');
};



# [009]
# c-sequence-end ::=
#   ']'

rule '009', c_sequence_end => sub {
  my ($self) = @_;
  debug_rule("c_sequence_end") if DEBUG;
  $self->chr(']');
};



# [010]
# c-mapping-start ::=
#   '{'

rule '010', c_mapping_start => sub {
  my ($self) = @_;
  debug_rule("c_mapping_start") if DEBUG;
  $self->chr('{');
};



# [011]
# c-mapping-end ::=
#   '}'

rule '011', c_mapping_end => sub {
  my ($self) = @_;
  debug_rule("c_mapping_end") if DEBUG;
  $self->chr('}');
};



# [012]
# c-comment ::=
#   '#'

rule '012', c_comment => sub {
  my ($self) = @_;
  debug_rule("c_comment") if DEBUG;
  $self->chr('#');
};



# [013]
# c-anchor ::=
#   '&'

rule '013', c_anchor => sub {
  my ($self) = @_;
  debug_rule("c_anchor") if DEBUG;
  $self->chr('&');
};



# [014]
# c-alias ::=
#   '*'

rule '014', c_alias => sub {
  my ($self) = @_;
  debug_rule("c_alias") if DEBUG;
  $self->chr('*');
};



# [015]
# c-tag ::=
#   '!'

rule '015', c_tag => sub {
  my ($self) = @_;
  debug_rule("c_tag") if DEBUG;
  $self->chr('!');
};



# [016]
# c-literal ::=
#   '|'

rule '016', c_literal => sub {
  my ($self) = @_;
  debug_rule("c_literal") if DEBUG;
  $self->chr('|');
};



# [017]
# c-folded ::=
#   '>'

rule '017', c_folded => sub {
  my ($self) = @_;
  debug_rule("c_folded") if DEBUG;
  $self->chr('>');
};



# [018]
# c-single-quote ::=
#   '''

rule '018', c_single_quote => sub {
  my ($self) = @_;
  debug_rule("c_single_quote") if DEBUG;
  $self->chr("'");
};



# [019]
# c-double-quote ::=
#   '"'

rule '019', c_double_quote => sub {
  my ($self) = @_;
  debug_rule("c_double_quote") if DEBUG;
  $self->chr('"');
};



# [020]
# c-directive ::=
#   '%'

rule '020', c_directive => sub {
  my ($self) = @_;
  debug_rule("c_directive") if DEBUG;
  $self->chr('%');
};



# [021]
# c-reserved ::=
#   '@' | '`'

rule '021', c_reserved => sub {
  my ($self) = @_;
  debug_rule("c_reserved") if DEBUG;
  $self->any(
    $self->chr('@'),
    $self->chr('`')
  );
};



# [022]
# c-indicator ::=
#   '-' | '?' | ':' | ',' | '[' | ']' | '{' | '}'
#   | '#' | '&' | '*' | '!' | '|' | '>' | ''' | '"'
#   | '%' | '@' | '`'

rule '022', c_indicator => sub {
  my ($self) = @_;
  debug_rule("c_indicator") if DEBUG;
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
    $self->chr('`')
  );
};



# [023]
# c-flow-indicator ::=
#   ',' | '[' | ']' | '{' | '}'

rule '023', c_flow_indicator => sub {
  my ($self) = @_;
  debug_rule("c_flow_indicator") if DEBUG;
  $self->any(
    $self->chr(','),
    $self->chr('['),
    $self->chr(']'),
    $self->chr('{'),
    $self->chr('}')
  );
};



# [024]
# b-line-feed ::=
#   x:A

rule '024', b_line_feed => sub {
  my ($self) = @_;
  debug_rule("b_line_feed") if DEBUG;
  $self->chr("\x{0A}");
};



# [025]
# b-carriage-return ::=
#   x:D

rule '025', b_carriage_return => sub {
  my ($self) = @_;
  debug_rule("b_carriage_return") if DEBUG;
  $self->chr("\x{0D}");
};



# [026]
# b-char ::=
#   b-line-feed | b-carriage-return

rule '026', b_char => sub {
  my ($self) = @_;
  debug_rule("b_char") if DEBUG;
  $self->any(
    $self->func('b_line_feed'),
    $self->func('b_carriage_return')
  );
};



# [027]
# nb-char ::=
#   c-printable - b-char - c-byte-order-mark

rule '027', nb_char => sub {
  my ($self) = @_;
  debug_rule("nb_char") if DEBUG;
  $self->but(
    $self->func('c_printable'),
    $self->func('b_char'),
    $self->func('c_byte_order_mark')
  );
};



# [028]
# b-break ::=
#   ( b-carriage-return b-line-feed )
#   | b-carriage-return
#   | b-line-feed

rule '028', b_break => sub {
  my ($self) = @_;
  debug_rule("b_break") if DEBUG;
  $self->any(
    $self->all(
      $self->func('b_carriage_return'),
      $self->func('b_line_feed')
    ),
    $self->func('b_carriage_return'),
    $self->func('b_line_feed')
  );
};



# [029]
# b-as-line-feed ::=
#   b-break

rule '029', b_as_line_feed => sub {
  my ($self) = @_;
  debug_rule("b_as_line_feed") if DEBUG;
  $self->func('b_break');
};



# [030]
# b-non-content ::=
#   b-break

rule '030', b_non_content => sub {
  my ($self) = @_;
  debug_rule("b_non_content") if DEBUG;
  $self->func('b_break');
};



# [031]
# s-space ::=
#   x:20

rule '031', s_space => sub {
  my ($self) = @_;
  debug_rule("s_space") if DEBUG;
  $self->chr("\x{20}");
};



# [032]
# s-tab ::=
#   x:9

rule '032', s_tab => sub {
  my ($self) = @_;
  debug_rule("s_tab") if DEBUG;
  $self->chr("\x{09}");
};



# [033]
# s-white ::=
#   s-space | s-tab

rule '033', s_white => sub {
  my ($self) = @_;
  debug_rule("s_white") if DEBUG;
  $self->any(
    $self->func('s_space'),
    $self->func('s_tab')
  );
};



# [034]
# ns-char ::=
#   nb-char - s-white

rule '034', ns_char => sub {
  my ($self) = @_;
  debug_rule("ns_char") if DEBUG;
  $self->but(
    $self->func('nb_char'),
    $self->func('s_white')
  );
};



# [035]
# ns-dec-digit ::=
#   [x:30-x:39]

rule '035', ns_dec_digit => sub {
  my ($self) = @_;
  debug_rule("ns_dec_digit") if DEBUG;
  $self->rng("\x{30}", "\x{39}");
};



# [036]
# ns-hex-digit ::=
#   ns-dec-digit
#   | [x:41-x:46] | [x:61-x:66]

rule '036', ns_hex_digit => sub {
  my ($self) = @_;
  debug_rule("ns_hex_digit") if DEBUG;
  $self->any(
    $self->func('ns_dec_digit'),
    $self->rng("\x{41}", "\x{46}"),
    $self->rng("\x{61}", "\x{66}")
  );
};



# [037]
# ns-ascii-letter ::=
#   [x:41-x:5A] | [x:61-x:7A]

rule '037', ns_ascii_letter => sub {
  my ($self) = @_;
  debug_rule("ns_ascii_letter") if DEBUG;
  $self->any(
    $self->rng("\x{41}", "\x{5A}"),
    $self->rng("\x{61}", "\x{7A}")
  );
};



# [038]
# ns-word-char ::=
#   ns-dec-digit | ns-ascii-letter | '-'

rule '038', ns_word_char => sub {
  my ($self) = @_;
  debug_rule("ns_word_char") if DEBUG;
  $self->any(
    $self->func('ns_dec_digit'),
    $self->func('ns_ascii_letter'),
    $self->chr('-')
  );
};



# [039]
# ns-uri-char ::=
#   '%' ns-hex-digit ns-hex-digit | ns-word-char | '#'
#   | ';' | '/' | '?' | ':' | '@' | '&' | '=' | '+' | '$' | ','
#   | '_' | '.' | '!' | '~' | '*' | ''' | '(' | ')' | '[' | ']'

rule '039', ns_uri_char => sub {
  my ($self) = @_;
  debug_rule("ns_uri_char") if DEBUG;
  $self->any(
    $self->all(
      $self->chr('%'),
      $self->func('ns_hex_digit'),
      $self->func('ns_hex_digit')
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
    $self->chr(']')
  );
};



# [040]
# ns-tag-char ::=
#   ns-uri-char - '!' - c-flow-indicator

rule '040', ns_tag_char => sub {
  my ($self) = @_;
  debug_rule("ns_tag_char") if DEBUG;
  $self->but(
    $self->func('ns_uri_char'),
    $self->chr('!'),
    $self->func('c_flow_indicator')
  );
};



# [041]
# c-escape ::=
#   '\'

rule '041', c_escape => sub {
  my ($self) = @_;
  debug_rule("c_escape") if DEBUG;
  $self->chr("\\");
};



# [042]
# ns-esc-null ::=
#   '0'

rule '042', ns_esc_null => sub {
  my ($self) = @_;
  debug_rule("ns_esc_null") if DEBUG;
  $self->chr('0');
};



# [043]
# ns-esc-bell ::=
#   'a'

rule '043', ns_esc_bell => sub {
  my ($self) = @_;
  debug_rule("ns_esc_bell") if DEBUG;
  $self->chr('a');
};



# [044]
# ns-esc-backspace ::=
#   'b'

rule '044', ns_esc_backspace => sub {
  my ($self) = @_;
  debug_rule("ns_esc_backspace") if DEBUG;
  $self->chr('b');
};



# [045]
# ns-esc-horizontal-tab ::=
#   't' | x:9

rule '045', ns_esc_horizontal_tab => sub {
  my ($self) = @_;
  debug_rule("ns_esc_horizontal_tab") if DEBUG;
  $self->any(
    $self->chr('t'),
    $self->chr("\x{09}")
  );
};



# [046]
# ns-esc-line-feed ::=
#   'n'

rule '046', ns_esc_line_feed => sub {
  my ($self) = @_;
  debug_rule("ns_esc_line_feed") if DEBUG;
  $self->chr('n');
};



# [047]
# ns-esc-vertical-tab ::=
#   'v'

rule '047', ns_esc_vertical_tab => sub {
  my ($self) = @_;
  debug_rule("ns_esc_vertical_tab") if DEBUG;
  $self->chr('v');
};



# [048]
# ns-esc-form-feed ::=
#   'f'

rule '048', ns_esc_form_feed => sub {
  my ($self) = @_;
  debug_rule("ns_esc_form_feed") if DEBUG;
  $self->chr('f');
};



# [049]
# ns-esc-carriage-return ::=
#   'r'

rule '049', ns_esc_carriage_return => sub {
  my ($self) = @_;
  debug_rule("ns_esc_carriage_return") if DEBUG;
  $self->chr('r');
};



# [050]
# ns-esc-escape ::=
#   'e'

rule '050', ns_esc_escape => sub {
  my ($self) = @_;
  debug_rule("ns_esc_escape") if DEBUG;
  $self->chr('e');
};



# [051]
# ns-esc-space ::=
#   x:20

rule '051', ns_esc_space => sub {
  my ($self) = @_;
  debug_rule("ns_esc_space") if DEBUG;
  $self->chr("\x{20}");
};



# [052]
# ns-esc-double-quote ::=
#   '"'

rule '052', ns_esc_double_quote => sub {
  my ($self) = @_;
  debug_rule("ns_esc_double_quote") if DEBUG;
  $self->chr('"');
};



# [053]
# ns-esc-slash ::=
#   '/'

rule '053', ns_esc_slash => sub {
  my ($self) = @_;
  debug_rule("ns_esc_slash") if DEBUG;
  $self->chr('/');
};



# [054]
# ns-esc-backslash ::=
#   '\'

rule '054', ns_esc_backslash => sub {
  my ($self) = @_;
  debug_rule("ns_esc_backslash") if DEBUG;
  $self->chr("\\");
};



# [055]
# ns-esc-next-line ::=
#   'N'

rule '055', ns_esc_next_line => sub {
  my ($self) = @_;
  debug_rule("ns_esc_next_line") if DEBUG;
  $self->chr('N');
};



# [056]
# ns-esc-non-breaking-space ::=
#   '_'

rule '056', ns_esc_non_breaking_space => sub {
  my ($self) = @_;
  debug_rule("ns_esc_non_breaking_space") if DEBUG;
  $self->chr('_');
};



# [057]
# ns-esc-line-separator ::=
#   'L'

rule '057', ns_esc_line_separator => sub {
  my ($self) = @_;
  debug_rule("ns_esc_line_separator") if DEBUG;
  $self->chr('L');
};



# [058]
# ns-esc-paragraph-separator ::=
#   'P'

rule '058', ns_esc_paragraph_separator => sub {
  my ($self) = @_;
  debug_rule("ns_esc_paragraph_separator") if DEBUG;
  $self->chr('P');
};



# [059]
# ns-esc-8-bit ::=
#   'x'
#   ( ns-hex-digit{2} )

rule '059', ns_esc_8_bit => sub {
  my ($self) = @_;
  debug_rule("ns_esc_8_bit") if DEBUG;
  $self->all(
    $self->chr('x'),
    $self->rep($2, $2, $self->func('ns_hex_digit'))
  );
};



# [060]
# ns-esc-16-bit ::=
#   'u'
#   ( ns-hex-digit{4} )

rule '060', ns_esc_16_bit => sub {
  my ($self) = @_;
  debug_rule("ns_esc_16_bit") if DEBUG;
  $self->all(
    $self->chr('u'),
    $self->rep($4, $4, $self->func('ns_hex_digit'))
  );
};



# [061]
# ns-esc-32-bit ::=
#   'U'
#   ( ns-hex-digit{8} )

rule '061', ns_esc_32_bit => sub {
  my ($self) = @_;
  debug_rule("ns_esc_32_bit") if DEBUG;
  $self->all(
    $self->chr('U'),
    $self->rep($8, $8, $self->func('ns_hex_digit'))
  );
};



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

rule '062', c_ns_esc_char => sub {
  my ($self) = @_;
  debug_rule("c_ns_esc_char") if DEBUG;
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
      $self->func('ns_esc_32_bit')
    )
  );
};



# [063]
# s-indent(n) ::=
#   s-space{n}

rule '063', s_indent => sub {
  my ($self, $n) = @_;
  debug_rule("s_indent",$n) if DEBUG;
  $self->rep($n, $n, $self->func('s_space'));
};



# [064]
# s-indent(<n) ::=
#   s-space{m} <where_m_<_n>

rule '064', s_indent_lt => sub {
  my ($self, $n) = @_;
  debug_rule("s_indent_lt",$n) if DEBUG;
  $self->may(
    $self->all(
      $self->rep(0, 0, $self->func('s_space')),
      $self->lt($self->len($self->func('match')), $n)
    )
  );
};



# [065]
# s-indent(<=n) ::=
#   s-space{m} <where_m_<=_n>

rule '065', s_indent_le => sub {
  my ($self, $n) = @_;
  debug_rule("s_indent_le",$n) if DEBUG;
  $self->may(
    $self->all(
      $self->rep(0, 0, $self->func('s_space')),
      $self->le($self->len($self->func('match')), $self->chr('n'))
    )
  );
};



# [066]
# s-separate-in-line ::=
#   s-white+ | <start_of_line>

rule '066', s_separate_in_line => sub {
  my ($self) = @_;
  debug_rule("s_separate_in_line") if DEBUG;
  $self->any(
    $self->rep(1, 0, $self->func('s_white')),
    $self->func('start_of_line')
  );
};



# [067]
# s-line-prefix(n,c) ::=
#   ( c = block-out => s-block-line-prefix(n) )
#   ( c = block-in => s-block-line-prefix(n) )
#   ( c = flow-out => s-flow-line-prefix(n) )
#   ( c = flow-in => s-flow-line-prefix(n) )

rule '067', s_line_prefix => sub {
  my ($self, $n, $c) = @_;
  debug_rule("s_line_prefix",$n,$c) if DEBUG;
  $self->case(
    $c,
    {
      'block-in' => [ $self->func('s_block_line_prefix'), $n ],
      'block-out' => [ $self->func('s_block_line_prefix'), $n ],
      'flow-in' => [ $self->func('s_flow_line_prefix'), $n ],
      'flow-out' => [ $self->func('s_flow_line_prefix'), $n ],
    }
  );
};



# [068]
# s-block-line-prefix(n) ::=
#   s-indent(n)

rule '068', s_block_line_prefix => sub {
  my ($self, $n) = @_;
  debug_rule("s_block_line_prefix",$n) if DEBUG;
  [ $self->func('s_indent'), $n ];
};



# [069]
# s-flow-line-prefix(n) ::=
#   s-indent(n)
#   s-separate-in-line?

rule '069', s_flow_line_prefix => sub {
  my ($self, $n) = @_;
  debug_rule("s_flow_line_prefix",$n) if DEBUG;
  $self->all(
    [ $self->func('s_indent'), $n ],
    $self->rep(0, 1, $self->func('s_separate_in_line'))
  );
};



# [070]
# l-empty(n,c) ::=
#   ( s-line-prefix(n,c) | s-indent(<n) )
#   b-as-line-feed

rule '070', l_empty => sub {
  my ($self, $n, $c) = @_;
  debug_rule("l_empty",$n,$c) if DEBUG;
  $self->all(
    $self->any(
      [ $self->func('s_line_prefix'), $n, $c ],
      [ $self->func('s_indent_lt'), $n ]
    ),
    $self->func('b_as_line_feed')
  );
};



# [071]
# b-l-trimmed(n,c) ::=
#   b-non-content l-empty(n,c)+

rule '071', b_l_trimmed => sub {
  my ($self, $n, $c) = @_;
  debug_rule("b_l_trimmed",$n,$c) if DEBUG;
  $self->all(
    $self->func('b_non_content'),
    $self->rep(1, 0, [ $self->func('l_empty'), $n, $c ])
  );
};



# [072]
# b-as-space ::=
#   b-break

rule '072', b_as_space => sub {
  my ($self) = @_;
  debug_rule("b_as_space") if DEBUG;
  $self->func('b_break');
};



# [073]
# b-l-folded(n,c) ::=
#   b-l-trimmed(n,c) | b-as-space

rule '073', b_l_folded => sub {
  my ($self, $n, $c) = @_;
  debug_rule("b_l_folded",$n,$c) if DEBUG;
  $self->any(
    [ $self->func('b_l_trimmed'), $n, $c ],
    $self->func('b_as_space')
  );
};



# [074]
# s-flow-folded(n) ::=
#   s-separate-in-line?
#   b-l-folded(n,flow-in)
#   s-flow-line-prefix(n)

rule '074', s_flow_folded => sub {
  my ($self, $n) = @_;
  debug_rule("s_flow_folded",$n) if DEBUG;
  $self->all(
    $self->rep(0, 1, $self->func('s_separate_in_line')),
    [ $self->func('b_l_folded'), $n, "flow-in" ],
    [ $self->func('s_flow_line_prefix'), $n ]
  );
};



# [075]
# c-nb-comment-text ::=
#   '#' nb-char*

rule '075', c_nb_comment_text => sub {
  my ($self) = @_;
  debug_rule("c_nb_comment_text") if DEBUG;
  $self->all(
    $self->chr('#'),
    $self->rep(0, 0, $self->func('nb_char'))
  );
};



# [076]
# b-comment ::=
#   b-non-content | <end_of_file>

rule '076', b_comment => sub {
  my ($self) = @_;
  debug_rule("b_comment") if DEBUG;
  $self->any(
    $self->func('b_non_content'),
    $self->func('end_of_stream')
  );
};



# [077]
# s-b-comment ::=
#   ( s-separate-in-line
#   c-nb-comment-text? )?
#   b-comment

rule '077', s_b_comment => sub {
  my ($self) = @_;
  debug_rule("s_b_comment") if DEBUG;
  $self->all(
    $self->rep(0, 1,
      $self->all(
        $self->func('s_separate_in_line'),
        $self->rep(0, 1, $self->func('c_nb_comment_text'))
      )),
    $self->func('b_comment')
  );
};



# [078]
# l-comment ::=
#   s-separate-in-line c-nb-comment-text?
#   b-comment

rule '078', l_comment => sub {
  my ($self) = @_;
  debug_rule("l_comment") if DEBUG;
  $self->all(
    $self->func('s_separate_in_line'),
    $self->rep(0, 1, $self->func('c_nb_comment_text')),
    $self->func('b_comment')
  );
};



# [079]
# s-l-comments ::=
#   ( s-b-comment | <start_of_line> )
#   l-comment*

rule '079', s_l_comments => sub {
  my ($self) = @_;
  debug_rule("s_l_comments") if DEBUG;
  $self->all(
    $self->any(
      $self->func('s_b_comment'),
      $self->func('start_of_line')
    ),
    $self->rep(0, 0, $self->func('l_comment'))
  );
};



# [080]
# s-separate(n,c) ::=
#   ( c = block-out => s-separate-lines(n) )
#   ( c = block-in => s-separate-lines(n) )
#   ( c = flow-out => s-separate-lines(n) )
#   ( c = flow-in => s-separate-lines(n) )
#   ( c = block-key => s-separate-in-line )
#   ( c = flow-key => s-separate-in-line )

rule '080', s_separate => sub {
  my ($self, $n, $c) = @_;
  debug_rule("s_separate",$n,$c) if DEBUG;
  $self->case(
    $c,
    {
      'block-in' => [ $self->func('s_separate_lines'), $n ],
      'block-key' => $self->func('s_separate_in_line'),
      'block-out' => [ $self->func('s_separate_lines'), $n ],
      'flow-in' => [ $self->func('s_separate_lines'), $n ],
      'flow-key' => $self->func('s_separate_in_line'),
      'flow-out' => [ $self->func('s_separate_lines'), $n ],
    }
  );
};



# [081]
# s-separate-lines(n) ::=
#   ( s-l-comments
#   s-flow-line-prefix(n) )
#   | s-separate-in-line

rule '081', s_separate_lines => sub {
  my ($self, $n) = @_;
  debug_rule("s_separate_lines",$n) if DEBUG;
  $self->any(
    $self->all(
      $self->func('s_l_comments'),
      [ $self->func('s_flow_line_prefix'), $n ]
    ),
    $self->func('s_separate_in_line')
  );
};



# [082]
# l-directive ::=
#   '%'
#   ( ns-yaml-directive
#   | ns-tag-directive
#   | ns-reserved-directive )
#   s-l-comments

rule '082', l_directive => sub {
  my ($self) = @_;
  debug_rule("l_directive") if DEBUG;
  $self->all(
    $self->chr('%'),
    $self->any(
      $self->func('ns_yaml_directive'),
      $self->func('ns_tag_directive'),
      $self->func('ns_reserved_directive')
    ),
    $self->func('s_l_comments')
  );
};



# [083]
# ns-reserved-directive ::=
#   ns-directive-name
#   ( s-separate-in-line ns-directive-parameter )*

rule '083', ns_reserved_directive => sub {
  my ($self) = @_;
  debug_rule("ns_reserved_directive") if DEBUG;
  $self->all(
    $self->func('ns_directive_name'),
    $self->rep(0, 0,
      $self->all(
        $self->func('s_separate_in_line'),
        $self->func('ns_directive_parameter')
      ))
  );
};



# [084]
# ns-directive-name ::=
#   ns-char+

rule '084', ns_directive_name => sub {
  my ($self) = @_;
  debug_rule("ns_directive_name") if DEBUG;
  $self->rep(1, 0, $self->func('ns_char'));
};



# [085]
# ns-directive-parameter ::=
#   ns-char+

rule '085', ns_directive_parameter => sub {
  my ($self) = @_;
  debug_rule("ns_directive_parameter") if DEBUG;
  $self->rep(1, 0, $self->func('ns_char'));
};



# [086]
# ns-yaml-directive ::=
#   'Y' 'A' 'M' 'L'
#   s-separate-in-line ns-yaml-version

rule '086', ns_yaml_directive => sub {
  my ($self) = @_;
  debug_rule("ns_yaml_directive") if DEBUG;
  $self->all(
    $self->chr('Y'),
    $self->chr('A'),
    $self->chr('M'),
    $self->chr('L'),
    $self->func('s_separate_in_line'),
    $self->func('ns_yaml_version')
  );
};



# [087]
# ns-yaml-version ::=
#   ns-dec-digit+ '.' ns-dec-digit+

rule '087', ns_yaml_version => sub {
  my ($self) = @_;
  debug_rule("ns_yaml_version") if DEBUG;
  $self->all(
    $self->rep(1, 0, $self->func('ns_dec_digit')),
    $self->chr('.'),
    $self->rep(1, 0, $self->func('ns_dec_digit'))
  );
};



# [088]
# ns-tag-directive ::=
#   'T' 'A' 'G'
#   s-separate-in-line c-tag-handle
#   s-separate-in-line ns-tag-prefix

rule '088', ns_tag_directive => sub {
  my ($self) = @_;
  debug_rule("ns_tag_directive") if DEBUG;
  $self->all(
    $self->chr('T'),
    $self->chr('A'),
    $self->chr('G'),
    $self->func('s_separate_in_line'),
    $self->func('c_tag_handle'),
    $self->func('s_separate_in_line'),
    $self->func('ns_tag_prefix')
  );
};



# [089]
# c-tag-handle ::=
#   c-named-tag-handle
#   | c-secondary-tag-handle
#   | c-primary-tag-handle

rule '089', c_tag_handle => sub {
  my ($self) = @_;
  debug_rule("c_tag_handle") if DEBUG;
  $self->any(
    $self->func('c_named_tag_handle'),
    $self->func('c_secondary_tag_handle'),
    $self->func('c_primary_tag_handle')
  );
};



# [090]
# c-primary-tag-handle ::=
#   '!'

rule '090', c_primary_tag_handle => sub {
  my ($self) = @_;
  debug_rule("c_primary_tag_handle") if DEBUG;
  $self->chr('!');
};



# [091]
# c-secondary-tag-handle ::=
#   '!' '!'

rule '091', c_secondary_tag_handle => sub {
  my ($self) = @_;
  debug_rule("c_secondary_tag_handle") if DEBUG;
  $self->all(
    $self->chr('!'),
    $self->chr('!')
  );
};



# [092]
# c-named-tag-handle ::=
#   '!' ns-word-char+ '!'

rule '092', c_named_tag_handle => sub {
  my ($self) = @_;
  debug_rule("c_named_tag_handle") if DEBUG;
  $self->all(
    $self->chr('!'),
    $self->rep(1, 0, $self->func('ns_word_char')),
    $self->chr('!')
  );
};



# [093]
# ns-tag-prefix ::=
#   c-ns-local-tag-prefix | ns-global-tag-prefix

rule '093', ns_tag_prefix => sub {
  my ($self) = @_;
  debug_rule("ns_tag_prefix") if DEBUG;
  $self->any(
    $self->func('c_ns_local_tag_prefix'),
    $self->func('ns_global_tag_prefix')
  );
};



# [094]
# c-ns-local-tag-prefix ::=
#   '!' ns-uri-char*

rule '094', c_ns_local_tag_prefix => sub {
  my ($self) = @_;
  debug_rule("c_ns_local_tag_prefix") if DEBUG;
  $self->all(
    $self->chr('!'),
    $self->rep(0, 0, $self->func('ns_uri_char'))
  );
};



# [095]
# ns-global-tag-prefix ::=
#   ns-tag-char ns-uri-char*

rule '095', ns_global_tag_prefix => sub {
  my ($self) = @_;
  debug_rule("ns_global_tag_prefix") if DEBUG;
  $self->all(
    $self->func('ns_tag_char'),
    $self->rep(0, 0, $self->func('ns_uri_char'))
  );
};



# [096]
# c-ns-properties(n,c) ::=
#   ( c-ns-tag-property
#   ( s-separate(n,c) c-ns-anchor-property )? )
#   | ( c-ns-anchor-property
#   ( s-separate(n,c) c-ns-tag-property )? )

rule '096', c_ns_properties => sub {
  my ($self, $n, $c) = @_;
  debug_rule("c_ns_properties",$n,$c) if DEBUG;
  $self->any(
    $self->all(
      $self->func('c_ns_tag_property'),
      $self->rep(0, 1,
        $self->all(
          [ $self->func('s_separate'), $n, $c ],
          $self->func('c_ns_anchor_property')
        ))
    ),
    $self->all(
      $self->func('c_ns_anchor_property'),
      $self->rep(0, 1,
        $self->all(
          [ $self->func('s_separate'), $n, $c ],
          $self->func('c_ns_tag_property')
        ))
    )
  );
};



# [097]
# c-ns-tag-property ::=
#   c-verbatim-tag
#   | c-ns-shorthand-tag
#   | c-non-specific-tag

rule '097', c_ns_tag_property => sub {
  my ($self) = @_;
  debug_rule("c_ns_tag_property") if DEBUG;
  $self->any(
    $self->func('c_verbatim_tag'),
    $self->func('c_ns_shorthand_tag'),
    $self->func('c_non_specific_tag')
  );
};



# [098]
# c-verbatim-tag ::=
#   '!' '<' ns-uri-char+ '>'

rule '098', c_verbatim_tag => sub {
  my ($self) = @_;
  debug_rule("c_verbatim_tag") if DEBUG;
  $self->all(
    $self->chr('!'),
    $self->chr('<'),
    $self->rep(1, 0, $self->func('ns_uri_char')),
    $self->chr('>')
  );
};



# [099]
# c-ns-shorthand-tag ::=
#   c-tag-handle ns-tag-char+

rule '099', c_ns_shorthand_tag => sub {
  my ($self) = @_;
  debug_rule("c_ns_shorthand_tag") if DEBUG;
  $self->all(
    $self->func('c_tag_handle'),
    $self->rep(1, 0, $self->func('ns_tag_char'))
  );
};



# [100]
# c-non-specific-tag ::=
#   '!'

rule '100', c_non_specific_tag => sub {
  my ($self) = @_;
  debug_rule("c_non_specific_tag") if DEBUG;
  $self->chr('!');
};



# [101]
# c-ns-anchor-property ::=
#   '&' ns-anchor-name

rule '101', c_ns_anchor_property => sub {
  my ($self) = @_;
  debug_rule("c_ns_anchor_property") if DEBUG;
  $self->all(
    $self->chr('&'),
    $self->func('ns_anchor_name')
  );
};



# [102]
# ns-anchor-char ::=
#   ns-char - c-flow-indicator

rule '102', ns_anchor_char => sub {
  my ($self) = @_;
  debug_rule("ns_anchor_char") if DEBUG;
  $self->but(
    $self->func('ns_char'),
    $self->func('c_flow_indicator')
  );
};



# [103]
# ns-anchor-name ::=
#   ns-anchor-char+

rule '103', ns_anchor_name => sub {
  my ($self) = @_;
  debug_rule("ns_anchor_name") if DEBUG;
  $self->rep(1, 0, $self->func('ns_anchor_char'));
};



# [104]
# c-ns-alias-node ::=
#   '*' ns-anchor-name

rule '104', c_ns_alias_node => sub {
  my ($self) = @_;
  debug_rule("c_ns_alias_node") if DEBUG;
  $self->all(
    $self->chr('*'),
    $self->func('ns_anchor_name')
  );
};



# [105]
# e-scalar ::=
#   <empty>

rule '105', e_scalar => sub {
  my ($self) = @_;
  debug_rule("e_scalar") if DEBUG;
  $self->func('empty');
};



# [106]
# e-node ::=
#   e-scalar

rule '106', e_node => sub {
  my ($self) = @_;
  debug_rule("e_node") if DEBUG;
  $self->func('e_scalar');
};



# [107]
# nb-double-char ::=
#   c-ns-esc-char | ( nb-json - '\' - '"' )

rule '107', nb_double_char => sub {
  my ($self) = @_;
  debug_rule("nb_double_char") if DEBUG;
  $self->any(
    $self->func('c_ns_esc_char'),
    $self->but(
      $self->func('nb_json'),
      $self->chr("\\"),
      $self->chr('"')
    )
  );
};



# [108]
# ns-double-char ::=
#   nb-double-char - s-white

rule '108', ns_double_char => sub {
  my ($self) = @_;
  debug_rule("ns_double_char") if DEBUG;
  $self->but(
    $self->func('nb_double_char'),
    $self->func('s_white')
  );
};



# [109]
# c-double-quoted(n,c) ::=
#   '"' nb-double-text(n,c)
#   '"'

rule '109', c_double_quoted => sub {
  my ($self, $n, $c) = @_;
  debug_rule("c_double_quoted",$n,$c) if DEBUG;
  $self->all(
    $self->chr('"'),
    [ $self->func('nb_double_text'), $n, $c ],
    $self->chr('"')
  );
};



# [110]
# nb-double-text(n,c) ::=
#   ( c = flow-out => nb-double-multi-line(n) )
#   ( c = flow-in => nb-double-multi-line(n) )
#   ( c = block-key => nb-double-one-line )
#   ( c = flow-key => nb-double-one-line )

rule '110', nb_double_text => sub {
  my ($self, $n, $c) = @_;
  debug_rule("nb_double_text",$n,$c) if DEBUG;
  $self->case(
    $c,
    {
      'block-key' => $self->func('nb_double_one_line'),
      'flow-in' => [ $self->func('nb_double_multi_line'), $n ],
      'flow-key' => $self->func('nb_double_one_line'),
      'flow-out' => [ $self->func('nb_double_multi_line'), $n ],
    }
  );
};



# [111]
# nb-double-one-line ::=
#   nb-double-char*

rule '111', nb_double_one_line => sub {
  my ($self) = @_;
  debug_rule("nb_double_one_line") if DEBUG;
  $self->rep(0, 0, $self->func('nb_double_char'));
};



# [112]
# s-double-escaped(n) ::=
#   s-white* '\'
#   b-non-content
#   l-empty(n,flow-in)* s-flow-line-prefix(n)

rule '112', s_double_escaped => sub {
  my ($self, $n) = @_;
  debug_rule("s_double_escaped",$n) if DEBUG;
  $self->all(
    $self->rep(0, 0, $self->func('s_white')),
    $self->chr("\\"),
    $self->func('b_non_content'),
    $self->rep(0, 0, [ $self->func('l_empty'), $n, "flow-in" ]),
    [ $self->func('s_flow_line_prefix'), $n ]
  );
};



# [113]
# s-double-break(n) ::=
#   s-double-escaped(n) | s-flow-folded(n)

rule '113', s_double_break => sub {
  my ($self, $n) = @_;
  debug_rule("s_double_break",$n) if DEBUG;
  $self->any(
    [ $self->func('s_double_escaped'), $n ],
    [ $self->func('s_flow_folded'), $n ]
  );
};



# [114]
# nb-ns-double-in-line ::=
#   ( s-white* ns-double-char )*

rule '114', nb_ns_double_in_line => sub {
  my ($self) = @_;
  debug_rule("nb_ns_double_in_line") if DEBUG;
  $self->rep(0, 0,
    $self->all(
      $self->rep(0, 0, $self->func('s_white')),
      $self->func('ns_double_char')
    ));
};



# [115]
# s-double-next-line(n) ::=
#   s-double-break(n)
#   ( ns-double-char nb-ns-double-in-line
#   ( s-double-next-line(n) | s-white* ) )?

rule '115', s_double_next_line => sub {
  my ($self, $n) = @_;
  debug_rule("s_double_next_line",$n) if DEBUG;
  $self->all(
    [ $self->func('s_double_break'), $n ],
    $self->rep(0, 1,
      $self->all(
        $self->func('ns_double_char'),
        $self->func('nb_ns_double_in_line'),
        $self->any(
          [ $self->func('s_double_next_line'), $n ],
          $self->rep(0, 0, $self->func('s_white'))
        )
      ))
  );
};



# [116]
# nb-double-multi-line(n) ::=
#   nb-ns-double-in-line
#   ( s-double-next-line(n) | s-white* )

rule '116', nb_double_multi_line => sub {
  my ($self, $n) = @_;
  debug_rule("nb_double_multi_line",$n) if DEBUG;
  $self->all(
    $self->func('nb_ns_double_in_line'),
    $self->any(
      [ $self->func('s_double_next_line'), $n ],
      $self->rep(0, 0, $self->func('s_white'))
    )
  );
};



# [117]
# c-quoted-quote ::=
#   ''' '''

rule '117', c_quoted_quote => sub {
  my ($self) = @_;
  debug_rule("c_quoted_quote") if DEBUG;
  $self->all(
    $self->chr("'"),
    $self->chr("'")
  );
};



# [118]
# nb-single-char ::=
#   c-quoted-quote | ( nb-json - ''' )

rule '118', nb_single_char => sub {
  my ($self) = @_;
  debug_rule("nb_single_char") if DEBUG;
  $self->any(
    $self->func('c_quoted_quote'),
    $self->but(
      $self->func('nb_json'),
      $self->chr("'")
    )
  );
};



# [119]
# ns-single-char ::=
#   nb-single-char - s-white

rule '119', ns_single_char => sub {
  my ($self) = @_;
  debug_rule("ns_single_char") if DEBUG;
  $self->but(
    $self->func('nb_single_char'),
    $self->func('s_white')
  );
};



# [120]
# c-single-quoted(n,c) ::=
#   ''' nb-single-text(n,c)
#   '''

rule '120', c_single_quoted => sub {
  my ($self, $n, $c) = @_;
  debug_rule("c_single_quoted",$n,$c) if DEBUG;
  $self->all(
    $self->chr("'"),
    [ $self->func('nb_single_text'), $n, $c ],
    $self->chr("'")
  );
};



# [121]
# nb-single-text(n,c) ::=
#   ( c = flow-out => nb-single-multi-line(n) )
#   ( c = flow-in => nb-single-multi-line(n) )
#   ( c = block-key => nb-single-one-line )
#   ( c = flow-key => nb-single-one-line )

rule '121', nb_single_text => sub {
  my ($self, $n, $c) = @_;
  debug_rule("nb_single_text",$n,$c) if DEBUG;
  $self->case(
    $c,
    {
      'block-key' => $self->func('nb_single_one_line'),
      'flow-in' => [ $self->func('nb_single_multi_line'), $n ],
      'flow-key' => $self->func('nb_single_one_line'),
      'flow-out' => [ $self->func('nb_single_multi_line'), $n ],
    }
  );
};



# [122]
# nb-single-one-line ::=
#   nb-single-char*

rule '122', nb_single_one_line => sub {
  my ($self) = @_;
  debug_rule("nb_single_one_line") if DEBUG;
  $self->rep(0, 0, $self->func('nb_single_char'));
};



# [123]
# nb-ns-single-in-line ::=
#   ( s-white* ns-single-char )*

rule '123', nb_ns_single_in_line => sub {
  my ($self) = @_;
  debug_rule("nb_ns_single_in_line") if DEBUG;
  $self->rep(0, 0,
    $self->all(
      $self->rep(0, 0, $self->func('s_white')),
      $self->func('ns_single_char')
    ));
};



# [124]
# s-single-next-line(n) ::=
#   s-flow-folded(n)
#   ( ns-single-char nb-ns-single-in-line
#   ( s-single-next-line(n) | s-white* ) )?

rule '124', s_single_next_line => sub {
  my ($self, $n) = @_;
  debug_rule("s_single_next_line",$n) if DEBUG;
  $self->all(
    [ $self->func('s_flow_folded'), $n ],
    $self->rep(0, 1,
      $self->all(
        $self->func('ns_single_char'),
        $self->func('nb_ns_single_in_line'),
        $self->any(
          [ $self->func('s_single_next_line'), $n ],
          $self->rep(0, 0, $self->func('s_white'))
        )
      ))
  );
};



# [125]
# nb-single-multi-line(n) ::=
#   nb-ns-single-in-line
#   ( s-single-next-line(n) | s-white* )

rule '125', nb_single_multi_line => sub {
  my ($self, $n) = @_;
  debug_rule("nb_single_multi_line",$n) if DEBUG;
  $self->all(
    $self->func('nb_ns_single_in_line'),
    $self->any(
      [ $self->func('s_single_next_line'), $n ],
      $self->rep(0, 0, $self->func('s_white'))
    )
  );
};



# [126]
# ns-plain-first(c) ::=
#   ( ns-char - c-indicator )
#   | ( ( '?' | ':' | '-' )
#   <followed_by_an_ns-plain-safe(c)> )

rule '126', ns_plain_first => sub {
  my ($self, $c) = @_;
  debug_rule("ns_plain_first",$c) if DEBUG;
  $self->any(
    $self->but(
      $self->func('ns_char'),
      $self->func('c_indicator')
    ),
    $self->all(
      $self->any(
        $self->chr('?'),
        $self->chr(':'),
        $self->chr('-')
      ),
      $self->chk('=', [ $self->func('ns_plain_safe'), $c ])
    )
  );
};



# [127]
# ns-plain-safe(c) ::=
#   ( c = flow-out => ns-plain-safe-out )
#   ( c = flow-in => ns-plain-safe-in )
#   ( c = block-key => ns-plain-safe-out )
#   ( c = flow-key => ns-plain-safe-in )

rule '127', ns_plain_safe => sub {
  my ($self, $c) = @_;
  debug_rule("ns_plain_safe",$c) if DEBUG;
  $self->case(
    $c,
    {
      'block-key' => $self->func('ns_plain_safe_out'),
      'flow-in' => $self->func('ns_plain_safe_in'),
      'flow-key' => $self->func('ns_plain_safe_in'),
      'flow-out' => $self->func('ns_plain_safe_out'),
    }
  );
};



# [128]
# ns-plain-safe-out ::=
#   ns-char

rule '128', ns_plain_safe_out => sub {
  my ($self) = @_;
  debug_rule("ns_plain_safe_out") if DEBUG;
  $self->func('ns_char');
};



# [129]
# ns-plain-safe-in ::=
#   ns-char - c-flow-indicator

rule '129', ns_plain_safe_in => sub {
  my ($self) = @_;
  debug_rule("ns_plain_safe_in") if DEBUG;
  $self->but(
    $self->func('ns_char'),
    $self->func('c_flow_indicator')
  );
};



# [130]
# ns-plain-char(c) ::=
#   ( ns-plain-safe(c) - ':' - '#' )
#   | ( <an_ns-char_preceding> '#' )
#   | ( ':' <followed_by_an_ns-plain-safe(c)> )

rule '130', ns_plain_char => sub {
  my ($self, $c) = @_;
  debug_rule("ns_plain_char",$c) if DEBUG;
  $self->any(
    $self->but(
      [ $self->func('ns_plain_safe'), $c ],
      $self->chr(':'),
      $self->chr('#')
    ),
    $self->all(
      $self->chk('<=', $self->func('ns_char')),
      $self->chr('#')
    ),
    $self->all(
      $self->chr(':'),
      $self->chk('=', [ $self->func('ns_plain_safe'), $c ])
    )
  );
};



# [131]
# ns-plain(n,c) ::=
#   ( c = flow-out => ns-plain-multi-line(n,c) )
#   ( c = flow-in => ns-plain-multi-line(n,c) )
#   ( c = block-key => ns-plain-one-line(c) )
#   ( c = flow-key => ns-plain-one-line(c) )

rule '131', ns_plain => sub {
  my ($self, $n, $c) = @_;
  debug_rule("ns_plain",$n,$c) if DEBUG;
  $self->case(
    $c,
    {
      'block-key' => [ $self->func('ns_plain_one_line'), $c ],
      'flow-in' => [ $self->func('ns_plain_multi_line'), $n, $c ],
      'flow-key' => [ $self->func('ns_plain_one_line'), $c ],
      'flow-out' => [ $self->func('ns_plain_multi_line'), $n, $c ],
    }
  );
};



# [132]
# nb-ns-plain-in-line(c) ::=
#   ( s-white*
#   ns-plain-char(c) )*

rule '132', nb_ns_plain_in_line => sub {
  my ($self, $c) = @_;
  debug_rule("nb_ns_plain_in_line",$c) if DEBUG;
  $self->rep(0, 0,
    $self->all(
      $self->rep(0, 0, $self->func('s_white')),
      [ $self->func('ns_plain_char'), $c ]
    ));
};



# [133]
# ns-plain-one-line(c) ::=
#   ns-plain-first(c)
#   nb-ns-plain-in-line(c)

rule '133', ns_plain_one_line => sub {
  my ($self, $c) = @_;
  debug_rule("ns_plain_one_line",$c) if DEBUG;
  $self->all(
    [ $self->func('ns_plain_first'), $c ],
    [ $self->func('nb_ns_plain_in_line'), $c ]
  );
};



# [134]
# s-ns-plain-next-line(n,c) ::=
#   s-flow-folded(n)
#   ns-plain-char(c) nb-ns-plain-in-line(c)

rule '134', s_ns_plain_next_line => sub {
  my ($self, $n, $c) = @_;
  debug_rule("s_ns_plain_next_line",$n,$c) if DEBUG;
  $self->all(
    [ $self->func('s_flow_folded'), $n ],
    [ $self->func('ns_plain_char'), $c ],
    [ $self->func('nb_ns_plain_in_line'), $c ]
  );
};



# [135]
# ns-plain-multi-line(n,c) ::=
#   ns-plain-one-line(c)
#   s-ns-plain-next-line(n,c)*

rule '135', ns_plain_multi_line => sub {
  my ($self, $n, $c) = @_;
  debug_rule("ns_plain_multi_line",$n,$c) if DEBUG;
  $self->all(
    [ $self->func('ns_plain_one_line'), $c ],
    $self->rep(0, 0, [ $self->func('s_ns_plain_next_line'), $n, $c ])
  );
};



# [136]
# in-flow(c) ::=
#   ( c = flow-out => flow-in )
#   ( c = flow-in => flow-in )
#   ( c = block-key => flow-key )
#   ( c = flow-key => flow-key )

rule '136', in_flow => sub {
  my ($self, $c) = @_;
  debug_rule("in_flow",$c) if DEBUG;
  $self->flip(
    $c,
    {
      'block-key' => "flow-key",
      'flow-in' => "flow-in",
      'flow-key' => "flow-key",
      'flow-out' => "flow-in",
    }
  );
};



# [137]
# c-flow-sequence(n,c) ::=
#   '[' s-separate(n,c)?
#   ns-s-flow-seq-entries(n,in-flow(c))? ']'

rule '137', c_flow_sequence => sub {
  my ($self, $n, $c) = @_;
  debug_rule("c_flow_sequence",$n,$c) if DEBUG;
  $self->all(
    $self->chr('['),
    $self->rep(0, 1, [ $self->func('s_separate'), $n, $c ]),
    $self->rep(0, 1, [ $self->func('ns_s_flow_seq_entries'), $n, [ $self->func('in_flow'), $c ] ]),
    $self->chr(']')
  );
};



# [138]
# ns-s-flow-seq-entries(n,c) ::=
#   ns-flow-seq-entry(n,c)
#   s-separate(n,c)?
#   ( ',' s-separate(n,c)?
#   ns-s-flow-seq-entries(n,c)? )?

rule '138', ns_s_flow_seq_entries => sub {
  my ($self, $n, $c) = @_;
  debug_rule("ns_s_flow_seq_entries",$n,$c) if DEBUG;
  $self->all(
    [ $self->func('ns_flow_seq_entry'), $n, $c ],
    $self->rep(0, 1, [ $self->func('s_separate'), $n, $c ]),
    $self->rep(0, 1,
      $self->all(
        $self->chr(','),
        $self->rep(0, 1, [ $self->func('s_separate'), $n, $c ]),
        $self->rep(0, 1, [ $self->func('ns_s_flow_seq_entries'), $n, $c ])
      ))
  );
};



# [139]
# ns-flow-seq-entry(n,c) ::=
#   ns-flow-pair(n,c) | ns-flow-node(n,c)

rule '139', ns_flow_seq_entry => sub {
  my ($self, $n, $c) = @_;
  debug_rule("ns_flow_seq_entry",$n,$c) if DEBUG;
  $self->any(
    [ $self->func('ns_flow_pair'), $n, $c ],
    [ $self->func('ns_flow_node'), $n, $c ]
  );
};



# [140]
# c-flow-mapping(n,c) ::=
#   '{' s-separate(n,c)?
#   ns-s-flow-map-entries(n,in-flow(c))? '}'

rule '140', c_flow_mapping => sub {
  my ($self, $n, $c) = @_;
  debug_rule("c_flow_mapping",$n,$c) if DEBUG;
  $self->all(
    $self->chr('{'),
    $self->rep(0, 1, [ $self->func('s_separate'), $n, $c ]),
    $self->rep(0, 1, [ $self->func('ns_s_flow_map_entries'), $n, [ $self->func('in_flow'), $c ] ]),
    $self->chr('}')
  );
};



# [141]
# ns-s-flow-map-entries(n,c) ::=
#   ns-flow-map-entry(n,c)
#   s-separate(n,c)?
#   ( ',' s-separate(n,c)?
#   ns-s-flow-map-entries(n,c)? )?

rule '141', ns_s_flow_map_entries => sub {
  my ($self, $n, $c) = @_;
  debug_rule("ns_s_flow_map_entries",$n,$c) if DEBUG;
  $self->all(
    [ $self->func('ns_flow_map_entry'), $n, $c ],
    $self->rep(0, 1, [ $self->func('s_separate'), $n, $c ]),
    $self->rep(0, 1,
      $self->all(
        $self->chr(','),
        $self->rep(0, 1, [ $self->func('s_separate'), $n, $c ]),
        $self->rep(0, 1, [ $self->func('ns_s_flow_map_entries'), $n, $c ])
      ))
  );
};



# [142]
# ns-flow-map-entry(n,c) ::=
#   ( '?' s-separate(n,c)
#   ns-flow-map-explicit-entry(n,c) )
#   | ns-flow-map-implicit-entry(n,c)

rule '142', ns_flow_map_entry => sub {
  my ($self, $n, $c) = @_;
  debug_rule("ns_flow_map_entry",$n,$c) if DEBUG;
  $self->any(
    $self->all(
      $self->chr('?'),
      [ $self->func('s_separate'), $n, $c ],
      [ $self->func('ns_flow_map_explicit_entry'), $n, $c ]
    ),
    [ $self->func('ns_flow_map_implicit_entry'), $n, $c ]
  );
};



# [143]
# ns-flow-map-explicit-entry(n,c) ::=
#   ns-flow-map-implicit-entry(n,c)
#   | ( e-node
#   e-node )

rule '143', ns_flow_map_explicit_entry => sub {
  my ($self, $n, $c) = @_;
  debug_rule("ns_flow_map_explicit_entry",$n,$c) if DEBUG;
  $self->any(
    [ $self->func('ns_flow_map_implicit_entry'), $n, $c ],
    $self->all(
      $self->func('e_node'),
      $self->func('e_node')
    )
  );
};



# [144]
# ns-flow-map-implicit-entry(n,c) ::=
#   ns-flow-map-yaml-key-entry(n,c)
#   | c-ns-flow-map-empty-key-entry(n,c)
#   | c-ns-flow-map-json-key-entry(n,c)

rule '144', ns_flow_map_implicit_entry => sub {
  my ($self, $n, $c) = @_;
  debug_rule("ns_flow_map_implicit_entry",$n,$c) if DEBUG;
  $self->any(
    [ $self->func('ns_flow_map_yaml_key_entry'), $n, $c ],
    [ $self->func('c_ns_flow_map_empty_key_entry'), $n, $c ],
    [ $self->func('c_ns_flow_map_json_key_entry'), $n, $c ]
  );
};



# [145]
# ns-flow-map-yaml-key-entry(n,c) ::=
#   ns-flow-yaml-node(n,c)
#   ( ( s-separate(n,c)?
#   c-ns-flow-map-separate-value(n,c) )
#   | e-node )

rule '145', ns_flow_map_yaml_key_entry => sub {
  my ($self, $n, $c) = @_;
  debug_rule("ns_flow_map_yaml_key_entry",$n,$c) if DEBUG;
  $self->all(
    [ $self->func('ns_flow_yaml_node'), $n, $c ],
    $self->any(
      $self->all(
        $self->rep(0, 1, [ $self->func('s_separate'), $n, $c ]),
        [ $self->func('c_ns_flow_map_separate_value'), $n, $c ]
      ),
      $self->func('e_node')
    )
  );
};



# [146]
# c-ns-flow-map-empty-key-entry(n,c) ::=
#   e-node
#   c-ns-flow-map-separate-value(n,c)

rule '146', c_ns_flow_map_empty_key_entry => sub {
  my ($self, $n, $c) = @_;
  debug_rule("c_ns_flow_map_empty_key_entry",$n,$c) if DEBUG;
  $self->all(
    $self->func('e_node'),
    [ $self->func('c_ns_flow_map_separate_value'), $n, $c ]
  );
};



# [147]
# c-ns-flow-map-separate-value(n,c) ::=
#   ':' <not_followed_by_an_ns-plain-safe(c)>
#   ( ( s-separate(n,c) ns-flow-node(n,c) )
#   | e-node )

rule '147', c_ns_flow_map_separate_value => sub {
  my ($self, $n, $c) = @_;
  debug_rule("c_ns_flow_map_separate_value",$n,$c) if DEBUG;
  $self->all(
    $self->chr(':'),
    $self->chk('!', [ $self->func('ns_plain_safe'), $c ]),
    $self->any(
      $self->all(
        [ $self->func('s_separate'), $n, $c ],
        [ $self->func('ns_flow_node'), $n, $c ]
      ),
      $self->func('e_node')
    )
  );
};



# [148]
# c-ns-flow-map-json-key-entry(n,c) ::=
#   c-flow-json-node(n,c)
#   ( ( s-separate(n,c)?
#   c-ns-flow-map-adjacent-value(n,c) )
#   | e-node )

rule '148', c_ns_flow_map_json_key_entry => sub {
  my ($self, $n, $c) = @_;
  debug_rule("c_ns_flow_map_json_key_entry",$n,$c) if DEBUG;
  $self->all(
    [ $self->func('c_flow_json_node'), $n, $c ],
    $self->any(
      $self->all(
        $self->rep(0, 1, [ $self->func('s_separate'), $n, $c ]),
        [ $self->func('c_ns_flow_map_adjacent_value'), $n, $c ]
      ),
      $self->func('e_node')
    )
  );
};



# [149]
# c-ns-flow-map-adjacent-value(n,c) ::=
#   ':' ( (
#   s-separate(n,c)?
#   ns-flow-node(n,c) )
#   | e-node )

rule '149', c_ns_flow_map_adjacent_value => sub {
  my ($self, $n, $c) = @_;
  debug_rule("c_ns_flow_map_adjacent_value",$n,$c) if DEBUG;
  $self->all(
    $self->chr(':'),
    $self->any(
      $self->all(
        $self->rep(0, 1, [ $self->func('s_separate'), $n, $c ]),
        [ $self->func('ns_flow_node'), $n, $c ]
      ),
      $self->func('e_node')
    )
  );
};



# [150]
# ns-flow-pair(n,c) ::=
#   ( '?' s-separate(n,c)
#   ns-flow-map-explicit-entry(n,c) )
#   | ns-flow-pair-entry(n,c)

rule '150', ns_flow_pair => sub {
  my ($self, $n, $c) = @_;
  debug_rule("ns_flow_pair",$n,$c) if DEBUG;
  $self->any(
    $self->all(
      $self->chr('?'),
      [ $self->func('s_separate'), $n, $c ],
      [ $self->func('ns_flow_map_explicit_entry'), $n, $c ]
    ),
    [ $self->func('ns_flow_pair_entry'), $n, $c ]
  );
};



# [151]
# ns-flow-pair-entry(n,c) ::=
#   ns-flow-pair-yaml-key-entry(n,c)
#   | c-ns-flow-map-empty-key-entry(n,c)
#   | c-ns-flow-pair-json-key-entry(n,c)

rule '151', ns_flow_pair_entry => sub {
  my ($self, $n, $c) = @_;
  debug_rule("ns_flow_pair_entry",$n,$c) if DEBUG;
  $self->any(
    [ $self->func('ns_flow_pair_yaml_key_entry'), $n, $c ],
    [ $self->func('c_ns_flow_map_empty_key_entry'), $n, $c ],
    [ $self->func('c_ns_flow_pair_json_key_entry'), $n, $c ]
  );
};



# [152]
# ns-flow-pair-yaml-key-entry(n,c) ::=
#   ns-s-implicit-yaml-key(flow-key)
#   c-ns-flow-map-separate-value(n,c)

rule '152', ns_flow_pair_yaml_key_entry => sub {
  my ($self, $n, $c) = @_;
  debug_rule("ns_flow_pair_yaml_key_entry",$n,$c) if DEBUG;
  $self->all(
    [ $self->func('ns_s_implicit_yaml_key'), "flow-key" ],
    [ $self->func('c_ns_flow_map_separate_value'), $n, $c ]
  );
};



# [153]
# c-ns-flow-pair-json-key-entry(n,c) ::=
#   c-s-implicit-json-key(flow-key)
#   c-ns-flow-map-adjacent-value(n,c)

rule '153', c_ns_flow_pair_json_key_entry => sub {
  my ($self, $n, $c) = @_;
  debug_rule("c_ns_flow_pair_json_key_entry",$n,$c) if DEBUG;
  $self->all(
    [ $self->func('c_s_implicit_json_key'), "flow-key" ],
    [ $self->func('c_ns_flow_map_adjacent_value'), $n, $c ]
  );
};



# [154]
# ns-s-implicit-yaml-key(c) ::=
#   ns-flow-yaml-node(n/a,c)
#   s-separate-in-line?
#   <at_most_1024_characters_altogether>

rule '154', ns_s_implicit_yaml_key => sub {
  my ($self, $c) = @_;
  debug_rule("ns_s_implicit_yaml_key",$c) if DEBUG;
  $self->all(
    $self->max(1024),
    [ $self->func('ns_flow_yaml_node'), undef, $c ],
    $self->rep(0, 1, $self->func('s_separate_in_line'))
  );
};



# [155]
# c-s-implicit-json-key(c) ::=
#   c-flow-json-node(n/a,c)
#   s-separate-in-line?
#   <at_most_1024_characters_altogether>

rule '155', c_s_implicit_json_key => sub {
  my ($self, $c) = @_;
  debug_rule("c_s_implicit_json_key",$c) if DEBUG;
  $self->all(
    $self->max(1024),
    [ $self->func('c_flow_json_node'), undef, $c ],
    $self->rep(0, 1, $self->func('s_separate_in_line'))
  );
};



# [156]
# ns-flow-yaml-content(n,c) ::=
#   ns-plain(n,c)

rule '156', ns_flow_yaml_content => sub {
  my ($self, $n, $c) = @_;
  debug_rule("ns_flow_yaml_content",$n,$c) if DEBUG;
  [ $self->func('ns_plain'), $n, $c ];
};



# [157]
# c-flow-json-content(n,c) ::=
#   c-flow-sequence(n,c) | c-flow-mapping(n,c)
#   | c-single-quoted(n,c) | c-double-quoted(n,c)

rule '157', c_flow_json_content => sub {
  my ($self, $n, $c) = @_;
  debug_rule("c_flow_json_content",$n,$c) if DEBUG;
  $self->any(
    [ $self->func('c_flow_sequence'), $n, $c ],
    [ $self->func('c_flow_mapping'), $n, $c ],
    [ $self->func('c_single_quoted'), $n, $c ],
    [ $self->func('c_double_quoted'), $n, $c ]
  );
};



# [158]
# ns-flow-content(n,c) ::=
#   ns-flow-yaml-content(n,c) | c-flow-json-content(n,c)

rule '158', ns_flow_content => sub {
  my ($self, $n, $c) = @_;
  debug_rule("ns_flow_content",$n,$c) if DEBUG;
  $self->any(
    [ $self->func('ns_flow_yaml_content'), $n, $c ],
    [ $self->func('c_flow_json_content'), $n, $c ]
  );
};



# [159]
# ns-flow-yaml-node(n,c) ::=
#   c-ns-alias-node
#   | ns-flow-yaml-content(n,c)
#   | ( c-ns-properties(n,c)
#   ( ( s-separate(n,c)
#   ns-flow-yaml-content(n,c) )
#   | e-scalar ) )

rule '159', ns_flow_yaml_node => sub {
  my ($self, $n, $c) = @_;
  debug_rule("ns_flow_yaml_node",$n,$c) if DEBUG;
  $self->any(
    $self->func('c_ns_alias_node'),
    [ $self->func('ns_flow_yaml_content'), $n, $c ],
    $self->all(
      [ $self->func('c_ns_properties'), $n, $c ],
      $self->any(
        $self->all(
          [ $self->func('s_separate'), $n, $c ],
          [ $self->func('ns_flow_yaml_content'), $n, $c ]
        ),
        $self->func('e_scalar')
      )
    )
  );
};



# [160]
# c-flow-json-node(n,c) ::=
#   ( c-ns-properties(n,c)
#   s-separate(n,c) )?
#   c-flow-json-content(n,c)

rule '160', c_flow_json_node => sub {
  my ($self, $n, $c) = @_;
  debug_rule("c_flow_json_node",$n,$c) if DEBUG;
  $self->all(
    $self->rep(0, 1,
      $self->all(
        [ $self->func('c_ns_properties'), $n, $c ],
        [ $self->func('s_separate'), $n, $c ]
      )),
    [ $self->func('c_flow_json_content'), $n, $c ]
  );
};



# [161]
# ns-flow-node(n,c) ::=
#   c-ns-alias-node
#   | ns-flow-content(n,c)
#   | ( c-ns-properties(n,c)
#   ( ( s-separate(n,c)
#   ns-flow-content(n,c) )
#   | e-scalar ) )

rule '161', ns_flow_node => sub {
  my ($self, $n, $c) = @_;
  debug_rule("ns_flow_node",$n,$c) if DEBUG;
  $self->any(
    $self->func('c_ns_alias_node'),
    [ $self->func('ns_flow_content'), $n, $c ],
    $self->all(
      [ $self->func('c_ns_properties'), $n, $c ],
      $self->any(
        $self->all(
          [ $self->func('s_separate'), $n, $c ],
          [ $self->func('ns_flow_content'), $n, $c ]
        ),
        $self->func('e_scalar')
      )
    )
  );
};



# [162]
# c-b-block-header(m,t) ::=
#   ( ( c-indentation-indicator(m)
#   c-chomping-indicator(t) )
#   | ( c-chomping-indicator(t)
#   c-indentation-indicator(m) ) )
#   s-b-comment

rule '162', c_b_block_header => sub {
  my ($self, $m, $t) = @_;
  debug_rule("c_b_block_header",$m,$t) if DEBUG;
  $self->all(
    $self->any(
      $self->all(
        [ $self->func('c_indentation_indicator'), $m ],
        [ $self->func('c_chomping_indicator'), $t ]
      ),
      $self->all(
        [ $self->func('c_chomping_indicator'), $t ],
        [ $self->func('c_indentation_indicator'), $m ]
      )
    ),
    $self->func('s_b_comment')
  );
};



# [163]
# c-indentation-indicator(m) ::=
#   ( ns-dec-digit => m = ns-dec-digit - x:30 )
#   ( <empty> => m = auto-detect() )

rule '163', c_indentation_indicator => sub {
  my ($self, $m) = @_;
  debug_rule("c_indentation_indicator",$m) if DEBUG;
  $self->any(
    $self->if($self->func('ns_dec_digit'), $self->set('m', $self->ord($self->func('match')))),
    $self->if($self->func('empty'), $self->set('m', "auto-detect"))
  );
};



# [164]
# c-chomping-indicator(t) ::=
#   ( '-' => t = strip )
#   ( '+' => t = keep )
#   ( <empty> => t = clip )

rule '164', c_chomping_indicator => sub {
  my ($self, $t) = @_;
  debug_rule("c_chomping_indicator",$t) if DEBUG;
  $self->any(
    $self->if($self->chr('-'), $self->set('t', "strip")),
    $self->if($self->chr('+'), $self->set('t', "keep")),
    $self->if($self->func('empty'), $self->set('t', "clip"))
  );
};



# [165]
# b-chomped-last(t) ::=
#   ( t = strip => b-non-content | <end_of_file> )
#   ( t = clip => b-as-line-feed | <end_of_file> )
#   ( t = keep => b-as-line-feed | <end_of_file> )

rule '165', b_chomped_last => sub {
  my ($self, $t) = @_;
  debug_rule("b_chomped_last",$t) if DEBUG;
  $self->case(
    $t,
    {
      'clip' => $self->any( $self->func('b_as_line_feed'), $self->func('end_of_stream') ),
      'keep' => $self->any( $self->func('b_as_line_feed'), $self->func('end_of_stream') ),
      'strip' => $self->any( $self->func('b_non_content'), $self->func('end_of_stream') ),
    }
  );
};



# [166]
# l-chomped-empty(n,t) ::=
#   ( t = strip => l-strip-empty(n) )
#   ( t = clip => l-strip-empty(n) )
#   ( t = keep => l-keep-empty(n) )

rule '166', l_chomped_empty => sub {
  my ($self, $n, $t) = @_;
  debug_rule("l_chomped_empty",$n,$t) if DEBUG;
  $self->case(
    $t,
    {
      'clip' => [ $self->func('l_strip_empty'), $n ],
      'keep' => [ $self->func('l_keep_empty'), $n ],
      'strip' => [ $self->func('l_strip_empty'), $n ],
    }
  );
};



# [167]
# l-strip-empty(n) ::=
#   ( s-indent(<=n) b-non-content )*
#   l-trail-comments(n)?

rule '167', l_strip_empty => sub {
  my ($self, $n) = @_;
  debug_rule("l_strip_empty",$n) if DEBUG;
  $self->all(
    $self->rep(0, 0,
      $self->all(
        [ $self->func('s_indent_le'), $n ],
        $self->func('b_non_content')
      )),
    $self->rep(0, 1, [ $self->func('l_trail_comments'), $n ])
  );
};



# [168]
# l-keep-empty(n) ::=
#   l-empty(n,block-in)*
#   l-trail-comments(n)?

rule '168', l_keep_empty => sub {
  my ($self, $n) = @_;
  debug_rule("l_keep_empty",$n) if DEBUG;
  $self->all(
    $self->rep(0, 0, [ $self->func('l_empty'), $n, "block-in" ]),
    $self->rep(0, 1, [ $self->func('l_trail_comments'), $n ])
  );
};



# [169]
# l-trail-comments(n) ::=
#   s-indent(<n)
#   c-nb-comment-text b-comment
#   l-comment*

rule '169', l_trail_comments => sub {
  my ($self, $n) = @_;
  debug_rule("l_trail_comments",$n) if DEBUG;
  $self->all(
    [ $self->func('s_indent_lt'), $n ],
    $self->func('c_nb_comment_text'),
    $self->func('b_comment'),
    $self->rep(0, 0, $self->func('l_comment'))
  );
};



# [170]
# c-l+literal(n) ::=
#   '|' c-b-block-header(m,t)
#   l-literal-content(n+m,t)

rule '170', c_l_literal => sub {
  my ($self, $n) = @_;
  debug_rule("c_l_literal",$n) if DEBUG;
  $self->all(
    $self->chr('|'),
    [ $self->func('c_b_block_header'), $self->m(), $self->t() ],
    [ $self->func('l_literal_content'), $self->add($n, $self->m()), $self->t() ]
  );
};



# [171]
# l-nb-literal-text(n) ::=
#   l-empty(n,block-in)*
#   s-indent(n) nb-char+

rule '171', l_nb_literal_text => sub {
  my ($self, $n) = @_;
  debug_rule("l_nb_literal_text",$n) if DEBUG;
  $self->all(
    $self->rep(0, 0, [ $self->func('l_empty'), $n, "block-in" ]),
    [ $self->func('s_indent'), $n ],
    $self->rep(1, 0, $self->func('nb_char'))
  );
};



# [172]
# b-nb-literal-next(n) ::=
#   b-as-line-feed
#   l-nb-literal-text(n)

rule '172', b_nb_literal_next => sub {
  my ($self, $n) = @_;
  debug_rule("b_nb_literal_next",$n) if DEBUG;
  $self->all(
    $self->func('b_as_line_feed'),
    [ $self->func('l_nb_literal_text'), $n ]
  );
};



# [173]
# l-literal-content(n,t) ::=
#   ( l-nb-literal-text(n)
#   b-nb-literal-next(n)*
#   b-chomped-last(t) )?
#   l-chomped-empty(n,t)

rule '173', l_literal_content => sub {
  my ($self, $n, $t) = @_;
  debug_rule("l_literal_content",$n,$t) if DEBUG;
  $self->all(
    $self->rep(0, 1,
      $self->all(
        [ $self->func('l_nb_literal_text'), $n ],
        $self->rep(0, 0, [ $self->func('b_nb_literal_next'), $n ]),
        [ $self->func('b_chomped_last'), $t ]
      )),
    [ $self->func('l_chomped_empty'), $n, $t ]
  );
};



# [174]
# c-l+folded(n) ::=
#   '>' c-b-block-header(m,t)
#   l-folded-content(n+m,t)

rule '174', c_l_folded => sub {
  my ($self, $n) = @_;
  debug_rule("c_l_folded",$n) if DEBUG;
  $self->all(
    $self->chr('>'),
    [ $self->func('c_b_block_header'), $self->m(), $self->t() ],
    [ $self->func('l_folded_content'), $self->add($n, $self->m()), $self->t() ]
  );
};



# [175]
# s-nb-folded-text(n) ::=
#   s-indent(n) ns-char
#   nb-char*

rule '175', s_nb_folded_text => sub {
  my ($self, $n) = @_;
  debug_rule("s_nb_folded_text",$n) if DEBUG;
  $self->all(
    [ $self->func('s_indent'), $n ],
    $self->func('ns_char'),
    $self->rep(0, 0, $self->func('nb_char'))
  );
};



# [176]
# l-nb-folded-lines(n) ::=
#   s-nb-folded-text(n)
#   ( b-l-folded(n,block-in) s-nb-folded-text(n) )*

rule '176', l_nb_folded_lines => sub {
  my ($self, $n) = @_;
  debug_rule("l_nb_folded_lines",$n) if DEBUG;
  $self->all(
    [ $self->func('s_nb_folded_text'), $n ],
    $self->rep(0, 0,
      $self->all(
        [ $self->func('b_l_folded'), $n, "block-in" ],
        [ $self->func('s_nb_folded_text'), $n ]
      ))
  );
};



# [177]
# s-nb-spaced-text(n) ::=
#   s-indent(n) s-white
#   nb-char*

rule '177', s_nb_spaced_text => sub {
  my ($self, $n) = @_;
  debug_rule("s_nb_spaced_text",$n) if DEBUG;
  $self->all(
    [ $self->func('s_indent'), $n ],
    $self->func('s_white'),
    $self->rep(0, 0, $self->func('nb_char'))
  );
};



# [178]
# b-l-spaced(n) ::=
#   b-as-line-feed
#   l-empty(n,block-in)*

rule '178', b_l_spaced => sub {
  my ($self, $n) = @_;
  debug_rule("b_l_spaced",$n) if DEBUG;
  $self->all(
    $self->func('b_as_line_feed'),
    $self->rep(0, 0, [ $self->func('l_empty'), $n, "block-in" ])
  );
};



# [179]
# l-nb-spaced-lines(n) ::=
#   s-nb-spaced-text(n)
#   ( b-l-spaced(n) s-nb-spaced-text(n) )*

rule '179', l_nb_spaced_lines => sub {
  my ($self, $n) = @_;
  debug_rule("l_nb_spaced_lines",$n) if DEBUG;
  $self->all(
    [ $self->func('s_nb_spaced_text'), $n ],
    $self->rep(0, 0,
      $self->all(
        [ $self->func('b_l_spaced'), $n ],
        [ $self->func('s_nb_spaced_text'), $n ]
      ))
  );
};



# [180]
# l-nb-same-lines(n) ::=
#   l-empty(n,block-in)*
#   ( l-nb-folded-lines(n) | l-nb-spaced-lines(n) )

rule '180', l_nb_same_lines => sub {
  my ($self, $n) = @_;
  debug_rule("l_nb_same_lines",$n) if DEBUG;
  $self->all(
    $self->rep(0, 0, [ $self->func('l_empty'), $n, "block-in" ]),
    $self->any(
      [ $self->func('l_nb_folded_lines'), $n ],
      [ $self->func('l_nb_spaced_lines'), $n ]
    )
  );
};



# [181]
# l-nb-diff-lines(n) ::=
#   l-nb-same-lines(n)
#   ( b-as-line-feed l-nb-same-lines(n) )*

rule '181', l_nb_diff_lines => sub {
  my ($self, $n) = @_;
  debug_rule("l_nb_diff_lines",$n) if DEBUG;
  $self->all(
    [ $self->func('l_nb_same_lines'), $n ],
    $self->rep(0, 0,
      $self->all(
        $self->func('b_as_line_feed'),
        [ $self->func('l_nb_same_lines'), $n ]
      ))
  );
};



# [182]
# l-folded-content(n,t) ::=
#   ( l-nb-diff-lines(n)
#   b-chomped-last(t) )?
#   l-chomped-empty(n,t)

rule '182', l_folded_content => sub {
  my ($self, $n, $t) = @_;
  debug_rule("l_folded_content",$n,$t) if DEBUG;
  $self->all(
    $self->rep(0, 1,
      $self->all(
        [ $self->func('l_nb_diff_lines'), $n ],
        [ $self->func('b_chomped_last'), $t ]
      )),
    [ $self->func('l_chomped_empty'), $n, $t ]
  );
};



# [183]
# l+block-sequence(n) ::=
#   ( s-indent(n+m)
#   c-l-block-seq-entry(n+m) )+
#   <for_some_fixed_auto-detected_m_>_0>

rule '183', l_block_sequence => sub {
  my ($self, $n) = @_;
  debug_rule("l_block_sequence",$n) if DEBUG;
  $self->all(
    $self->set('m', $self->func('auto_detect_indent')),
    $self->rep(1, 0,
      $self->all(
        [ $self->func('s_indent'), $self->add($n, $self->m()) ],
        [ $self->func('c_l_block_seq_entry'), $self->add($n, $self->m()) ]
      ))
  );
};



# [184]
# c-l-block-seq-entry(n) ::=
#   '-' <not_followed_by_an_ns-char>
#   s-l+block-indented(n,block-in)

rule '184', c_l_block_seq_entry => sub {
  my ($self, $n) = @_;
  debug_rule("c_l_block_seq_entry",$n) if DEBUG;
  $self->all(
    $self->chr('-'),
    $self->chk('!', $self->func('ns_char')),
    [ $self->func('s_l_block_indented'), $n, "block-in" ]
  );
};



# [185]
# s-l+block-indented(n,c) ::=
#   ( s-indent(m)
#   ( ns-l-compact-sequence(n+1+m)
#   | ns-l-compact-mapping(n+1+m) ) )
#   | s-l+block-node(n,c)
#   | ( e-node s-l-comments )

rule '185', s_l_block_indented => sub {
  my ($self, $n, $c) = @_;
  debug_rule("s_l_block_indented",$n,$c) if DEBUG;
  $self->any(
    $self->all(
      [ $self->func('s_indent'), $self->m() ],
      $self->any(
        [ $self->func('ns_l_compact_sequence'), $self->add($n, $self->add(1, $self->m())) ],
        [ $self->func('ns_l_compact_mapping'), $self->add($n, $self->add(1, $self->m())) ]
      )
    ),
    [ $self->func('s_l_block_node'), $n, $c ],
    $self->all(
      $self->func('e_node'),
      $self->func('s_l_comments')
    )
  );
};



# [186]
# ns-l-compact-sequence(n) ::=
#   c-l-block-seq-entry(n)
#   ( s-indent(n) c-l-block-seq-entry(n) )*

rule '186', ns_l_compact_sequence => sub {
  my ($self, $n) = @_;
  debug_rule("ns_l_compact_sequence",$n) if DEBUG;
  $self->all(
    [ $self->func('c_l_block_seq_entry'), $n ],
    $self->rep(0, 0,
      $self->all(
        [ $self->func('s_indent'), $n ],
        [ $self->func('c_l_block_seq_entry'), $n ]
      ))
  );
};



# [187]
# l+block-mapping(n) ::=
#   ( s-indent(n+m)
#   ns-l-block-map-entry(n+m) )+
#   <for_some_fixed_auto-detected_m_>_0>

rule '187', l_block_mapping => sub {
  my ($self, $n) = @_;
  debug_rule("l_block_mapping",$n) if DEBUG;
  $self->all(
    $self->set('m', $self->func('auto_detect_indent')),
    $self->rep(1, 0,
      $self->all(
        [ $self->func('s_indent'), $self->add($n, $self->m()) ],
        [ $self->func('ns_l_block_map_entry'), $self->add($n, $self->m()) ]
      ))
  );
};



# [188]
# ns-l-block-map-entry(n) ::=
#   c-l-block-map-explicit-entry(n)
#   | ns-l-block-map-implicit-entry(n)

rule '188', ns_l_block_map_entry => sub {
  my ($self, $n) = @_;
  debug_rule("ns_l_block_map_entry",$n) if DEBUG;
  $self->any(
    [ $self->func('c_l_block_map_explicit_entry'), $n ],
    [ $self->func('ns_l_block_map_implicit_entry'), $n ]
  );
};



# [189]
# c-l-block-map-explicit-entry(n) ::=
#   c-l-block-map-explicit-key(n)
#   ( l-block-map-explicit-value(n)
#   | e-node )

rule '189', c_l_block_map_explicit_entry => sub {
  my ($self, $n) = @_;
  debug_rule("c_l_block_map_explicit_entry",$n) if DEBUG;
  $self->all(
    [ $self->func('c_l_block_map_explicit_key'), $n ],
    $self->any(
      [ $self->func('l_block_map_explicit_value'), $n ],
      $self->func('e_node')
    )
  );
};



# [190]
# c-l-block-map-explicit-key(n) ::=
#   '?'
#   s-l+block-indented(n,block-out)

rule '190', c_l_block_map_explicit_key => sub {
  my ($self, $n) = @_;
  debug_rule("c_l_block_map_explicit_key",$n) if DEBUG;
  $self->all(
    $self->chr('?'),
    [ $self->func('s_l_block_indented'), $n, "block-out" ]
  );
};



# [191]
# l-block-map-explicit-value(n) ::=
#   s-indent(n)
#   ':' s-l+block-indented(n,block-out)

rule '191', l_block_map_explicit_value => sub {
  my ($self, $n) = @_;
  debug_rule("l_block_map_explicit_value",$n) if DEBUG;
  $self->all(
    [ $self->func('s_indent'), $n ],
    $self->chr(':'),
    [ $self->func('s_l_block_indented'), $n, "block-out" ]
  );
};



# [192]
# ns-l-block-map-implicit-entry(n) ::=
#   (
#   ns-s-block-map-implicit-key
#   | e-node )
#   c-l-block-map-implicit-value(n)

rule '192', ns_l_block_map_implicit_entry => sub {
  my ($self, $n) = @_;
  debug_rule("ns_l_block_map_implicit_entry",$n) if DEBUG;
  $self->all(
    $self->any(
      $self->func('ns_s_block_map_implicit_key'),
      $self->func('e_node')
    ),
    [ $self->func('c_l_block_map_implicit_value'), $n ]
  );
};



# [193]
# ns-s-block-map-implicit-key ::=
#   c-s-implicit-json-key(block-key)
#   | ns-s-implicit-yaml-key(block-key)

rule '193', ns_s_block_map_implicit_key => sub {
  my ($self) = @_;
  debug_rule("ns_s_block_map_implicit_key") if DEBUG;
  $self->any(
    [ $self->func('c_s_implicit_json_key'), "block-key" ],
    [ $self->func('ns_s_implicit_yaml_key'), "block-key" ]
  );
};



# [194]
# c-l-block-map-implicit-value(n) ::=
#   ':' (
#   s-l+block-node(n,block-out)
#   | ( e-node s-l-comments ) )

rule '194', c_l_block_map_implicit_value => sub {
  my ($self, $n) = @_;
  debug_rule("c_l_block_map_implicit_value",$n) if DEBUG;
  $self->all(
    $self->chr(':'),
    $self->any(
      [ $self->func('s_l_block_node'), $n, "block-out" ],
      $self->all(
        $self->func('e_node'),
        $self->func('s_l_comments')
      )
    )
  );
};



# [195]
# ns-l-compact-mapping(n) ::=
#   ns-l-block-map-entry(n)
#   ( s-indent(n) ns-l-block-map-entry(n) )*

rule '195', ns_l_compact_mapping => sub {
  my ($self, $n) = @_;
  debug_rule("ns_l_compact_mapping",$n) if DEBUG;
  $self->all(
    [ $self->func('ns_l_block_map_entry'), $n ],
    $self->rep(0, 0,
      $self->all(
        [ $self->func('s_indent'), $n ],
        [ $self->func('ns_l_block_map_entry'), $n ]
      ))
  );
};



# [196]
# s-l+block-node(n,c) ::=
#   s-l+block-in-block(n,c) | s-l+flow-in-block(n)

rule '196', s_l_block_node => sub {
  my ($self, $n, $c) = @_;
  debug_rule("s_l_block_node",$n,$c) if DEBUG;
  $self->any(
    [ $self->func('s_l_block_in_block'), $n, $c ],
    [ $self->func('s_l_flow_in_block'), $n ]
  );
};



# [197]
# s-l+flow-in-block(n) ::=
#   s-separate(n+1,flow-out)
#   ns-flow-node(n+1,flow-out) s-l-comments

rule '197', s_l_flow_in_block => sub {
  my ($self, $n) = @_;
  debug_rule("s_l_flow_in_block",$n) if DEBUG;
  $self->all(
    [ $self->func('s_separate'), $self->add($n, 1), "flow-out" ],
    [ $self->func('ns_flow_node'), $self->add($n, 1), "flow-out" ],
    $self->func('s_l_comments')
  );
};



# [198]
# s-l+block-in-block(n,c) ::=
#   s-l+block-scalar(n,c) | s-l+block-collection(n,c)

rule '198', s_l_block_in_block => sub {
  my ($self, $n, $c) = @_;
  debug_rule("s_l_block_in_block",$n,$c) if DEBUG;
  $self->any(
    [ $self->func('s_l_block_scalar'), $n, $c ],
    [ $self->func('s_l_block_collection'), $n, $c ]
  );
};



# [199]
# s-l+block-scalar(n,c) ::=
#   s-separate(n+1,c)
#   ( c-ns-properties(n+1,c) s-separate(n+1,c) )?
#   ( c-l+literal(n) | c-l+folded(n) )

rule '199', s_l_block_scalar => sub {
  my ($self, $n, $c) = @_;
  debug_rule("s_l_block_scalar",$n,$c) if DEBUG;
  $self->all(
    [ $self->func('s_separate'), $self->add($n, 1), $c ],
    $self->rep(0, 1,
      $self->all(
        [ $self->func('c_ns_properties'), $self->add($n, 1), $c ],
        [ $self->func('s_separate'), $self->add($n, 1), $c ]
      )),
    $self->any(
      [ $self->func('c_l_literal'), $n ],
      [ $self->func('c_l_folded'), $n ]
    )
  );
};



# [200]
# s-l+block-collection(n,c) ::=
#   ( s-separate(n+1,c)
#   c-ns-properties(n+1,c) )?
#   s-l-comments
#   ( l+block-sequence(seq-spaces(n,c))
#   | l+block-mapping(n) )

rule '200', s_l_block_collection => sub {
  my ($self, $n, $c) = @_;
  debug_rule("s_l_block_collection",$n,$c) if DEBUG;
  $self->all(
    $self->rep(0, 1,
      $self->all(
        [ $self->func('s_separate'), $self->add($n, 1), $c ],
        [ $self->func('c_ns_properties'), $self->add($n, 1), $c ]
      )),
    $self->func('s_l_comments'),
    $self->any(
      [ $self->func('l_block_sequence'), [ $self->func('seq_spaces'), $n, $c ] ],
      [ $self->func('l_block_mapping'), $n ]
    )
  );
};



# [201]
# seq-spaces(n,c) ::=
#   ( c = block-out => n-1 )
#   ( c = block-in => n )

rule '201', seq_spaces => sub {
  my ($self, $n, $c) = @_;
  debug_rule("seq_spaces",$n,$c) if DEBUG;
  $self->flip(
    $c,
    {
      'block-in' => $n,
      'block-out' => $self->sub($n, 1),
    }
  );
};



# [202]
# l-document-prefix ::=
#   c-byte-order-mark? l-comment*

rule '202', l_document_prefix => sub {
  my ($self) = @_;
  debug_rule("l_document_prefix") if DEBUG;
  $self->all(
    $self->rep(0, 1, $self->func('c_byte_order_mark')),
    $self->rep(0, 0, $self->func('l_comment'))
  );
};



# [203]
# c-directives-end ::=
#   '-' '-' '-'

rule '203', c_directives_end => sub {
  my ($self) = @_;
  debug_rule("c_directives_end") if DEBUG;
  $self->all(
    $self->chr('-'),
    $self->chr('-'),
    $self->chr('-')
  );
};



# [204]
# c-document-end ::=
#   '.' '.' '.'

rule '204', c_document_end => sub {
  my ($self) = @_;
  debug_rule("c_document_end") if DEBUG;
  $self->all(
    $self->chr('.'),
    $self->chr('.'),
    $self->chr('.')
  );
};



# [205]
# l-document-suffix ::=
#   c-document-end s-l-comments

rule '205', l_document_suffix => sub {
  my ($self) = @_;
  debug_rule("l_document_suffix") if DEBUG;
  $self->all(
    $self->func('c_document_end'),
    $self->func('s_l_comments')
  );
};



# [206]
# c-forbidden ::=
#   <start_of_line>
#   ( c-directives-end | c-document-end )
#   ( b-char | s-white | <end_of_file> )

rule '206', c_forbidden => sub {
  my ($self) = @_;
  debug_rule("c_forbidden") if DEBUG;
  $self->all(
    $self->func('start_of_line'),
    $self->any(
      $self->func('c_directives_end'),
      $self->func('c_document_end')
    ),
    $self->any(
      $self->func('b_char'),
      $self->func('s_white'),
      $self->func('end_of_stream')
    )
  );
};



# [207]
# l-bare-document ::=
#   s-l+block-node(-1,block-in)
#   <excluding_c-forbidden_content>

rule '207', l_bare_document => sub {
  my ($self) = @_;
  debug_rule("l_bare_document") if DEBUG;
  $self->all(
    $self->exclude($self->func('c_forbidden')),
    [ $self->func('s_l_block_node'), -1, "block-in" ]
  );
};



# [208]
# l-explicit-document ::=
#   c-directives-end
#   ( l-bare-document
#   | ( e-node s-l-comments ) )

rule '208', l_explicit_document => sub {
  my ($self) = @_;
  debug_rule("l_explicit_document") if DEBUG;
  $self->all(
    $self->func('c_directives_end'),
    $self->any(
      $self->func('l_bare_document'),
      $self->all(
        $self->func('e_node'),
        $self->func('s_l_comments')
      )
    )
  );
};



# [209]
# l-directive-document ::=
#   l-directive+
#   l-explicit-document

rule '209', l_directive_document => sub {
  my ($self) = @_;
  debug_rule("l_directive_document") if DEBUG;
  $self->all(
    $self->rep(1, 0, $self->func('l_directive')),
    $self->func('l_explicit_document')
  );
};



# [210]
# l-any-document ::=
#   l-directive-document
#   | l-explicit-document
#   | l-bare-document

rule '210', l_any_document => sub {
  my ($self) = @_;
  debug_rule("l_any_document") if DEBUG;
  $self->any(
    $self->func('l_directive_document'),
    $self->func('l_explicit_document'),
    $self->func('l_bare_document')
  );
};



# [211]
# l-yaml-stream ::=
#   l-document-prefix* l-any-document?
#   ( ( l-document-suffix+ l-document-prefix*
#   l-any-document? )
#   | ( l-document-prefix* l-explicit-document? ) )*

rule '211', l_yaml_stream => sub {
  my ($self) = @_;
  debug_rule("l_yaml_stream") if DEBUG;
  $self->all(
    $self->rep(0, 0, $self->func('l_document_prefix')),
    $self->rep(0, 1, $self->func('l_any_document')),
    $self->rep(0, 0,
      $self->any(
        $self->all(
          $self->rep(1, 0, $self->func('l_document_suffix')),
          $self->rep(0, 0, $self->func('l_document_prefix')),
          $self->rep(0, 1, $self->func('l_any_document'))
        ),
        $self->all(
          $self->rep(0, 0, $self->func('l_document_prefix')),
          $self->rep(0, 1, $self->func('l_explicit_document'))
        )
      ))
  );
};



1;