# ###
# This grammar class was generated from https://yaml.org/spec/1.2/spec.html
###

__all__ = ["Grammar"]

from prelude import *

class Grammar:

  def TOP(self):
    return self.l_yaml_stream


  # [001]
  # c-printable ::=
  #   x:9 | x:A | x:D | [x:20-x:7E]
  #   | x:85 | [x:A0-x:D7FF] | [x:E000-x:FFFD]
  #   | [x:10000-x:10FFFF]

  # @::c_printable.num = 1
  def c_printable(self):
    debug_rule("c_printable")
    return self.any(
      self.chr('\x09'),
      self.chr('\x0A'),
      self.chr('\x0D'),
      self.rng('\x20', '\x7E'),
      self.chr('\x85'),
      self.rng('\xA0', '\uD7FF'),
      self.rng('\uE000', '\uFFFD'),
      self.rng('\U00010000', '\U0010FFFF')
    )



  # [002]
  # nb-json ::=
  #   x:9 | [x:20-x:10FFFF]

  # @::nb_json.num = 2
  def nb_json(self):
    debug_rule("nb_json")
    return self.any(
      self.chr('\x09'),
      self.rng('\x20', '\U0010FFFF')
    )



  # [003]
  # c-byte-order-mark ::=
  #   x:FEFF

  # @::c_byte_order_mark.num = 3
  def c_byte_order_mark(self):
    debug_rule("c_byte_order_mark")
    return self.chr('\uFEFF')



  # [004]
  # c-sequence-entry ::=
  #   '-'

  # @::c_sequence_entry.num = 4
  def c_sequence_entry(self):
    debug_rule("c_sequence_entry")
    return self.chr('-')



  # [005]
  # c-mapping-key ::=
  #   '?'

  # @::c_mapping_key.num = 5
  def c_mapping_key(self):
    debug_rule("c_mapping_key")
    return self.chr('?')



  # [006]
  # c-mapping-value ::=
  #   ':'

  # @::c_mapping_value.num = 6
  def c_mapping_value(self):
    debug_rule("c_mapping_value")
    return self.chr(':')



  # [007]
  # c-collect-entry ::=
  #   ','

  # @::c_collect_entry.num = 7
  def c_collect_entry(self):
    debug_rule("c_collect_entry")
    return self.chr(',')



  # [008]
  # c-sequence-start ::=
  #   '['

  # @::c_sequence_start.num = 8
  def c_sequence_start(self):
    debug_rule("c_sequence_start")
    return self.chr('[')



  # [009]
  # c-sequence-end ::=
  #   ']'

  # @::c_sequence_end.num = 9
  def c_sequence_end(self):
    debug_rule("c_sequence_end")
    return self.chr(']')



  # [010]
  # c-mapping-start ::=
  #   '{'

  # @::c_mapping_start.num = 10
  def c_mapping_start(self):
    debug_rule("c_mapping_start")
    return self.chr('{')



  # [011]
  # c-mapping-end ::=
  #   '}'

  # @::c_mapping_end.num = 11
  def c_mapping_end(self):
    debug_rule("c_mapping_end")
    return self.chr('}')



  # [012]
  # c-comment ::=
  #   '#'

  # @::c_comment.num = 12
  def c_comment(self):
    debug_rule("c_comment")
    return self.chr('#')



  # [013]
  # c-anchor ::=
  #   '&'

  # @::c_anchor.num = 13
  def c_anchor(self):
    debug_rule("c_anchor")
    return self.chr('&')



  # [014]
  # c-alias ::=
  #   '*'

  # @::c_alias.num = 14
  def c_alias(self):
    debug_rule("c_alias")
    return self.chr('*')



  # [015]
  # c-tag ::=
  #   '!'

  # @::c_tag.num = 15
  def c_tag(self):
    debug_rule("c_tag")
    return self.chr('!')



  # [016]
  # c-literal ::=
  #   '|'

  # @::c_literal.num = 16
  def c_literal(self):
    debug_rule("c_literal")
    return self.chr('|')



  # [017]
  # c-folded ::=
  #   '>'

  # @::c_folded.num = 17
  def c_folded(self):
    debug_rule("c_folded")
    return self.chr('>')



  # [018]
  # c-single-quote ::=
  #   '''

  # @::c_single_quote.num = 18
  def c_single_quote(self):
    debug_rule("c_single_quote")
    return self.chr("'")



  # [019]
  # c-double-quote ::=
  #   '"'

  # @::c_double_quote.num = 19
  def c_double_quote(self):
    debug_rule("c_double_quote")
    return self.chr('"')



  # [020]
  # c-directive ::=
  #   '%'

  # @::c_directive.num = 20
  def c_directive(self):
    debug_rule("c_directive")
    return self.chr('%')



  # [021]
  # c-reserved ::=
  #   '@' | '`'

  # @::c_reserved.num = 21
  def c_reserved(self):
    debug_rule("c_reserved")
    return self.any(
      self.chr('@'),
      self.chr('`')
    )



  # [022]
  # c-indicator ::=
  #   '-' | '?' | ':' | ',' | '[' | ']' | '{' | '}'
  #   | '#' | '&' | '*' | '!' | '|' | '>' | ''' | '"'
  #   | '%' | '@' | '`'

  # @::c_indicator.num = 22
  def c_indicator(self):
    debug_rule("c_indicator")
    return self.any(
      self.chr('-'),
      self.chr('?'),
      self.chr(':'),
      self.chr(','),
      self.chr('['),
      self.chr(']'),
      self.chr('{'),
      self.chr('}'),
      self.chr('#'),
      self.chr('&'),
      self.chr('*'),
      self.chr('!'),
      self.chr('|'),
      self.chr('>'),
      self.chr("'"),
      self.chr('"'),
      self.chr('%'),
      self.chr('@'),
      self.chr('`')
    )



  # [023]
  # c-flow-indicator ::=
  #   ',' | '[' | ']' | '{' | '}'

  # @::c_flow_indicator.num = 23
  def c_flow_indicator(self):
    debug_rule("c_flow_indicator")
    return self.any(
      self.chr(','),
      self.chr('['),
      self.chr(']'),
      self.chr('{'),
      self.chr('}')
    )



  # [024]
  # b-line-feed ::=
  #   x:A

  # @::b_line_feed.num = 24
  def b_line_feed(self):
    debug_rule("b_line_feed")
    return self.chr('\x0A')



  # [025]
  # b-carriage-return ::=
  #   x:D

  # @::b_carriage_return.num = 25
  def b_carriage_return(self):
    debug_rule("b_carriage_return")
    return self.chr('\x0D')



  # [026]
  # b-char ::=
  #   b-line-feed | b-carriage-return

  # @::b_char.num = 26
  def b_char(self):
    debug_rule("b_char")
    return self.any(
      self.b_line_feed,
      self.b_carriage_return
    )



  # [027]
  # nb-char ::=
  #   c-printable - b-char - c-byte-order-mark

  # @::nb_char.num = 27
  def nb_char(self):
    debug_rule("nb_char")
    return self.but(
      self.c_printable,
      self.b_char,
      self.c_byte_order_mark
    )



  # [028]
  # b-break ::=
  #   ( b-carriage-return b-line-feed )
  #   | b-carriage-return
  #   | b-line-feed

  # @::b_break.num = 28
  def b_break(self):
    debug_rule("b_break")
    return self.any(
      self.all(
        self.b_carriage_return,
        self.b_line_feed
      ),
      self.b_carriage_return,
      self.b_line_feed
    )



  # [029]
  # b-as-line-feed ::=
  #   b-break

  # @::b_as_line_feed.num = 29
  def b_as_line_feed(self):
    debug_rule("b_as_line_feed")
    return self.b_break



  # [030]
  # b-non-content ::=
  #   b-break

  # @::b_non_content.num = 30
  def b_non_content(self):
    debug_rule("b_non_content")
    return self.b_break



  # [031]
  # s-space ::=
  #   x:20

  # @::s_space.num = 31
  def s_space(self):
    debug_rule("s_space")
    return self.chr('\x20')



  # [032]
  # s-tab ::=
  #   x:9

  # @::s_tab.num = 32
  def s_tab(self):
    debug_rule("s_tab")
    return self.chr('\x09')



  # [033]
  # s-white ::=
  #   s-space | s-tab

  # @::s_white.num = 33
  def s_white(self):
    debug_rule("s_white")
    return self.any(
      self.s_space,
      self.s_tab
    )



  # [034]
  # ns-char ::=
  #   nb-char - s-white

  # @::ns_char.num = 34
  def ns_char(self):
    debug_rule("ns_char")
    return self.but(
      self.nb_char,
      self.s_white
    )



  # [035]
  # ns-dec-digit ::=
  #   [x:30-x:39]

  # @::ns_dec_digit.num = 35
  def ns_dec_digit(self):
    debug_rule("ns_dec_digit")
    return self.rng('\x30', '\x39')



  # [036]
  # ns-hex-digit ::=
  #   ns-dec-digit
  #   | [x:41-x:46] | [x:61-x:66]

  # @::ns_hex_digit.num = 36
  def ns_hex_digit(self):
    debug_rule("ns_hex_digit")
    return self.any(
      self.ns_dec_digit,
      self.rng('\x41', '\x46'),
      self.rng('\x61', '\x66')
    )



  # [037]
  # ns-ascii-letter ::=
  #   [x:41-x:5A] | [x:61-x:7A]

  # @::ns_ascii_letter.num = 37
  def ns_ascii_letter(self):
    debug_rule("ns_ascii_letter")
    return self.any(
      self.rng('\x41', '\x5A'),
      self.rng('\x61', '\x7A')
    )



  # [038]
  # ns-word-char ::=
  #   ns-dec-digit | ns-ascii-letter | '-'

  # @::ns_word_char.num = 38
  def ns_word_char(self):
    debug_rule("ns_word_char")
    return self.any(
      self.ns_dec_digit,
      self.ns_ascii_letter,
      self.chr('-')
    )



  # [039]
  # ns-uri-char ::=
  #   '%' ns-hex-digit ns-hex-digit | ns-word-char | '#'
  #   | ';' | '/' | '?' | ':' | '@' | '&' | '=' | '+' | '$' | ','
  #   | '_' | '.' | '!' | '~' | '*' | ''' | '(' | ')' | '[' | ']'

  # @::ns_uri_char.num = 39
  def ns_uri_char(self):
    debug_rule("ns_uri_char")
    return self.any(
      self.all(
        self.chr('%'),
        self.ns_hex_digit,
        self.ns_hex_digit
      ),
      self.ns_word_char,
      self.chr('#'),
      self.chr(';'),
      self.chr('/'),
      self.chr('?'),
      self.chr(':'),
      self.chr('@'),
      self.chr('&'),
      self.chr('='),
      self.chr('+'),
      self.chr('$'),
      self.chr(','),
      self.chr('_'),
      self.chr('.'),
      self.chr('!'),
      self.chr('~'),
      self.chr('*'),
      self.chr("'"),
      self.chr('('),
      self.chr(')'),
      self.chr('['),
      self.chr(']')
    )



  # [040]
  # ns-tag-char ::=
  #   ns-uri-char - '!' - c-flow-indicator

  # @::ns_tag_char.num = 40
  def ns_tag_char(self):
    debug_rule("ns_tag_char")
    return self.but(
      self.ns_uri_char,
      self.chr('!'),
      self.c_flow_indicator
    )



  # [041]
  # c-escape ::=
  #   '\'

  # @::c_escape.num = 41
  def c_escape(self):
    debug_rule("c_escape")
    return self.chr("\\")



  # [042]
  # ns-esc-null ::=
  #   '0'

  # @::ns_esc_null.num = 42
  def ns_esc_null(self):
    debug_rule("ns_esc_null")
    return self.chr('0')



  # [043]
  # ns-esc-bell ::=
  #   'a'

  # @::ns_esc_bell.num = 43
  def ns_esc_bell(self):
    debug_rule("ns_esc_bell")
    return self.chr('a')



  # [044]
  # ns-esc-backspace ::=
  #   'b'

  # @::ns_esc_backspace.num = 44
  def ns_esc_backspace(self):
    debug_rule("ns_esc_backspace")
    return self.chr('b')



  # [045]
  # ns-esc-horizontal-tab ::=
  #   't' | x:9

  # @::ns_esc_horizontal_tab.num = 45
  def ns_esc_horizontal_tab(self):
    debug_rule("ns_esc_horizontal_tab")
    return self.any(
      self.chr('t'),
      self.chr('\x09')
    )



  # [046]
  # ns-esc-line-feed ::=
  #   'n'

  # @::ns_esc_line_feed.num = 46
  def ns_esc_line_feed(self):
    debug_rule("ns_esc_line_feed")
    return self.chr('n')



  # [047]
  # ns-esc-vertical-tab ::=
  #   'v'

  # @::ns_esc_vertical_tab.num = 47
  def ns_esc_vertical_tab(self):
    debug_rule("ns_esc_vertical_tab")
    return self.chr('v')



  # [048]
  # ns-esc-form-feed ::=
  #   'f'

  # @::ns_esc_form_feed.num = 48
  def ns_esc_form_feed(self):
    debug_rule("ns_esc_form_feed")
    return self.chr('f')



  # [049]
  # ns-esc-carriage-return ::=
  #   'r'

  # @::ns_esc_carriage_return.num = 49
  def ns_esc_carriage_return(self):
    debug_rule("ns_esc_carriage_return")
    return self.chr('r')



  # [050]
  # ns-esc-escape ::=
  #   'e'

  # @::ns_esc_escape.num = 50
  def ns_esc_escape(self):
    debug_rule("ns_esc_escape")
    return self.chr('e')



  # [051]
  # ns-esc-space ::=
  #   x:20

  # @::ns_esc_space.num = 51
  def ns_esc_space(self):
    debug_rule("ns_esc_space")
    return self.chr('\x20')



  # [052]
  # ns-esc-double-quote ::=
  #   '"'

  # @::ns_esc_double_quote.num = 52
  def ns_esc_double_quote(self):
    debug_rule("ns_esc_double_quote")
    return self.chr('"')



  # [053]
  # ns-esc-slash ::=
  #   '/'

  # @::ns_esc_slash.num = 53
  def ns_esc_slash(self):
    debug_rule("ns_esc_slash")
    return self.chr('/')



  # [054]
  # ns-esc-backslash ::=
  #   '\'

  # @::ns_esc_backslash.num = 54
  def ns_esc_backslash(self):
    debug_rule("ns_esc_backslash")
    return self.chr("\\")



  # [055]
  # ns-esc-next-line ::=
  #   'N'

  # @::ns_esc_next_line.num = 55
  def ns_esc_next_line(self):
    debug_rule("ns_esc_next_line")
    return self.chr('N')



  # [056]
  # ns-esc-non-breaking-space ::=
  #   '_'

  # @::ns_esc_non_breaking_space.num = 56
  def ns_esc_non_breaking_space(self):
    debug_rule("ns_esc_non_breaking_space")
    return self.chr('_')



  # [057]
  # ns-esc-line-separator ::=
  #   'L'

  # @::ns_esc_line_separator.num = 57
  def ns_esc_line_separator(self):
    debug_rule("ns_esc_line_separator")
    return self.chr('L')



  # [058]
  # ns-esc-paragraph-separator ::=
  #   'P'

  # @::ns_esc_paragraph_separator.num = 58
  def ns_esc_paragraph_separator(self):
    debug_rule("ns_esc_paragraph_separator")
    return self.chr('P')



  # [059]
  # ns-esc-8-bit ::=
  #   'x'
  #   ( ns-hex-digit{2} )

  # @::ns_esc_8_bit.num = 59
  def ns_esc_8_bit(self):
    debug_rule("ns_esc_8_bit")
    return self.all(
      self.chr('x'),
      self.rep(2, 2, self.ns_hex_digit)
    )



  # [060]
  # ns-esc-16-bit ::=
  #   'u'
  #   ( ns-hex-digit{4} )

  # @::ns_esc_16_bit.num = 60
  def ns_esc_16_bit(self):
    debug_rule("ns_esc_16_bit")
    return self.all(
      self.chr('u'),
      self.rep(4, 4, self.ns_hex_digit)
    )



  # [061]
  # ns-esc-32-bit ::=
  #   'U'
  #   ( ns-hex-digit{8} )

  # @::ns_esc_32_bit.num = 61
  def ns_esc_32_bit(self):
    debug_rule("ns_esc_32_bit")
    return self.all(
      self.chr('U'),
      self.rep(8, 8, self.ns_hex_digit)
    )



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

  # @::c_ns_esc_char.num = 62
  def c_ns_esc_char(self):
    debug_rule("c_ns_esc_char")
    return self.all(
      self.chr("\\"),
      self.any(
        self.ns_esc_null,
        self.ns_esc_bell,
        self.ns_esc_backspace,
        self.ns_esc_horizontal_tab,
        self.ns_esc_line_feed,
        self.ns_esc_vertical_tab,
        self.ns_esc_form_feed,
        self.ns_esc_carriage_return,
        self.ns_esc_escape,
        self.ns_esc_space,
        self.ns_esc_double_quote,
        self.ns_esc_slash,
        self.ns_esc_backslash,
        self.ns_esc_next_line,
        self.ns_esc_non_breaking_space,
        self.ns_esc_line_separator,
        self.ns_esc_paragraph_separator,
        self.ns_esc_8_bit,
        self.ns_esc_16_bit,
        self.ns_esc_32_bit
      )
    )



  # [063]
  # s-indent(n) ::=
  #   s-space{n}

  # @::s_indent.num = 63
  def s_indent(self, n):
    debug_rule("s_indent",n)
    return self.rep(n, n, self.s_space)



  # [064]
  # s-indent(<n) ::=
  #   s-space{m} <where_m_<_n>

  # @::s_indent_lt.num = 64
  def s_indent_lt(self, n):
    debug_rule("s_indent_lt",n)
    return self.may(
      self.all(
        self.rep(0, 0, self.s_space),
        self.lt(self.len(self.match), n)
      )
    )



  # [065]
  # s-indent(<=n) ::=
  #   s-space{m} <where_m_<=_n>

  # @::s_indent_le.num = 65
  def s_indent_le(self, n):
    debug_rule("s_indent_le",n)
    return self.may(
      self.all(
        self.rep(0, 0, self.s_space),
        self.le(self.len(self.match), n)
      )
    )



  # [066]
  # s-separate-in-line ::=
  #   s-white+ | <start_of_line>

  # @::s_separate_in_line.num = 66
  def s_separate_in_line(self):
    debug_rule("s_separate_in_line")
    return self.any(
      self.rep(1, 0, self.s_white),
      self.start_of_line
    )



  # [067]
  # s-line-prefix(n,c) ::=
  #   ( c = block-out => s-block-line-prefix(n) )
  #   ( c = block-in => s-block-line-prefix(n) )
  #   ( c = flow-out => s-flow-line-prefix(n) )
  #   ( c = flow-in => s-flow-line-prefix(n) )

  # @::s_line_prefix.num = 67
  def s_line_prefix(self, n, c):
    debug_rule("s_line_prefix",n,c)
    return self.case(
      c,
      {
        'block-in': [ self.s_block_line_prefix, n ],
        'block-out': [ self.s_block_line_prefix, n ],
        'flow-in': [ self.s_flow_line_prefix, n ],
        'flow-out': [ self.s_flow_line_prefix, n ],
      }
    )



  # [068]
  # s-block-line-prefix(n) ::=
  #   s-indent(n)

  # @::s_block_line_prefix.num = 68
  def s_block_line_prefix(self, n):
    debug_rule("s_block_line_prefix",n)
    return [ self.s_indent, n ]



  # [069]
  # s-flow-line-prefix(n) ::=
  #   s-indent(n)
  #   s-separate-in-line?

  # @::s_flow_line_prefix.num = 69
  def s_flow_line_prefix(self, n):
    debug_rule("s_flow_line_prefix",n)
    return self.all(
      [ self.s_indent, n ],
      self.rep(0, 1, self.s_separate_in_line)
    )



  # [070]
  # l-empty(n,c) ::=
  #   ( s-line-prefix(n,c) | s-indent(<n) )
  #   b-as-line-feed

  # @::l_empty.num = 70
  def l_empty(self, n, c):
    debug_rule("l_empty",n,c)
    return self.all(
      self.any(
        [ self.s_line_prefix, n, c ],
        [ self.s_indent_lt, n ]
      ),
      self.b_as_line_feed
    )



  # [071]
  # b-l-trimmed(n,c) ::=
  #   b-non-content l-empty(n,c)+

  # @::b_l_trimmed.num = 71
  def b_l_trimmed(self, n, c):
    debug_rule("b_l_trimmed",n,c)
    return self.all(
      self.b_non_content,
      self.rep(1, 0, [ self.l_empty, n, c ])
    )



  # [072]
  # b-as-space ::=
  #   b-break

  # @::b_as_space.num = 72
  def b_as_space(self):
    debug_rule("b_as_space")
    return self.b_break



  # [073]
  # b-l-folded(n,c) ::=
  #   b-l-trimmed(n,c) | b-as-space

  # @::b_l_folded.num = 73
  def b_l_folded(self, n, c):
    debug_rule("b_l_folded",n,c)
    return self.any(
      [ self.b_l_trimmed, n, c ],
      self.b_as_space
    )



  # [074]
  # s-flow-folded(n) ::=
  #   s-separate-in-line?
  #   b-l-folded(n,flow-in)
  #   s-flow-line-prefix(n)

  # @::s_flow_folded.num = 74
  def s_flow_folded(self, n):
    debug_rule("s_flow_folded",n)
    return self.all(
      self.rep(0, 1, self.s_separate_in_line),
      [ self.b_l_folded, n, "flow-in" ],
      [ self.s_flow_line_prefix, n ]
    )



  # [075]
  # c-nb-comment-text ::=
  #   '#' nb-char*

  # @::c_nb_comment_text.num = 75
  def c_nb_comment_text(self):
    debug_rule("c_nb_comment_text")
    return self.all(
      self.chr('#'),
      self.rep(0, 0, self.nb_char)
    )



  # [076]
  # b-comment ::=
  #   b-non-content | <end_of_file>

  # @::b_comment.num = 76
  def b_comment(self):
    debug_rule("b_comment")
    return self.any(
      self.b_non_content,
      self.end_of_stream
    )



  # [077]
  # s-b-comment ::=
  #   ( s-separate-in-line
  #   c-nb-comment-text? )?
  #   b-comment

  # @::s_b_comment.num = 77
  def s_b_comment(self):
    debug_rule("s_b_comment")
    return self.all(
      self.rep(0, 1,
        self.all(
          self.s_separate_in_line,
          self.rep(0, 1, self.c_nb_comment_text)
        )),
      self.b_comment
    )



  # [078]
  # l-comment ::=
  #   s-separate-in-line c-nb-comment-text?
  #   b-comment

  # @::l_comment.num = 78
  def l_comment(self):
    debug_rule("l_comment")
    return self.all(
      self.s_separate_in_line,
      self.rep(0, 1, self.c_nb_comment_text),
      self.b_comment
    )



  # [079]
  # s-l-comments ::=
  #   ( s-b-comment | <start_of_line> )
  #   l-comment*

  # @::s_l_comments.num = 79
  def s_l_comments(self):
    debug_rule("s_l_comments")
    return self.all(
      self.any(
        self.s_b_comment,
        self.start_of_line
      ),
      self.rep(0, 0, self.l_comment)
    )



  # [080]
  # s-separate(n,c) ::=
  #   ( c = block-out => s-separate-lines(n) )
  #   ( c = block-in => s-separate-lines(n) )
  #   ( c = flow-out => s-separate-lines(n) )
  #   ( c = flow-in => s-separate-lines(n) )
  #   ( c = block-key => s-separate-in-line )
  #   ( c = flow-key => s-separate-in-line )

  # @::s_separate.num = 80
  def s_separate(self, n, c):
    debug_rule("s_separate",n,c)
    return self.case(
      c,
      {
        'block-in': [ self.s_separate_lines, n ],
        'block-key': self.s_separate_in_line,
        'block-out': [ self.s_separate_lines, n ],
        'flow-in': [ self.s_separate_lines, n ],
        'flow-key': self.s_separate_in_line,
        'flow-out': [ self.s_separate_lines, n ],
      }
    )



  # [081]
  # s-separate-lines(n) ::=
  #   ( s-l-comments
  #   s-flow-line-prefix(n) )
  #   | s-separate-in-line

  # @::s_separate_lines.num = 81
  def s_separate_lines(self, n):
    debug_rule("s_separate_lines",n)
    return self.any(
      self.all(
        self.s_l_comments,
        [ self.s_flow_line_prefix, n ]
      ),
      self.s_separate_in_line
    )



  # [082]
  # l-directive ::=
  #   '%'
  #   ( ns-yaml-directive
  #   | ns-tag-directive
  #   | ns-reserved-directive )
  #   s-l-comments

  # @::l_directive.num = 82
  def l_directive(self):
    debug_rule("l_directive")
    return self.all(
      self.chr('%'),
      self.any(
        self.ns_yaml_directive,
        self.ns_tag_directive,
        self.ns_reserved_directive
      ),
      self.s_l_comments
    )



  # [083]
  # ns-reserved-directive ::=
  #   ns-directive-name
  #   ( s-separate-in-line ns-directive-parameter )*

  # @::ns_reserved_directive.num = 83
  def ns_reserved_directive(self):
    debug_rule("ns_reserved_directive")
    return self.all(
      self.ns_directive_name,
      self.rep(0, 0,
        self.all(
          self.s_separate_in_line,
          self.ns_directive_parameter
        ))
    )



  # [084]
  # ns-directive-name ::=
  #   ns-char+

  # @::ns_directive_name.num = 84
  def ns_directive_name(self):
    debug_rule("ns_directive_name")
    return self.rep(1, 0, self.ns_char)



  # [085]
  # ns-directive-parameter ::=
  #   ns-char+

  # @::ns_directive_parameter.num = 85
  def ns_directive_parameter(self):
    debug_rule("ns_directive_parameter")
    return self.rep(1, 0, self.ns_char)



  # [086]
  # ns-yaml-directive ::=
  #   'Y' 'A' 'M' 'L'
  #   s-separate-in-line ns-yaml-version

  # @::ns_yaml_directive.num = 86
  def ns_yaml_directive(self):
    debug_rule("ns_yaml_directive")
    return self.all(
      self.chr('Y'),
      self.chr('A'),
      self.chr('M'),
      self.chr('L'),
      self.s_separate_in_line,
      self.ns_yaml_version
    )



  # [087]
  # ns-yaml-version ::=
  #   ns-dec-digit+ '.' ns-dec-digit+

  # @::ns_yaml_version.num = 87
  def ns_yaml_version(self):
    debug_rule("ns_yaml_version")
    return self.all(
      self.rep(1, 0, self.ns_dec_digit),
      self.chr('.'),
      self.rep(1, 0, self.ns_dec_digit)
    )



  # [088]
  # ns-tag-directive ::=
  #   'T' 'A' 'G'
  #   s-separate-in-line c-tag-handle
  #   s-separate-in-line ns-tag-prefix

  # @::ns_tag_directive.num = 88
  def ns_tag_directive(self):
    debug_rule("ns_tag_directive")
    return self.all(
      self.chr('T'),
      self.chr('A'),
      self.chr('G'),
      self.s_separate_in_line,
      self.c_tag_handle,
      self.s_separate_in_line,
      self.ns_tag_prefix
    )



  # [089]
  # c-tag-handle ::=
  #   c-named-tag-handle
  #   | c-secondary-tag-handle
  #   | c-primary-tag-handle

  # @::c_tag_handle.num = 89
  def c_tag_handle(self):
    debug_rule("c_tag_handle")
    return self.any(
      self.c_named_tag_handle,
      self.c_secondary_tag_handle,
      self.c_primary_tag_handle
    )



  # [090]
  # c-primary-tag-handle ::=
  #   '!'

  # @::c_primary_tag_handle.num = 90
  def c_primary_tag_handle(self):
    debug_rule("c_primary_tag_handle")
    return self.chr('!')



  # [091]
  # c-secondary-tag-handle ::=
  #   '!' '!'

  # @::c_secondary_tag_handle.num = 91
  def c_secondary_tag_handle(self):
    debug_rule("c_secondary_tag_handle")
    return self.all(
      self.chr('!'),
      self.chr('!')
    )



  # [092]
  # c-named-tag-handle ::=
  #   '!' ns-word-char+ '!'

  # @::c_named_tag_handle.num = 92
  def c_named_tag_handle(self):
    debug_rule("c_named_tag_handle")
    return self.all(
      self.chr('!'),
      self.rep(1, 0, self.ns_word_char),
      self.chr('!')
    )



  # [093]
  # ns-tag-prefix ::=
  #   c-ns-local-tag-prefix | ns-global-tag-prefix

  # @::ns_tag_prefix.num = 93
  def ns_tag_prefix(self):
    debug_rule("ns_tag_prefix")
    return self.any(
      self.c_ns_local_tag_prefix,
      self.ns_global_tag_prefix
    )



  # [094]
  # c-ns-local-tag-prefix ::=
  #   '!' ns-uri-char*

  # @::c_ns_local_tag_prefix.num = 94
  def c_ns_local_tag_prefix(self):
    debug_rule("c_ns_local_tag_prefix")
    return self.all(
      self.chr('!'),
      self.rep(0, 0, self.ns_uri_char)
    )



  # [095]
  # ns-global-tag-prefix ::=
  #   ns-tag-char ns-uri-char*

  # @::ns_global_tag_prefix.num = 95
  def ns_global_tag_prefix(self):
    debug_rule("ns_global_tag_prefix")
    return self.all(
      self.ns_tag_char,
      self.rep(0, 0, self.ns_uri_char)
    )



  # [096]
  # c-ns-properties(n,c) ::=
  #   ( c-ns-tag-property
  #   ( s-separate(n,c) c-ns-anchor-property )? )
  #   | ( c-ns-anchor-property
  #   ( s-separate(n,c) c-ns-tag-property )? )

  # @::c_ns_properties.num = 96
  def c_ns_properties(self, n, c):
    debug_rule("c_ns_properties",n,c)
    return self.any(
      self.all(
        self.c_ns_tag_property,
        self.rep(0, 1,
          self.all(
            [ self.s_separate, n, c ],
            self.c_ns_anchor_property
          ))
      ),
      self.all(
        self.c_ns_anchor_property,
        self.rep(0, 1,
          self.all(
            [ self.s_separate, n, c ],
            self.c_ns_tag_property
          ))
      )
    )



  # [097]
  # c-ns-tag-property ::=
  #   c-verbatim-tag
  #   | c-ns-shorthand-tag
  #   | c-non-specific-tag

  # @::c_ns_tag_property.num = 97
  def c_ns_tag_property(self):
    debug_rule("c_ns_tag_property")
    return self.any(
      self.c_verbatim_tag,
      self.c_ns_shorthand_tag,
      self.c_non_specific_tag
    )



  # [098]
  # c-verbatim-tag ::=
  #   '!' '<' ns-uri-char+ '>'

  # @::c_verbatim_tag.num = 98
  def c_verbatim_tag(self):
    debug_rule("c_verbatim_tag")
    return self.all(
      self.chr('!'),
      self.chr('<'),
      self.rep(1, 0, self.ns_uri_char),
      self.chr('>')
    )



  # [099]
  # c-ns-shorthand-tag ::=
  #   c-tag-handle ns-tag-char+

  # @::c_ns_shorthand_tag.num = 99
  def c_ns_shorthand_tag(self):
    debug_rule("c_ns_shorthand_tag")
    return self.all(
      self.c_tag_handle,
      self.rep(1, 0, self.ns_tag_char)
    )



  # [100]
  # c-non-specific-tag ::=
  #   '!'

  # @::c_non_specific_tag.num = 100
  def c_non_specific_tag(self):
    debug_rule("c_non_specific_tag")
    return self.chr('!')



  # [101]
  # c-ns-anchor-property ::=
  #   '&' ns-anchor-name

  # @::c_ns_anchor_property.num = 101
  def c_ns_anchor_property(self):
    debug_rule("c_ns_anchor_property")
    return self.all(
      self.chr('&'),
      self.ns_anchor_name
    )



  # [102]
  # ns-anchor-char ::=
  #   ns-char - c-flow-indicator

  # @::ns_anchor_char.num = 102
  def ns_anchor_char(self):
    debug_rule("ns_anchor_char")
    return self.but(
      self.ns_char,
      self.c_flow_indicator
    )



  # [103]
  # ns-anchor-name ::=
  #   ns-anchor-char+

  # @::ns_anchor_name.num = 103
  def ns_anchor_name(self):
    debug_rule("ns_anchor_name")
    return self.rep(1, 0, self.ns_anchor_char)



  # [104]
  # c-ns-alias-node ::=
  #   '*' ns-anchor-name

  # @::c_ns_alias_node.num = 104
  def c_ns_alias_node(self):
    debug_rule("c_ns_alias_node")
    return self.all(
      self.chr('*'),
      self.ns_anchor_name
    )



  # [105]
  # e-scalar ::=
  #   <empty>

  # @::e_scalar.num = 105
  def e_scalar(self):
    debug_rule("e_scalar")
    return self.empty



  # [106]
  # e-node ::=
  #   e-scalar

  # @::e_node.num = 106
  def e_node(self):
    debug_rule("e_node")
    return self.e_scalar



  # [107]
  # nb-double-char ::=
  #   c-ns-esc-char | ( nb-json - '\' - '"' )

  # @::nb_double_char.num = 107
  def nb_double_char(self):
    debug_rule("nb_double_char")
    return self.any(
      self.c_ns_esc_char,
      self.but(
        self.nb_json,
        self.chr("\\"),
        self.chr('"')
      )
    )



  # [108]
  # ns-double-char ::=
  #   nb-double-char - s-white

  # @::ns_double_char.num = 108
  def ns_double_char(self):
    debug_rule("ns_double_char")
    return self.but(
      self.nb_double_char,
      self.s_white
    )



  # [109]
  # c-double-quoted(n,c) ::=
  #   '"' nb-double-text(n,c)
  #   '"'

  # @::c_double_quoted.num = 109
  def c_double_quoted(self, n, c):
    debug_rule("c_double_quoted",n,c)
    return self.all(
      self.chr('"'),
      [ self.nb_double_text, n, c ],
      self.chr('"')
    )



  # [110]
  # nb-double-text(n,c) ::=
  #   ( c = flow-out => nb-double-multi-line(n) )
  #   ( c = flow-in => nb-double-multi-line(n) )
  #   ( c = block-key => nb-double-one-line )
  #   ( c = flow-key => nb-double-one-line )

  # @::nb_double_text.num = 110
  def nb_double_text(self, n, c):
    debug_rule("nb_double_text",n,c)
    return self.case(
      c,
      {
        'block-key': self.nb_double_one_line,
        'flow-in': [ self.nb_double_multi_line, n ],
        'flow-key': self.nb_double_one_line,
        'flow-out': [ self.nb_double_multi_line, n ],
      }
    )



  # [111]
  # nb-double-one-line ::=
  #   nb-double-char*

  # @::nb_double_one_line.num = 111
  def nb_double_one_line(self):
    debug_rule("nb_double_one_line")
    return self.rep(0, 0, self.nb_double_char)



  # [112]
  # s-double-escaped(n) ::=
  #   s-white* '\'
  #   b-non-content
  #   l-empty(n,flow-in)* s-flow-line-prefix(n)

  # @::s_double_escaped.num = 112
  def s_double_escaped(self, n):
    debug_rule("s_double_escaped",n)
    return self.all(
      self.rep(0, 0, self.s_white),
      self.chr("\\"),
      self.b_non_content,
      self.rep(0, 0, [ self.l_empty, n, "flow-in" ]),
      [ self.s_flow_line_prefix, n ]
    )



  # [113]
  # s-double-break(n) ::=
  #   s-double-escaped(n) | s-flow-folded(n)

  # @::s_double_break.num = 113
  def s_double_break(self, n):
    debug_rule("s_double_break",n)
    return self.any(
      [ self.s_double_escaped, n ],
      [ self.s_flow_folded, n ]
    )



  # [114]
  # nb-ns-double-in-line ::=
  #   ( s-white* ns-double-char )*

  # @::nb_ns_double_in_line.num = 114
  def nb_ns_double_in_line(self):
    debug_rule("nb_ns_double_in_line")
    return self.rep(0, 0,
      self.all(
        self.rep(0, 0, self.s_white),
        self.ns_double_char
      ))



  # [115]
  # s-double-next-line(n) ::=
  #   s-double-break(n)
  #   ( ns-double-char nb-ns-double-in-line
  #   ( s-double-next-line(n) | s-white* ) )?

  # @::s_double_next_line.num = 115
  def s_double_next_line(self, n):
    debug_rule("s_double_next_line",n)
    return self.all(
      [ self.s_double_break, n ],
      self.rep(0, 1,
        self.all(
          self.ns_double_char,
          self.nb_ns_double_in_line,
          self.any(
            [ self.s_double_next_line, n ],
            self.rep(0, 0, self.s_white)
          )
        ))
    )



  # [116]
  # nb-double-multi-line(n) ::=
  #   nb-ns-double-in-line
  #   ( s-double-next-line(n) | s-white* )

  # @::nb_double_multi_line.num = 116
  def nb_double_multi_line(self, n):
    debug_rule("nb_double_multi_line",n)
    return self.all(
      self.nb_ns_double_in_line,
      self.any(
        [ self.s_double_next_line, n ],
        self.rep(0, 0, self.s_white)
      )
    )



  # [117]
  # c-quoted-quote ::=
  #   ''' '''

  # @::c_quoted_quote.num = 117
  def c_quoted_quote(self):
    debug_rule("c_quoted_quote")
    return self.all(
      self.chr("'"),
      self.chr("'")
    )



  # [118]
  # nb-single-char ::=
  #   c-quoted-quote | ( nb-json - ''' )

  # @::nb_single_char.num = 118
  def nb_single_char(self):
    debug_rule("nb_single_char")
    return self.any(
      self.c_quoted_quote,
      self.but(
        self.nb_json,
        self.chr("'")
      )
    )



  # [119]
  # ns-single-char ::=
  #   nb-single-char - s-white

  # @::ns_single_char.num = 119
  def ns_single_char(self):
    debug_rule("ns_single_char")
    return self.but(
      self.nb_single_char,
      self.s_white
    )



  # [120]
  # c-single-quoted(n,c) ::=
  #   ''' nb-single-text(n,c)
  #   '''

  # @::c_single_quoted.num = 120
  def c_single_quoted(self, n, c):
    debug_rule("c_single_quoted",n,c)
    return self.all(
      self.chr("'"),
      [ self.nb_single_text, n, c ],
      self.chr("'")
    )



  # [121]
  # nb-single-text(n,c) ::=
  #   ( c = flow-out => nb-single-multi-line(n) )
  #   ( c = flow-in => nb-single-multi-line(n) )
  #   ( c = block-key => nb-single-one-line )
  #   ( c = flow-key => nb-single-one-line )

  # @::nb_single_text.num = 121
  def nb_single_text(self, n, c):
    debug_rule("nb_single_text",n,c)
    return self.case(
      c,
      {
        'block-key': self.nb_single_one_line,
        'flow-in': [ self.nb_single_multi_line, n ],
        'flow-key': self.nb_single_one_line,
        'flow-out': [ self.nb_single_multi_line, n ],
      }
    )



  # [122]
  # nb-single-one-line ::=
  #   nb-single-char*

  # @::nb_single_one_line.num = 122
  def nb_single_one_line(self):
    debug_rule("nb_single_one_line")
    return self.rep(0, 0, self.nb_single_char)



  # [123]
  # nb-ns-single-in-line ::=
  #   ( s-white* ns-single-char )*

  # @::nb_ns_single_in_line.num = 123
  def nb_ns_single_in_line(self):
    debug_rule("nb_ns_single_in_line")
    return self.rep(0, 0,
      self.all(
        self.rep(0, 0, self.s_white),
        self.ns_single_char
      ))



  # [124]
  # s-single-next-line(n) ::=
  #   s-flow-folded(n)
  #   ( ns-single-char nb-ns-single-in-line
  #   ( s-single-next-line(n) | s-white* ) )?

  # @::s_single_next_line.num = 124
  def s_single_next_line(self, n):
    debug_rule("s_single_next_line",n)
    return self.all(
      [ self.s_flow_folded, n ],
      self.rep(0, 1,
        self.all(
          self.ns_single_char,
          self.nb_ns_single_in_line,
          self.any(
            [ self.s_single_next_line, n ],
            self.rep(0, 0, self.s_white)
          )
        ))
    )



  # [125]
  # nb-single-multi-line(n) ::=
  #   nb-ns-single-in-line
  #   ( s-single-next-line(n) | s-white* )

  # @::nb_single_multi_line.num = 125
  def nb_single_multi_line(self, n):
    debug_rule("nb_single_multi_line",n)
    return self.all(
      self.nb_ns_single_in_line,
      self.any(
        [ self.s_single_next_line, n ],
        self.rep(0, 0, self.s_white)
      )
    )



  # [126]
  # ns-plain-first(c) ::=
  #   ( ns-char - c-indicator )
  #   | ( ( '?' | ':' | '-' )
  #   <followed_by_an_ns-plain-safe(c)> )

  # @::ns_plain_first.num = 126
  def ns_plain_first(self, c):
    debug_rule("ns_plain_first",c)
    return self.any(
      self.but(
        self.ns_char,
        self.c_indicator
      ),
      self.all(
        self.any(
          self.chr('?'),
          self.chr(':'),
          self.chr('-')
        ),
        self.chk('=', [ self.ns_plain_safe, c ])
      )
    )



  # [127]
  # ns-plain-safe(c) ::=
  #   ( c = flow-out => ns-plain-safe-out )
  #   ( c = flow-in => ns-plain-safe-in )
  #   ( c = block-key => ns-plain-safe-out )
  #   ( c = flow-key => ns-plain-safe-in )

  # @::ns_plain_safe.num = 127
  def ns_plain_safe(self, c):
    debug_rule("ns_plain_safe",c)
    return self.case(
      c,
      {
        'block-key': self.ns_plain_safe_out,
        'flow-in': self.ns_plain_safe_in,
        'flow-key': self.ns_plain_safe_in,
        'flow-out': self.ns_plain_safe_out,
      }
    )



  # [128]
  # ns-plain-safe-out ::=
  #   ns-char

  # @::ns_plain_safe_out.num = 128
  def ns_plain_safe_out(self):
    debug_rule("ns_plain_safe_out")
    return self.ns_char



  # [129]
  # ns-plain-safe-in ::=
  #   ns-char - c-flow-indicator

  # @::ns_plain_safe_in.num = 129
  def ns_plain_safe_in(self):
    debug_rule("ns_plain_safe_in")
    return self.but(
      self.ns_char,
      self.c_flow_indicator
    )



  # [130]
  # ns-plain-char(c) ::=
  #   ( ns-plain-safe(c) - ':' - '#' )
  #   | ( <an_ns-char_preceding> '#' )
  #   | ( ':' <followed_by_an_ns-plain-safe(c)> )

  # @::ns_plain_char.num = 130
  def ns_plain_char(self, c):
    debug_rule("ns_plain_char",c)
    return self.any(
      self.but(
        [ self.ns_plain_safe, c ],
        self.chr(':'),
        self.chr('#')
      ),
      self.all(
        self.chk('<=', self.ns_char),
        self.chr('#')
      ),
      self.all(
        self.chr(':'),
        self.chk('=', [ self.ns_plain_safe, c ])
      )
    )



  # [131]
  # ns-plain(n,c) ::=
  #   ( c = flow-out => ns-plain-multi-line(n,c) )
  #   ( c = flow-in => ns-plain-multi-line(n,c) )
  #   ( c = block-key => ns-plain-one-line(c) )
  #   ( c = flow-key => ns-plain-one-line(c) )

  # @::ns_plain.num = 131
  def ns_plain(self, n, c):
    debug_rule("ns_plain",n,c)
    return self.case(
      c,
      {
        'block-key': [ self.ns_plain_one_line, c ],
        'flow-in': [ self.ns_plain_multi_line, n, c ],
        'flow-key': [ self.ns_plain_one_line, c ],
        'flow-out': [ self.ns_plain_multi_line, n, c ],
      }
    )



  # [132]
  # nb-ns-plain-in-line(c) ::=
  #   ( s-white*
  #   ns-plain-char(c) )*

  # @::nb_ns_plain_in_line.num = 132
  def nb_ns_plain_in_line(self, c):
    debug_rule("nb_ns_plain_in_line",c)
    return self.rep(0, 0,
      self.all(
        self.rep(0, 0, self.s_white),
        [ self.ns_plain_char, c ]
      ))



  # [133]
  # ns-plain-one-line(c) ::=
  #   ns-plain-first(c)
  #   nb-ns-plain-in-line(c)

  # @::ns_plain_one_line.num = 133
  def ns_plain_one_line(self, c):
    debug_rule("ns_plain_one_line",c)
    return self.all(
      [ self.ns_plain_first, c ],
      [ self.nb_ns_plain_in_line, c ]
    )



  # [134]
  # s-ns-plain-next-line(n,c) ::=
  #   s-flow-folded(n)
  #   ns-plain-char(c) nb-ns-plain-in-line(c)

  # @::s_ns_plain_next_line.num = 134
  def s_ns_plain_next_line(self, n, c):
    debug_rule("s_ns_plain_next_line",n,c)
    return self.all(
      [ self.s_flow_folded, n ],
      [ self.ns_plain_char, c ],
      [ self.nb_ns_plain_in_line, c ]
    )



  # [135]
  # ns-plain-multi-line(n,c) ::=
  #   ns-plain-one-line(c)
  #   s-ns-plain-next-line(n,c)*

  # @::ns_plain_multi_line.num = 135
  def ns_plain_multi_line(self, n, c):
    debug_rule("ns_plain_multi_line",n,c)
    return self.all(
      [ self.ns_plain_one_line, c ],
      self.rep(0, 0, [ self.s_ns_plain_next_line, n, c ])
    )



  # [136]
  # in-flow(c) ::=
  #   ( c = flow-out => flow-in )
  #   ( c = flow-in => flow-in )
  #   ( c = block-key => flow-key )
  #   ( c = flow-key => flow-key )

  # @::in_flow.num = 136
  def in_flow(self, c):
    debug_rule("in_flow",c)
    return self.flip(
      c,
      {
        'block-key': "flow-key",
        'flow-in': "flow-in",
        'flow-key': "flow-key",
        'flow-out': "flow-in",
      }
    )



  # [137]
  # c-flow-sequence(n,c) ::=
  #   '[' s-separate(n,c)?
  #   ns-s-flow-seq-entries(n,in-flow(c))? ']'

  # @::c_flow_sequence.num = 137
  def c_flow_sequence(self, n, c):
    debug_rule("c_flow_sequence",n,c)
    return self.all(
      self.chr('['),
      self.rep(0, 1, [ self.s_separate, n, c ]),
      self.rep(0, 1, [ self.ns_s_flow_seq_entries, n, [ self.in_flow, c ] ]),
      self.chr(']')
    )



  # [138]
  # ns-s-flow-seq-entries(n,c) ::=
  #   ns-flow-seq-entry(n,c)
  #   s-separate(n,c)?
  #   ( ',' s-separate(n,c)?
  #   ns-s-flow-seq-entries(n,c)? )?

  # @::ns_s_flow_seq_entries.num = 138
  def ns_s_flow_seq_entries(self, n, c):
    debug_rule("ns_s_flow_seq_entries",n,c)
    return self.all(
      [ self.ns_flow_seq_entry, n, c ],
      self.rep(0, 1, [ self.s_separate, n, c ]),
      self.rep(0, 1,
        self.all(
          self.chr(','),
          self.rep(0, 1, [ self.s_separate, n, c ]),
          self.rep(0, 1, [ self.ns_s_flow_seq_entries, n, c ])
        ))
    )



  # [139]
  # ns-flow-seq-entry(n,c) ::=
  #   ns-flow-pair(n,c) | ns-flow-node(n,c)

  # @::ns_flow_seq_entry.num = 139
  def ns_flow_seq_entry(self, n, c):
    debug_rule("ns_flow_seq_entry",n,c)
    return self.any(
      [ self.ns_flow_pair, n, c ],
      [ self.ns_flow_node, n, c ]
    )



  # [140]
  # c-flow-mapping(n,c) ::=
  #   '{' s-separate(n,c)?
  #   ns-s-flow-map-entries(n,in-flow(c))? '}'

  # @::c_flow_mapping.num = 140
  def c_flow_mapping(self, n, c):
    debug_rule("c_flow_mapping",n,c)
    return self.all(
      self.chr('{'),
      self.rep(0, 1, [ self.s_separate, n, c ]),
      self.rep(0, 1, [ self.ns_s_flow_map_entries, n, [ self.in_flow, c ] ]),
      self.chr('}')
    )



  # [141]
  # ns-s-flow-map-entries(n,c) ::=
  #   ns-flow-map-entry(n,c)
  #   s-separate(n,c)?
  #   ( ',' s-separate(n,c)?
  #   ns-s-flow-map-entries(n,c)? )?

  # @::ns_s_flow_map_entries.num = 141
  def ns_s_flow_map_entries(self, n, c):
    debug_rule("ns_s_flow_map_entries",n,c)
    return self.all(
      [ self.ns_flow_map_entry, n, c ],
      self.rep(0, 1, [ self.s_separate, n, c ]),
      self.rep(0, 1,
        self.all(
          self.chr(','),
          self.rep(0, 1, [ self.s_separate, n, c ]),
          self.rep(0, 1, [ self.ns_s_flow_map_entries, n, c ])
        ))
    )



  # [142]
  # ns-flow-map-entry(n,c) ::=
  #   ( '?' s-separate(n,c)
  #   ns-flow-map-explicit-entry(n,c) )
  #   | ns-flow-map-implicit-entry(n,c)

  # @::ns_flow_map_entry.num = 142
  def ns_flow_map_entry(self, n, c):
    debug_rule("ns_flow_map_entry",n,c)
    return self.any(
      self.all(
        self.chr('?'),
        [ self.s_separate, n, c ],
        [ self.ns_flow_map_explicit_entry, n, c ]
      ),
      [ self.ns_flow_map_implicit_entry, n, c ]
    )



  # [143]
  # ns-flow-map-explicit-entry(n,c) ::=
  #   ns-flow-map-implicit-entry(n,c)
  #   | ( e-node
  #   e-node )

  # @::ns_flow_map_explicit_entry.num = 143
  def ns_flow_map_explicit_entry(self, n, c):
    debug_rule("ns_flow_map_explicit_entry",n,c)
    return self.any(
      [ self.ns_flow_map_implicit_entry, n, c ],
      self.all(
        self.e_node,
        self.e_node
      )
    )



  # [144]
  # ns-flow-map-implicit-entry(n,c) ::=
  #   ns-flow-map-yaml-key-entry(n,c)
  #   | c-ns-flow-map-empty-key-entry(n,c)
  #   | c-ns-flow-map-json-key-entry(n,c)

  # @::ns_flow_map_implicit_entry.num = 144
  def ns_flow_map_implicit_entry(self, n, c):
    debug_rule("ns_flow_map_implicit_entry",n,c)
    return self.any(
      [ self.ns_flow_map_yaml_key_entry, n, c ],
      [ self.c_ns_flow_map_empty_key_entry, n, c ],
      [ self.c_ns_flow_map_json_key_entry, n, c ]
    )



  # [145]
  # ns-flow-map-yaml-key-entry(n,c) ::=
  #   ns-flow-yaml-node(n,c)
  #   ( ( s-separate(n,c)?
  #   c-ns-flow-map-separate-value(n,c) )
  #   | e-node )

  # @::ns_flow_map_yaml_key_entry.num = 145
  def ns_flow_map_yaml_key_entry(self, n, c):
    debug_rule("ns_flow_map_yaml_key_entry",n,c)
    return self.all(
      [ self.ns_flow_yaml_node, n, c ],
      self.any(
        self.all(
          self.rep(0, 1, [ self.s_separate, n, c ]),
          [ self.c_ns_flow_map_separate_value, n, c ]
        ),
        self.e_node
      )
    )



  # [146]
  # c-ns-flow-map-empty-key-entry(n,c) ::=
  #   e-node
  #   c-ns-flow-map-separate-value(n,c)

  # @::c_ns_flow_map_empty_key_entry.num = 146
  def c_ns_flow_map_empty_key_entry(self, n, c):
    debug_rule("c_ns_flow_map_empty_key_entry",n,c)
    return self.all(
      self.e_node,
      [ self.c_ns_flow_map_separate_value, n, c ]
    )



  # [147]
  # c-ns-flow-map-separate-value(n,c) ::=
  #   ':' <not_followed_by_an_ns-plain-safe(c)>
  #   ( ( s-separate(n,c) ns-flow-node(n,c) )
  #   | e-node )

  # @::c_ns_flow_map_separate_value.num = 147
  def c_ns_flow_map_separate_value(self, n, c):
    debug_rule("c_ns_flow_map_separate_value",n,c)
    return self.all(
      self.chr(':'),
      self.chk('!', [ self.ns_plain_safe, c ]),
      self.any(
        self.all(
          [ self.s_separate, n, c ],
          [ self.ns_flow_node, n, c ]
        ),
        self.e_node
      )
    )



  # [148]
  # c-ns-flow-map-json-key-entry(n,c) ::=
  #   c-flow-json-node(n,c)
  #   ( ( s-separate(n,c)?
  #   c-ns-flow-map-adjacent-value(n,c) )
  #   | e-node )

  # @::c_ns_flow_map_json_key_entry.num = 148
  def c_ns_flow_map_json_key_entry(self, n, c):
    debug_rule("c_ns_flow_map_json_key_entry",n,c)
    return self.all(
      [ self.c_flow_json_node, n, c ],
      self.any(
        self.all(
          self.rep(0, 1, [ self.s_separate, n, c ]),
          [ self.c_ns_flow_map_adjacent_value, n, c ]
        ),
        self.e_node
      )
    )



  # [149]
  # c-ns-flow-map-adjacent-value(n,c) ::=
  #   ':' ( (
  #   s-separate(n,c)?
  #   ns-flow-node(n,c) )
  #   | e-node )

  # @::c_ns_flow_map_adjacent_value.num = 149
  def c_ns_flow_map_adjacent_value(self, n, c):
    debug_rule("c_ns_flow_map_adjacent_value",n,c)
    return self.all(
      self.chr(':'),
      self.any(
        self.all(
          self.rep(0, 1, [ self.s_separate, n, c ]),
          [ self.ns_flow_node, n, c ]
        ),
        self.e_node
      )
    )



  # [150]
  # ns-flow-pair(n,c) ::=
  #   ( '?' s-separate(n,c)
  #   ns-flow-map-explicit-entry(n,c) )
  #   | ns-flow-pair-entry(n,c)

  # @::ns_flow_pair.num = 150
  def ns_flow_pair(self, n, c):
    debug_rule("ns_flow_pair",n,c)
    return self.any(
      self.all(
        self.chr('?'),
        [ self.s_separate, n, c ],
        [ self.ns_flow_map_explicit_entry, n, c ]
      ),
      [ self.ns_flow_pair_entry, n, c ]
    )



  # [151]
  # ns-flow-pair-entry(n,c) ::=
  #   ns-flow-pair-yaml-key-entry(n,c)
  #   | c-ns-flow-map-empty-key-entry(n,c)
  #   | c-ns-flow-pair-json-key-entry(n,c)

  # @::ns_flow_pair_entry.num = 151
  def ns_flow_pair_entry(self, n, c):
    debug_rule("ns_flow_pair_entry",n,c)
    return self.any(
      [ self.ns_flow_pair_yaml_key_entry, n, c ],
      [ self.c_ns_flow_map_empty_key_entry, n, c ],
      [ self.c_ns_flow_pair_json_key_entry, n, c ]
    )



  # [152]
  # ns-flow-pair-yaml-key-entry(n,c) ::=
  #   ns-s-implicit-yaml-key(flow-key)
  #   c-ns-flow-map-separate-value(n,c)

  # @::ns_flow_pair_yaml_key_entry.num = 152
  def ns_flow_pair_yaml_key_entry(self, n, c):
    debug_rule("ns_flow_pair_yaml_key_entry",n,c)
    return self.all(
      [ self.ns_s_implicit_yaml_key, "flow-key" ],
      [ self.c_ns_flow_map_separate_value, n, c ]
    )



  # [153]
  # c-ns-flow-pair-json-key-entry(n,c) ::=
  #   c-s-implicit-json-key(flow-key)
  #   c-ns-flow-map-adjacent-value(n,c)

  # @::c_ns_flow_pair_json_key_entry.num = 153
  def c_ns_flow_pair_json_key_entry(self, n, c):
    debug_rule("c_ns_flow_pair_json_key_entry",n,c)
    return self.all(
      [ self.c_s_implicit_json_key, "flow-key" ],
      [ self.c_ns_flow_map_adjacent_value, n, c ]
    )



  # [154]
  # ns-s-implicit-yaml-key(c) ::=
  #   ns-flow-yaml-node(n/a,c)
  #   s-separate-in-line?
  #   <at_most_1024_characters_altogether>

  # @::ns_s_implicit_yaml_key.num = 154
  def ns_s_implicit_yaml_key(self, c):
    debug_rule("ns_s_implicit_yaml_key",c)
    return self.all(
      self.max(1024),
      [ self.ns_flow_yaml_node, None, c ],
      self.rep(0, 1, self.s_separate_in_line)
    )



  # [155]
  # c-s-implicit-json-key(c) ::=
  #   c-flow-json-node(n/a,c)
  #   s-separate-in-line?
  #   <at_most_1024_characters_altogether>

  # @::c_s_implicit_json_key.num = 155
  def c_s_implicit_json_key(self, c):
    debug_rule("c_s_implicit_json_key",c)
    return self.all(
      self.max(1024),
      [ self.c_flow_json_node, None, c ],
      self.rep(0, 1, self.s_separate_in_line)
    )



  # [156]
  # ns-flow-yaml-content(n,c) ::=
  #   ns-plain(n,c)

  # @::ns_flow_yaml_content.num = 156
  def ns_flow_yaml_content(self, n, c):
    debug_rule("ns_flow_yaml_content",n,c)
    return [ self.ns_plain, n, c ]



  # [157]
  # c-flow-json-content(n,c) ::=
  #   c-flow-sequence(n,c) | c-flow-mapping(n,c)
  #   | c-single-quoted(n,c) | c-double-quoted(n,c)

  # @::c_flow_json_content.num = 157
  def c_flow_json_content(self, n, c):
    debug_rule("c_flow_json_content",n,c)
    return self.any(
      [ self.c_flow_sequence, n, c ],
      [ self.c_flow_mapping, n, c ],
      [ self.c_single_quoted, n, c ],
      [ self.c_double_quoted, n, c ]
    )



  # [158]
  # ns-flow-content(n,c) ::=
  #   ns-flow-yaml-content(n,c) | c-flow-json-content(n,c)

  # @::ns_flow_content.num = 158
  def ns_flow_content(self, n, c):
    debug_rule("ns_flow_content",n,c)
    return self.any(
      [ self.ns_flow_yaml_content, n, c ],
      [ self.c_flow_json_content, n, c ]
    )



  # [159]
  # ns-flow-yaml-node(n,c) ::=
  #   c-ns-alias-node
  #   | ns-flow-yaml-content(n,c)
  #   | ( c-ns-properties(n,c)
  #   ( ( s-separate(n,c)
  #   ns-flow-yaml-content(n,c) )
  #   | e-scalar ) )

  # @::ns_flow_yaml_node.num = 159
  def ns_flow_yaml_node(self, n, c):
    debug_rule("ns_flow_yaml_node",n,c)
    return self.any(
      self.c_ns_alias_node,
      [ self.ns_flow_yaml_content, n, c ],
      self.all(
        [ self.c_ns_properties, n, c ],
        self.any(
          self.all(
            [ self.s_separate, n, c ],
            [ self.ns_flow_yaml_content, n, c ]
          ),
          self.e_scalar
        )
      )
    )



  # [160]
  # c-flow-json-node(n,c) ::=
  #   ( c-ns-properties(n,c)
  #   s-separate(n,c) )?
  #   c-flow-json-content(n,c)

  # @::c_flow_json_node.num = 160
  def c_flow_json_node(self, n, c):
    debug_rule("c_flow_json_node",n,c)
    return self.all(
      self.rep(0, 1,
        self.all(
          [ self.c_ns_properties, n, c ],
          [ self.s_separate, n, c ]
        )),
      [ self.c_flow_json_content, n, c ]
    )



  # [161]
  # ns-flow-node(n,c) ::=
  #   c-ns-alias-node
  #   | ns-flow-content(n,c)
  #   | ( c-ns-properties(n,c)
  #   ( ( s-separate(n,c)
  #   ns-flow-content(n,c) )
  #   | e-scalar ) )

  # @::ns_flow_node.num = 161
  def ns_flow_node(self, n, c):
    debug_rule("ns_flow_node",n,c)
    return self.any(
      self.c_ns_alias_node,
      [ self.ns_flow_content, n, c ],
      self.all(
        [ self.c_ns_properties, n, c ],
        self.any(
          self.all(
            [ self.s_separate, n, c ],
            [ self.ns_flow_content, n, c ]
          ),
          self.e_scalar
        )
      )
    )



  # [162]
  # c-b-block-header(m,t) ::=
  #   ( ( c-indentation-indicator(m)
  #   c-chomping-indicator(t) )
  #   | ( c-chomping-indicator(t)
  #   c-indentation-indicator(m) ) )
  #   s-b-comment

  # @::c_b_block_header.num = 162
  def c_b_block_header(self, m, t):
    debug_rule("c_b_block_header",m,t)
    return self.all(
      self.any(
        self.all(
          [ self.c_indentation_indicator, m ],
          [ self.c_chomping_indicator, t ]
        ),
        self.all(
          [ self.c_chomping_indicator, t ],
          [ self.c_indentation_indicator, m ]
        )
      ),
      self.s_b_comment
    )



  # [163]
  # c-indentation-indicator(m) ::=
  #   ( ns-dec-digit => m = ns-dec-digit - x:30 )
  #   ( <empty> => m = auto-detect() )

  # @::c_indentation_indicator.num = 163
  def c_indentation_indicator(self, m):
    debug_rule("c_indentation_indicator",m)
    return self.any(
      self.if_(self.ns_dec_digit, self.set('m', self.ord(self.match))),
      self.if_(self.empty, self.set('m', "auto-detect"))
    )



  # [164]
  # c-chomping-indicator(t) ::=
  #   ( '-' => t = strip )
  #   ( '+' => t = keep )
  #   ( <empty> => t = clip )

  # @::c_chomping_indicator.num = 164
  def c_chomping_indicator(self, t):
    debug_rule("c_chomping_indicator",t)
    return self.any(
      self.if_(self.chr('-'), self.set('t', "strip")),
      self.if_(self.chr('+'), self.set('t', "keep")),
      self.if_(self.empty, self.set('t', "clip"))
    )



  # [165]
  # b-chomped-last(t) ::=
  #   ( t = strip => b-non-content | <end_of_file> )
  #   ( t = clip => b-as-line-feed | <end_of_file> )
  #   ( t = keep => b-as-line-feed | <end_of_file> )

  # @::b_chomped_last.num = 165
  def b_chomped_last(self, t):
    debug_rule("b_chomped_last",t)
    return self.case(
      t,
      {
        'clip': self.any( self.b_as_line_feed, self.end_of_stream ),
        'keep': self.any( self.b_as_line_feed, self.end_of_stream ),
        'strip': self.any( self.b_non_content, self.end_of_stream ),
      }
    )



  # [166]
  # l-chomped-empty(n,t) ::=
  #   ( t = strip => l-strip-empty(n) )
  #   ( t = clip => l-strip-empty(n) )
  #   ( t = keep => l-keep-empty(n) )

  # @::l_chomped_empty.num = 166
  def l_chomped_empty(self, n, t):
    debug_rule("l_chomped_empty",n,t)
    return self.case(
      t,
      {
        'clip': [ self.l_strip_empty, n ],
        'keep': [ self.l_keep_empty, n ],
        'strip': [ self.l_strip_empty, n ],
      }
    )



  # [167]
  # l-strip-empty(n) ::=
  #   ( s-indent(<=n) b-non-content )*
  #   l-trail-comments(n)?

  # @::l_strip_empty.num = 167
  def l_strip_empty(self, n):
    debug_rule("l_strip_empty",n)
    return self.all(
      self.rep(0, 0,
        self.all(
          [ self.s_indent_le, n ],
          self.b_non_content
        )),
      self.rep(0, 1, [ self.l_trail_comments, n ])
    )



  # [168]
  # l-keep-empty(n) ::=
  #   l-empty(n,block-in)*
  #   l-trail-comments(n)?

  # @::l_keep_empty.num = 168
  def l_keep_empty(self, n):
    debug_rule("l_keep_empty",n)
    return self.all(
      self.rep(0, 0, [ self.l_empty, n, "block-in" ]),
      self.rep(0, 1, [ self.l_trail_comments, n ])
    )



  # [169]
  # l-trail-comments(n) ::=
  #   s-indent(<n)
  #   c-nb-comment-text b-comment
  #   l-comment*

  # @::l_trail_comments.num = 169
  def l_trail_comments(self, n):
    debug_rule("l_trail_comments",n)
    return self.all(
      [ self.s_indent_lt, n ],
      self.c_nb_comment_text,
      self.b_comment,
      self.rep(0, 0, self.l_comment)
    )



  # [170]
  # c-l+literal(n) ::=
  #   '|' c-b-block-header(m,t)
  #   l-literal-content(n+m,t)

  # @::c_l_literal.num = 170
  def c_l_literal(self, n):
    debug_rule("c_l_literal",n)
    return self.all(
      self.chr('|'),
      [ self.c_b_block_header, self.m(), self.t() ],
      [ self.l_literal_content, self.add(n, self.m()), self.t() ]
    )



  # [171]
  # l-nb-literal-text(n) ::=
  #   l-empty(n,block-in)*
  #   s-indent(n) nb-char+

  # @::l_nb_literal_text.num = 171
  def l_nb_literal_text(self, n):
    debug_rule("l_nb_literal_text",n)
    return self.all(
      self.rep(0, 0, [ self.l_empty, n, "block-in" ]),
      [ self.s_indent, n ],
      self.rep(1, 0, self.nb_char)
    )



  # [172]
  # b-nb-literal-next(n) ::=
  #   b-as-line-feed
  #   l-nb-literal-text(n)

  # @::b_nb_literal_next.num = 172
  def b_nb_literal_next(self, n):
    debug_rule("b_nb_literal_next",n)
    return self.all(
      self.b_as_line_feed,
      [ self.l_nb_literal_text, n ]
    )



  # [173]
  # l-literal-content(n,t) ::=
  #   ( l-nb-literal-text(n)
  #   b-nb-literal-next(n)*
  #   b-chomped-last(t) )?
  #   l-chomped-empty(n,t)

  # @::l_literal_content.num = 173
  def l_literal_content(self, n, t):
    debug_rule("l_literal_content",n,t)
    return self.all(
      self.rep(0, 1,
        self.all(
          [ self.l_nb_literal_text, n ],
          self.rep(0, 0, [ self.b_nb_literal_next, n ]),
          [ self.b_chomped_last, t ]
        )),
      [ self.l_chomped_empty, n, t ]
    )



  # [174]
  # c-l+folded(n) ::=
  #   '>' c-b-block-header(m,t)
  #   l-folded-content(n+m,t)

  # @::c_l_folded.num = 174
  def c_l_folded(self, n):
    debug_rule("c_l_folded",n)
    return self.all(
      self.chr('>'),
      [ self.c_b_block_header, self.m(), self.t() ],
      [ self.l_folded_content, self.add(n, self.m()), self.t() ]
    )



  # [175]
  # s-nb-folded-text(n) ::=
  #   s-indent(n) ns-char
  #   nb-char*

  # @::s_nb_folded_text.num = 175
  def s_nb_folded_text(self, n):
    debug_rule("s_nb_folded_text",n)
    return self.all(
      [ self.s_indent, n ],
      self.ns_char,
      self.rep(0, 0, self.nb_char)
    )



  # [176]
  # l-nb-folded-lines(n) ::=
  #   s-nb-folded-text(n)
  #   ( b-l-folded(n,block-in) s-nb-folded-text(n) )*

  # @::l_nb_folded_lines.num = 176
  def l_nb_folded_lines(self, n):
    debug_rule("l_nb_folded_lines",n)
    return self.all(
      [ self.s_nb_folded_text, n ],
      self.rep(0, 0,
        self.all(
          [ self.b_l_folded, n, "block-in" ],
          [ self.s_nb_folded_text, n ]
        ))
    )



  # [177]
  # s-nb-spaced-text(n) ::=
  #   s-indent(n) s-white
  #   nb-char*

  # @::s_nb_spaced_text.num = 177
  def s_nb_spaced_text(self, n):
    debug_rule("s_nb_spaced_text",n)
    return self.all(
      [ self.s_indent, n ],
      self.s_white,
      self.rep(0, 0, self.nb_char)
    )



  # [178]
  # b-l-spaced(n) ::=
  #   b-as-line-feed
  #   l-empty(n,block-in)*

  # @::b_l_spaced.num = 178
  def b_l_spaced(self, n):
    debug_rule("b_l_spaced",n)
    return self.all(
      self.b_as_line_feed,
      self.rep(0, 0, [ self.l_empty, n, "block-in" ])
    )



  # [179]
  # l-nb-spaced-lines(n) ::=
  #   s-nb-spaced-text(n)
  #   ( b-l-spaced(n) s-nb-spaced-text(n) )*

  # @::l_nb_spaced_lines.num = 179
  def l_nb_spaced_lines(self, n):
    debug_rule("l_nb_spaced_lines",n)
    return self.all(
      [ self.s_nb_spaced_text, n ],
      self.rep(0, 0,
        self.all(
          [ self.b_l_spaced, n ],
          [ self.s_nb_spaced_text, n ]
        ))
    )



  # [180]
  # l-nb-same-lines(n) ::=
  #   l-empty(n,block-in)*
  #   ( l-nb-folded-lines(n) | l-nb-spaced-lines(n) )

  # @::l_nb_same_lines.num = 180
  def l_nb_same_lines(self, n):
    debug_rule("l_nb_same_lines",n)
    return self.all(
      self.rep(0, 0, [ self.l_empty, n, "block-in" ]),
      self.any(
        [ self.l_nb_folded_lines, n ],
        [ self.l_nb_spaced_lines, n ]
      )
    )



  # [181]
  # l-nb-diff-lines(n) ::=
  #   l-nb-same-lines(n)
  #   ( b-as-line-feed l-nb-same-lines(n) )*

  # @::l_nb_diff_lines.num = 181
  def l_nb_diff_lines(self, n):
    debug_rule("l_nb_diff_lines",n)
    return self.all(
      [ self.l_nb_same_lines, n ],
      self.rep(0, 0,
        self.all(
          self.b_as_line_feed,
          [ self.l_nb_same_lines, n ]
        ))
    )



  # [182]
  # l-folded-content(n,t) ::=
  #   ( l-nb-diff-lines(n)
  #   b-chomped-last(t) )?
  #   l-chomped-empty(n,t)

  # @::l_folded_content.num = 182
  def l_folded_content(self, n, t):
    debug_rule("l_folded_content",n,t)
    return self.all(
      self.rep(0, 1,
        self.all(
          [ self.l_nb_diff_lines, n ],
          [ self.b_chomped_last, t ]
        )),
      [ self.l_chomped_empty, n, t ]
    )



  # [183]
  # l+block-sequence(n) ::=
  #   ( s-indent(n+m)
  #   c-l-block-seq-entry(n+m) )+
  #   <for_some_fixed_auto-detected_m_>_0>

  # @::l_block_sequence.num = 183
  def l_block_sequence(self, n):
    debug_rule("l_block_sequence",n)
    return self.all(
      self.set('m', self.auto_detect_indent),
      self.rep(1, 0,
        self.all(
          [ self.s_indent, self.add(n, self.m()) ],
          [ self.c_l_block_seq_entry, self.add(n, self.m()) ]
        ))
    )



  # [184]
  # c-l-block-seq-entry(n) ::=
  #   '-' <not_followed_by_an_ns-char>
  #   s-l+block-indented(n,block-in)

  # @::c_l_block_seq_entry.num = 184
  def c_l_block_seq_entry(self, n):
    debug_rule("c_l_block_seq_entry",n)
    return self.all(
      self.chr('-'),
      self.chk('!', self.ns_char),
      [ self.s_l_block_indented, n, "block-in" ]
    )



  # [185]
  # s-l+block-indented(n,c) ::=
  #   ( s-indent(m)
  #   ( ns-l-compact-sequence(n+1+m)
  #   | ns-l-compact-mapping(n+1+m) ) )
  #   | s-l+block-node(n,c)
  #   | ( e-node s-l-comments )

  # @::s_l_block_indented.num = 185
  def s_l_block_indented(self, n, c):
    debug_rule("s_l_block_indented",n,c)
    return self.any(
      self.all(
        [ self.s_indent, self.m() ],
        self.any(
          [ self.ns_l_compact_sequence, self.add(n, self.add(1, self.m())) ],
          [ self.ns_l_compact_mapping, self.add(n, self.add(1, self.m())) ]
        )
      ),
      [ self.s_l_block_node, n, c ],
      self.all(
        self.e_node,
        self.s_l_comments
      )
    )



  # [186]
  # ns-l-compact-sequence(n) ::=
  #   c-l-block-seq-entry(n)
  #   ( s-indent(n) c-l-block-seq-entry(n) )*

  # @::ns_l_compact_sequence.num = 186
  def ns_l_compact_sequence(self, n):
    debug_rule("ns_l_compact_sequence",n)
    return self.all(
      [ self.c_l_block_seq_entry, n ],
      self.rep(0, 0,
        self.all(
          [ self.s_indent, n ],
          [ self.c_l_block_seq_entry, n ]
        ))
    )



  # [187]
  # l+block-mapping(n) ::=
  #   ( s-indent(n+m)
  #   ns-l-block-map-entry(n+m) )+
  #   <for_some_fixed_auto-detected_m_>_0>

  # @::l_block_mapping.num = 187
  def l_block_mapping(self, n):
    debug_rule("l_block_mapping",n)
    return self.all(
      self.set('m', self.auto_detect_indent),
      self.rep(1, 0,
        self.all(
          [ self.s_indent, self.add(n, self.m()) ],
          [ self.ns_l_block_map_entry, self.add(n, self.m()) ]
        ))
    )



  # [188]
  # ns-l-block-map-entry(n) ::=
  #   c-l-block-map-explicit-entry(n)
  #   | ns-l-block-map-implicit-entry(n)

  # @::ns_l_block_map_entry.num = 188
  def ns_l_block_map_entry(self, n):
    debug_rule("ns_l_block_map_entry",n)
    return self.any(
      [ self.c_l_block_map_explicit_entry, n ],
      [ self.ns_l_block_map_implicit_entry, n ]
    )



  # [189]
  # c-l-block-map-explicit-entry(n) ::=
  #   c-l-block-map-explicit-key(n)
  #   ( l-block-map-explicit-value(n)
  #   | e-node )

  # @::c_l_block_map_explicit_entry.num = 189
  def c_l_block_map_explicit_entry(self, n):
    debug_rule("c_l_block_map_explicit_entry",n)
    return self.all(
      [ self.c_l_block_map_explicit_key, n ],
      self.any(
        [ self.l_block_map_explicit_value, n ],
        self.e_node
      )
    )



  # [190]
  # c-l-block-map-explicit-key(n) ::=
  #   '?'
  #   s-l+block-indented(n,block-out)

  # @::c_l_block_map_explicit_key.num = 190
  def c_l_block_map_explicit_key(self, n):
    debug_rule("c_l_block_map_explicit_key",n)
    return self.all(
      self.chr('?'),
      [ self.s_l_block_indented, n, "block-out" ]
    )



  # [191]
  # l-block-map-explicit-value(n) ::=
  #   s-indent(n)
  #   ':' s-l+block-indented(n,block-out)

  # @::l_block_map_explicit_value.num = 191
  def l_block_map_explicit_value(self, n):
    debug_rule("l_block_map_explicit_value",n)
    return self.all(
      [ self.s_indent, n ],
      self.chr(':'),
      [ self.s_l_block_indented, n, "block-out" ]
    )



  # [192]
  # ns-l-block-map-implicit-entry(n) ::=
  #   (
  #   ns-s-block-map-implicit-key
  #   | e-node )
  #   c-l-block-map-implicit-value(n)

  # @::ns_l_block_map_implicit_entry.num = 192
  def ns_l_block_map_implicit_entry(self, n):
    debug_rule("ns_l_block_map_implicit_entry",n)
    return self.all(
      self.any(
        self.ns_s_block_map_implicit_key,
        self.e_node
      ),
      [ self.c_l_block_map_implicit_value, n ]
    )



  # [193]
  # ns-s-block-map-implicit-key ::=
  #   c-s-implicit-json-key(block-key)
  #   | ns-s-implicit-yaml-key(block-key)

  # @::ns_s_block_map_implicit_key.num = 193
  def ns_s_block_map_implicit_key(self):
    debug_rule("ns_s_block_map_implicit_key")
    return self.any(
      [ self.c_s_implicit_json_key, "block-key" ],
      [ self.ns_s_implicit_yaml_key, "block-key" ]
    )



  # [194]
  # c-l-block-map-implicit-value(n) ::=
  #   ':' (
  #   s-l+block-node(n,block-out)
  #   | ( e-node s-l-comments ) )

  # @::c_l_block_map_implicit_value.num = 194
  def c_l_block_map_implicit_value(self, n):
    debug_rule("c_l_block_map_implicit_value",n)
    return self.all(
      self.chr(':'),
      self.any(
        [ self.s_l_block_node, n, "block-out" ],
        self.all(
          self.e_node,
          self.s_l_comments
        )
      )
    )



  # [195]
  # ns-l-compact-mapping(n) ::=
  #   ns-l-block-map-entry(n)
  #   ( s-indent(n) ns-l-block-map-entry(n) )*

  # @::ns_l_compact_mapping.num = 195
  def ns_l_compact_mapping(self, n):
    debug_rule("ns_l_compact_mapping",n)
    return self.all(
      [ self.ns_l_block_map_entry, n ],
      self.rep(0, 0,
        self.all(
          [ self.s_indent, n ],
          [ self.ns_l_block_map_entry, n ]
        ))
    )



  # [196]
  # s-l+block-node(n,c) ::=
  #   s-l+block-in-block(n,c) | s-l+flow-in-block(n)

  # @::s_l_block_node.num = 196
  def s_l_block_node(self, n, c):
    debug_rule("s_l_block_node",n,c)
    return self.any(
      [ self.s_l_block_in_block, n, c ],
      [ self.s_l_flow_in_block, n ]
    )



  # [197]
  # s-l+flow-in-block(n) ::=
  #   s-separate(n+1,flow-out)
  #   ns-flow-node(n+1,flow-out) s-l-comments

  # @::s_l_flow_in_block.num = 197
  def s_l_flow_in_block(self, n):
    debug_rule("s_l_flow_in_block",n)
    return self.all(
      [ self.s_separate, self.add(n, 1), "flow-out" ],
      [ self.ns_flow_node, self.add(n, 1), "flow-out" ],
      self.s_l_comments
    )



  # [198]
  # s-l+block-in-block(n,c) ::=
  #   s-l+block-scalar(n,c) | s-l+block-collection(n,c)

  # @::s_l_block_in_block.num = 198
  def s_l_block_in_block(self, n, c):
    debug_rule("s_l_block_in_block",n,c)
    return self.any(
      [ self.s_l_block_scalar, n, c ],
      [ self.s_l_block_collection, n, c ]
    )



  # [199]
  # s-l+block-scalar(n,c) ::=
  #   s-separate(n+1,c)
  #   ( c-ns-properties(n+1,c) s-separate(n+1,c) )?
  #   ( c-l+literal(n) | c-l+folded(n) )

  # @::s_l_block_scalar.num = 199
  def s_l_block_scalar(self, n, c):
    debug_rule("s_l_block_scalar",n,c)
    return self.all(
      [ self.s_separate, self.add(n, 1), c ],
      self.rep(0, 1,
        self.all(
          [ self.c_ns_properties, self.add(n, 1), c ],
          [ self.s_separate, self.add(n, 1), c ]
        )),
      self.any(
        [ self.c_l_literal, n ],
        [ self.c_l_folded, n ]
      )
    )



  # [200]
  # s-l+block-collection(n,c) ::=
  #   ( s-separate(n+1,c)
  #   c-ns-properties(n+1,c) )?
  #   s-l-comments
  #   ( l+block-sequence(seq-spaces(n,c))
  #   | l+block-mapping(n) )

  # @::s_l_block_collection.num = 200
  def s_l_block_collection(self, n, c):
    debug_rule("s_l_block_collection",n,c)
    return self.all(
      self.rep(0, 1,
        self.all(
          [ self.s_separate, self.add(n, 1), c ],
          [ self.c_ns_properties, self.add(n, 1), c ]
        )),
      self.s_l_comments,
      self.any(
        [ self.l_block_sequence, [ self.seq_spaces, n, c ] ],
        [ self.l_block_mapping, n ]
      )
    )



  # [201]
  # seq-spaces(n,c) ::=
  #   ( c = block-out => n-1 )
  #   ( c = block-in => n )

  # @::seq_spaces.num = 201
  def seq_spaces(self, n, c):
    debug_rule("seq_spaces",n,c)
    return self.flip(
      c,
      {
        'block-in': n,
        'block-out': self.sub(n, 1),
      }
    )



  # [202]
  # l-document-prefix ::=
  #   c-byte-order-mark? l-comment*

  # @::l_document_prefix.num = 202
  def l_document_prefix(self):
    debug_rule("l_document_prefix")
    return self.all(
      self.rep(0, 1, self.c_byte_order_mark),
      self.rep(0, 0, self.l_comment)
    )



  # [203]
  # c-directives-end ::=
  #   '-' '-' '-'

  # @::c_directives_end.num = 203
  def c_directives_end(self):
    debug_rule("c_directives_end")
    return self.all(
      self.chr('-'),
      self.chr('-'),
      self.chr('-')
    )



  # [204]
  # c-document-end ::=
  #   '.' '.' '.'

  # @::c_document_end.num = 204
  def c_document_end(self):
    debug_rule("c_document_end")
    return self.all(
      self.chr('.'),
      self.chr('.'),
      self.chr('.')
    )



  # [205]
  # l-document-suffix ::=
  #   c-document-end s-l-comments

  # @::l_document_suffix.num = 205
  def l_document_suffix(self):
    debug_rule("l_document_suffix")
    return self.all(
      self.c_document_end,
      self.s_l_comments
    )



  # [206]
  # c-forbidden ::=
  #   <start_of_line>
  #   ( c-directives-end | c-document-end )
  #   ( b-char | s-white | <end_of_file> )

  # @::c_forbidden.num = 206
  def c_forbidden(self):
    debug_rule("c_forbidden")
    return self.all(
      self.start_of_line,
      self.any(
        self.c_directives_end,
        self.c_document_end
      ),
      self.any(
        self.b_char,
        self.s_white,
        self.end_of_stream
      )
    )



  # [207]
  # l-bare-document ::=
  #   s-l+block-node(-1,block-in)
  #   <excluding_c-forbidden_content>

  # @::l_bare_document.num = 207
  def l_bare_document(self):
    debug_rule("l_bare_document")
    return self.all(
      self.exclude(self.c_forbidden),
      [ self.s_l_block_node, -1, "block-in" ]
    )



  # [208]
  # l-explicit-document ::=
  #   c-directives-end
  #   ( l-bare-document
  #   | ( e-node s-l-comments ) )

  # @::l_explicit_document.num = 208
  def l_explicit_document(self):
    debug_rule("l_explicit_document")
    return self.all(
      self.c_directives_end,
      self.any(
        self.l_bare_document,
        self.all(
          self.e_node,
          self.s_l_comments
        )
      )
    )



  # [209]
  # l-directive-document ::=
  #   l-directive+
  #   l-explicit-document

  # @::l_directive_document.num = 209
  def l_directive_document(self):
    debug_rule("l_directive_document")
    return self.all(
      self.rep(1, 0, self.l_directive),
      self.l_explicit_document
    )



  # [210]
  # l-any-document ::=
  #   l-directive-document
  #   | l-explicit-document
  #   | l-bare-document

  # @::l_any_document.num = 210
  def l_any_document(self):
    debug_rule("l_any_document")
    return self.any(
      self.l_directive_document,
      self.l_explicit_document,
      self.l_bare_document
    )



  # [211]
  # l-yaml-stream ::=
  #   l-document-prefix l-any-document?
  #   ( ( l-document-suffix+ l-document-prefix
  #   l-any-document? )
  #   | ( l-document-prefix l-explicit-document? ) )*

  # @::l_yaml_stream.num = 211
  def l_yaml_stream(self):
    debug_rule("l_yaml_stream")
    return self.all(
      self.l_document_prefix,
      self.rep(0, 1, self.l_any_document),
      self.rep(0, 0,
        self.any(
          self.all(
            self.l_document_suffix,
            self.rep(0, 0, self.l_document_prefix),
            self.rep(0, 1, self.l_any_document)
          ),
          self.all(
            self.l_document_prefix,
            self.rep(0, 1, self.l_explicit_document)
          )
        ))
    )



