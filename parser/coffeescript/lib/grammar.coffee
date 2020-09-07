###
This grammar class was generated from https://yaml.org/spec/1.2/spec.html
###

global.Grammar = class Grammar

  TOP: -> @l_yaml_stream


  # [001]
  # c-printable ::=
  #   x:9 | x:A | x:D | [x:20-x:7E]
  #   | x:85 | [x:A0-x:D7FF] | [x:E000-x:FFFD]
  #   | [x:10000-x:10FFFF]

  @::c_printable.num = 1
  c_printable: ->
    debug1("c_printable")
    @any(
      @chr("\u{09}"),
      @chr("\u{0A}"),
      @chr("\u{0D}"),
      @rng("\u{20}", "\u{7E}"),
      @chr("\u{85}"),
      @rng("\u{A0}", "\u{D7FF}"),
      @rng("\u{E000}", "\u{FFFD}"),
      @rng("\u{010000}", "\u{10FFFF}"),
    )



  # [002]
  # nb-json ::=
  #   x:9 | [x:20-x:10FFFF]

  @::nb_json.num = 2
  nb_json: ->
    debug1("nb_json")
    @any(
      @chr("\u{09}"),
      @rng("\u{20}", "\u{10FFFF}"),
    )



  # [003]
  # c-byte-order-mark ::=
  #   x:FEFF

  @::c_byte_order_mark.num = 3
  c_byte_order_mark: ->
    debug1("c_byte_order_mark")
    @chr("\u{FEFF}")



  # [004]
  # c-sequence-entry ::=
  #   '-'

  @::c_sequence_entry.num = 4
  c_sequence_entry: ->
    debug1("c_sequence_entry")
    @chr('-')



  # [005]
  # c-mapping-key ::=
  #   '?'

  @::c_mapping_key.num = 5
  c_mapping_key: ->
    debug1("c_mapping_key")
    @chr('?')



  # [006]
  # c-mapping-value ::=
  #   ':'

  @::c_mapping_value.num = 6
  c_mapping_value: ->
    debug1("c_mapping_value")
    @chr(':')



  # [007]
  # c-collect-entry ::=
  #   ','

  @::c_collect_entry.num = 7
  c_collect_entry: ->
    debug1("c_collect_entry")
    @chr(',')



  # [008]
  # c-sequence-start ::=
  #   '['

  @::c_sequence_start.num = 8
  c_sequence_start: ->
    debug1("c_sequence_start")
    @chr('[')



  # [009]
  # c-sequence-end ::=
  #   ']'

  @::c_sequence_end.num = 9
  c_sequence_end: ->
    debug1("c_sequence_end")
    @chr(']')



  # [010]
  # c-mapping-start ::=
  #   '{'

  @::c_mapping_start.num = 10
  c_mapping_start: ->
    debug1("c_mapping_start")
    @chr('{')



  # [011]
  # c-mapping-end ::=
  #   '}'

  @::c_mapping_end.num = 11
  c_mapping_end: ->
    debug1("c_mapping_end")
    @chr('}')



  # [012]
  # c-comment ::=
  #   '#'

  @::c_comment.num = 12
  c_comment: ->
    debug1("c_comment")
    @chr('#')



  # [013]
  # c-anchor ::=
  #   '&'

  @::c_anchor.num = 13
  c_anchor: ->
    debug1("c_anchor")
    @chr('&')



  # [014]
  # c-alias ::=
  #   '*'

  @::c_alias.num = 14
  c_alias: ->
    debug1("c_alias")
    @chr('*')



  # [015]
  # c-tag ::=
  #   '!'

  @::c_tag.num = 15
  c_tag: ->
    debug1("c_tag")
    @chr('!')



  # [016]
  # c-literal ::=
  #   '|'

  @::c_literal.num = 16
  c_literal: ->
    debug1("c_literal")
    @chr('|')



  # [017]
  # c-folded ::=
  #   '>'

  @::c_folded.num = 17
  c_folded: ->
    debug1("c_folded")
    @chr('>')



  # [018]
  # c-single-quote ::=
  #   '''

  @::c_single_quote.num = 18
  c_single_quote: ->
    debug1("c_single_quote")
    @chr("'")



  # [019]
  # c-double-quote ::=
  #   '"'

  @::c_double_quote.num = 19
  c_double_quote: ->
    debug1("c_double_quote")
    @chr('"')



  # [020]
  # c-directive ::=
  #   '%'

  @::c_directive.num = 20
  c_directive: ->
    debug1("c_directive")
    @chr('%')



  # [021]
  # c-reserved ::=
  #   '@' | '`'

  @::c_reserved.num = 21
  c_reserved: ->
    debug1("c_reserved")
    @any(
      @chr('@'),
      @chr('`'),
    )



  # [022]
  # c-indicator ::=
  #   '-' | '?' | ':' | ',' | '[' | ']' | '{' | '}'
  #   | '#' | '&' | '*' | '!' | '|' | '>' | ''' | '"'
  #   | '%' | '@' | '`'

  @::c_indicator.num = 22
  c_indicator: ->
    debug1("c_indicator")
    @any(
      @chr('-'),
      @chr('?'),
      @chr(':'),
      @chr(','),
      @chr('['),
      @chr(']'),
      @chr('{'),
      @chr('}'),
      @chr('#'),
      @chr('&'),
      @chr('*'),
      @chr('!'),
      @chr('|'),
      @chr('>'),
      @chr("'"),
      @chr('"'),
      @chr('%'),
      @chr('@'),
      @chr('`'),
    )



  # [023]
  # c-flow-indicator ::=
  #   ',' | '[' | ']' | '{' | '}'

  @::c_flow_indicator.num = 23
  c_flow_indicator: ->
    debug1("c_flow_indicator")
    @any(
      @chr(','),
      @chr('['),
      @chr(']'),
      @chr('{'),
      @chr('}'),
    )



  # [024]
  # b-line-feed ::=
  #   x:A

  @::b_line_feed.num = 24
  b_line_feed: ->
    debug1("b_line_feed")
    @chr("\u{0A}")



  # [025]
  # b-carriage-return ::=
  #   x:D

  @::b_carriage_return.num = 25
  b_carriage_return: ->
    debug1("b_carriage_return")
    @chr("\u{0D}")



  # [026]
  # b-char ::=
  #   b-line-feed | b-carriage-return

  @::b_char.num = 26
  b_char: ->
    debug1("b_char")
    @any(
      @b_line_feed,
      @b_carriage_return,
    )



  # [027]
  # nb-char ::=
  #   c-printable - b-char - c-byte-order-mark

  @::nb_char.num = 27
  nb_char: ->
    debug1("nb_char")
    @but(
      @c_printable,
      @b_char,
      @c_byte_order_mark,
    )



  # [028]
  # b-break ::=
  #   ( b-carriage-return b-line-feed )
  #   | b-carriage-return
  #   | b-line-feed

  @::b_break.num = 28
  b_break: ->
    debug1("b_break")
    @any(
      @all(
        @b_carriage_return,
        @b_line_feed,
      ),
      @b_carriage_return,
      @b_line_feed,
    )



  # [029]
  # b-as-line-feed ::=
  #   b-break

  @::b_as_line_feed.num = 29
  b_as_line_feed: ->
    debug1("b_as_line_feed")
    @b_break



  # [030]
  # b-non-content ::=
  #   b-break

  @::b_non_content.num = 30
  b_non_content: ->
    debug1("b_non_content")
    @b_break



  # [031]
  # s-space ::=
  #   x:20

  @::s_space.num = 31
  s_space: ->
    debug1("s_space")
    @chr("\u{20}")



  # [032]
  # s-tab ::=
  #   x:9

  @::s_tab.num = 32
  s_tab: ->
    debug1("s_tab")
    @chr("\u{09}")



  # [033]
  # s-white ::=
  #   s-space | s-tab

  @::s_white.num = 33
  s_white: ->
    debug1("s_white")
    @any(
      @s_space,
      @s_tab,
    )



  # [034]
  # ns-char ::=
  #   nb-char - s-white

  @::ns_char.num = 34
  ns_char: ->
    debug1("ns_char")
    @but(
      @nb_char,
      @s_white,
    )



  # [035]
  # ns-dec-digit ::=
  #   [x:30-x:39]

  @::ns_dec_digit.num = 35
  ns_dec_digit: ->
    debug1("ns_dec_digit")
    @rng("\u{30}", "\u{39}")



  # [036]
  # ns-hex-digit ::=
  #   ns-dec-digit
  #   | [x:41-x:46] | [x:61-x:66]

  @::ns_hex_digit.num = 36
  ns_hex_digit: ->
    debug1("ns_hex_digit")
    @any(
      @ns_dec_digit,
      @rng("\u{41}", "\u{46}"),
      @rng("\u{61}", "\u{66}"),
    )



  # [037]
  # ns-ascii-letter ::=
  #   [x:41-x:5A] | [x:61-x:7A]

  @::ns_ascii_letter.num = 37
  ns_ascii_letter: ->
    debug1("ns_ascii_letter")
    @any(
      @rng("\u{41}", "\u{5A}"),
      @rng("\u{61}", "\u{7A}"),
    )



  # [038]
  # ns-word-char ::=
  #   ns-dec-digit | ns-ascii-letter | '-'

  @::ns_word_char.num = 38
  ns_word_char: ->
    debug1("ns_word_char")
    @any(
      @ns_dec_digit,
      @ns_ascii_letter,
      @chr('-'),
    )



  # [039]
  # ns-uri-char ::=
  #   '%' ns-hex-digit ns-hex-digit | ns-word-char | '#'
  #   | ';' | '/' | '?' | ':' | '@' | '&' | '=' | '+' | '$' | ','
  #   | '_' | '.' | '!' | '~' | '*' | ''' | '(' | ')' | '[' | ']'

  @::ns_uri_char.num = 39
  ns_uri_char: ->
    debug1("ns_uri_char")
    @any(
      @all(
        @chr('%'),
        @ns_hex_digit,
        @ns_hex_digit,
      ),
      @ns_word_char,
      @chr('#'),
      @chr(';'),
      @chr('/'),
      @chr('?'),
      @chr(':'),
      @chr('@'),
      @chr('&'),
      @chr('='),
      @chr('+'),
      @chr('$'),
      @chr(','),
      @chr('_'),
      @chr('.'),
      @chr('!'),
      @chr('~'),
      @chr('*'),
      @chr("'"),
      @chr('('),
      @chr(')'),
      @chr('['),
      @chr(']'),
    )



  # [040]
  # ns-tag-char ::=
  #   ns-uri-char - '!' - c-flow-indicator

  @::ns_tag_char.num = 40
  ns_tag_char: ->
    debug1("ns_tag_char")
    @but(
      @ns_uri_char,
      @chr('!'),
      @c_flow_indicator,
    )



  # [041]
  # c-escape ::=
  #   '\'

  @::c_escape.num = 41
  c_escape: ->
    debug1("c_escape")
    @chr("\\")



  # [042]
  # ns-esc-null ::=
  #   '0'

  @::ns_esc_null.num = 42
  ns_esc_null: ->
    debug1("ns_esc_null")
    @chr('0')



  # [043]
  # ns-esc-bell ::=
  #   'a'

  @::ns_esc_bell.num = 43
  ns_esc_bell: ->
    debug1("ns_esc_bell")
    @chr('a')



  # [044]
  # ns-esc-backspace ::=
  #   'b'

  @::ns_esc_backspace.num = 44
  ns_esc_backspace: ->
    debug1("ns_esc_backspace")
    @chr('b')



  # [045]
  # ns-esc-horizontal-tab ::=
  #   't' | x:9

  @::ns_esc_horizontal_tab.num = 45
  ns_esc_horizontal_tab: ->
    debug1("ns_esc_horizontal_tab")
    @any(
      @chr('t'),
      @chr("\u{09}"),
    )



  # [046]
  # ns-esc-line-feed ::=
  #   'n'

  @::ns_esc_line_feed.num = 46
  ns_esc_line_feed: ->
    debug1("ns_esc_line_feed")
    @chr('n')



  # [047]
  # ns-esc-vertical-tab ::=
  #   'v'

  @::ns_esc_vertical_tab.num = 47
  ns_esc_vertical_tab: ->
    debug1("ns_esc_vertical_tab")
    @chr('v')



  # [048]
  # ns-esc-form-feed ::=
  #   'f'

  @::ns_esc_form_feed.num = 48
  ns_esc_form_feed: ->
    debug1("ns_esc_form_feed")
    @chr('f')



  # [049]
  # ns-esc-carriage-return ::=
  #   'r'

  @::ns_esc_carriage_return.num = 49
  ns_esc_carriage_return: ->
    debug1("ns_esc_carriage_return")
    @chr('r')



  # [050]
  # ns-esc-escape ::=
  #   'e'

  @::ns_esc_escape.num = 50
  ns_esc_escape: ->
    debug1("ns_esc_escape")
    @chr('e')



  # [051]
  # ns-esc-space ::=
  #   x:20

  @::ns_esc_space.num = 51
  ns_esc_space: ->
    debug1("ns_esc_space")
    @chr("\u{20}")



  # [052]
  # ns-esc-double-quote ::=
  #   '"'

  @::ns_esc_double_quote.num = 52
  ns_esc_double_quote: ->
    debug1("ns_esc_double_quote")
    @chr('"')



  # [053]
  # ns-esc-slash ::=
  #   '/'

  @::ns_esc_slash.num = 53
  ns_esc_slash: ->
    debug1("ns_esc_slash")
    @chr('/')



  # [054]
  # ns-esc-backslash ::=
  #   '\'

  @::ns_esc_backslash.num = 54
  ns_esc_backslash: ->
    debug1("ns_esc_backslash")
    @chr("\\")



  # [055]
  # ns-esc-next-line ::=
  #   'N'

  @::ns_esc_next_line.num = 55
  ns_esc_next_line: ->
    debug1("ns_esc_next_line")
    @chr('N')



  # [056]
  # ns-esc-non-breaking-space ::=
  #   '_'

  @::ns_esc_non_breaking_space.num = 56
  ns_esc_non_breaking_space: ->
    debug1("ns_esc_non_breaking_space")
    @chr('_')



  # [057]
  # ns-esc-line-separator ::=
  #   'L'

  @::ns_esc_line_separator.num = 57
  ns_esc_line_separator: ->
    debug1("ns_esc_line_separator")
    @chr('L')



  # [058]
  # ns-esc-paragraph-separator ::=
  #   'P'

  @::ns_esc_paragraph_separator.num = 58
  ns_esc_paragraph_separator: ->
    debug1("ns_esc_paragraph_separator")
    @chr('P')



  # [059]
  # ns-esc-8-bit ::=
  #   'x'
  #   ( ns-hex-digit{2} )

  @::ns_esc_8_bit.num = 59
  ns_esc_8_bit: ->
    debug1("ns_esc_8_bit")
    @all(
      @chr('x'),
      @rep(2, 2, @ns_hex_digit),
    )



  # [060]
  # ns-esc-16-bit ::=
  #   'u'
  #   ( ns-hex-digit{4} )

  @::ns_esc_16_bit.num = 60
  ns_esc_16_bit: ->
    debug1("ns_esc_16_bit")
    @all(
      @chr('u'),
      @rep(4, 4, @ns_hex_digit),
    )



  # [061]
  # ns-esc-32-bit ::=
  #   'U'
  #   ( ns-hex-digit{8} )

  @::ns_esc_32_bit.num = 61
  ns_esc_32_bit: ->
    debug1("ns_esc_32_bit")
    @all(
      @chr('U'),
      @rep(8, 8, @ns_hex_digit),
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

  @::c_ns_esc_char.num = 62
  c_ns_esc_char: ->
    debug1("c_ns_esc_char")
    @all(
      @chr("\\"),
      @any(
        @ns_esc_null,
        @ns_esc_bell,
        @ns_esc_backspace,
        @ns_esc_horizontal_tab,
        @ns_esc_line_feed,
        @ns_esc_vertical_tab,
        @ns_esc_form_feed,
        @ns_esc_carriage_return,
        @ns_esc_escape,
        @ns_esc_space,
        @ns_esc_double_quote,
        @ns_esc_slash,
        @ns_esc_backslash,
        @ns_esc_next_line,
        @ns_esc_non_breaking_space,
        @ns_esc_line_separator,
        @ns_esc_paragraph_separator,
        @ns_esc_8_bit,
        @ns_esc_16_bit,
        @ns_esc_32_bit,
      ),
    )



  # [063]
  # s-indent(n) ::=
  #   s-space{n}

  @::s_indent.num = 63
  s_indent: (n)->
    debug1("s_indent",n)
    @rep(n, n, @s_space)



  # [064]
  # s-indent(<n) ::=
  #   s-space{m} <where_m_<_n>

  @::s_indent_lt.num = 64
  s_indent_lt: (n)->
    debug1("s_indent_lt",n)
    @may(
      @all(
        @rep(0, 0, @s_space),
        @lt(@len(@match), n),
      )
    )



  # [065]
  # s-indent(<=n) ::=
  #   s-space{m} <where_m_<=_n>

  @::s_indent_le.num = 65
  s_indent_le: (n)->
    debug1("s_indent_le",n)
    @may(
      @all(
        @rep(0, 0, @s_space),
        @le(@len(@match), @chr('n')),
      )
    )



  # [066]
  # s-separate-in-line ::=
  #   s-white+ | <start_of_line>

  @::s_separate_in_line.num = 66
  s_separate_in_line: ->
    debug1("s_separate_in_line")
    @any(
      @rep(1, 0, @s_white),
      @start_of_line,
    )



  # [067]
  # s-line-prefix(n,c) ::=
  #   ( c = block-out => s-block-line-prefix(n) )
  #   ( c = block-in => s-block-line-prefix(n) )
  #   ( c = flow-out => s-flow-line-prefix(n) )
  #   ( c = flow-in => s-flow-line-prefix(n) )

  @::s_line_prefix.num = 67
  s_line_prefix: (n, c)->
    debug1("s_line_prefix",n,c)
    @case(c, {
      'block-in': [ @s_block_line_prefix, n ],
      'block-out': [ @s_block_line_prefix, n ],
      'flow-in': [ @s_flow_line_prefix, n ],
      'flow-out': [ @s_flow_line_prefix, n ],
    })



  # [068]
  # s-block-line-prefix(n) ::=
  #   s-indent(n)

  @::s_block_line_prefix.num = 68
  s_block_line_prefix: (n)->
    debug1("s_block_line_prefix",n)
    [ @s_indent, n ]



  # [069]
  # s-flow-line-prefix(n) ::=
  #   s-indent(n)
  #   s-separate-in-line?

  @::s_flow_line_prefix.num = 69
  s_flow_line_prefix: (n)->
    debug1("s_flow_line_prefix",n)
    @all(
      [ @s_indent, n ],
      @rep(0, 1, @s_separate_in_line),
    )



  # [070]
  # l-empty(n,c) ::=
  #   ( s-line-prefix(n,c) | s-indent(<n) )
  #   b-as-line-feed

  @::l_empty.num = 70
  l_empty: (n, c)->
    debug1("l_empty",n,c)
    @all(
      @any(
        [ @s_line_prefix, n, c ],
        [ @s_indent_lt, n ],
      ),
      @b_as_line_feed,
    )



  # [071]
  # b-l-trimmed(n,c) ::=
  #   b-non-content l-empty(n,c)+

  @::b_l_trimmed.num = 71
  b_l_trimmed: (n, c)->
    debug1("b_l_trimmed",n,c)
    @all(
      @b_non_content,
      @rep(1, 0, [ @l_empty, n, c ]),
    )



  # [072]
  # b-as-space ::=
  #   b-break

  @::b_as_space.num = 72
  b_as_space: ->
    debug1("b_as_space")
    @b_break



  # [073]
  # b-l-folded(n,c) ::=
  #   b-l-trimmed(n,c) | b-as-space

  @::b_l_folded.num = 73
  b_l_folded: (n, c)->
    debug1("b_l_folded",n,c)
    @any(
      [ @b_l_trimmed, n, c ],
      @b_as_space,
    )



  # [074]
  # s-flow-folded(n) ::=
  #   s-separate-in-line?
  #   b-l-folded(n,flow-in)
  #   s-flow-line-prefix(n)

  @::s_flow_folded.num = 74
  s_flow_folded: (n)->
    debug1("s_flow_folded",n)
    @all(
      @rep(0, 1, @s_separate_in_line),
      [ @b_l_folded, n, "flow-in" ],
      [ @s_flow_line_prefix, n ],
    )



  # [075]
  # c-nb-comment-text ::=
  #   '#' nb-char*

  @::c_nb_comment_text.num = 75
  c_nb_comment_text: ->
    debug1("c_nb_comment_text")
    @all(
      @chr('#'),
      @rep(0, 0, @nb_char),
    )



  # [076]
  # b-comment ::=
  #   b-non-content | <end_of_file>

  @::b_comment.num = 76
  b_comment: ->
    debug1("b_comment")
    @any(
      @b_non_content,
      @end_of_stream,
    )



  # [077]
  # s-b-comment ::=
  #   ( s-separate-in-line
  #   c-nb-comment-text? )?
  #   b-comment

  @::s_b_comment.num = 77
  s_b_comment: ->
    debug1("s_b_comment")
    @all(
      @rep(0, 1,
        @all(
          @s_separate_in_line,
          @rep(0, 1, @c_nb_comment_text),
        )),
      @b_comment,
    )



  # [078]
  # l-comment ::=
  #   s-separate-in-line c-nb-comment-text?
  #   b-comment

  @::l_comment.num = 78
  l_comment: ->
    debug1("l_comment")
    @all(
      @s_separate_in_line,
      @rep(0, 1, @c_nb_comment_text),
      @b_comment,
    )



  # [079]
  # s-l-comments ::=
  #   ( s-b-comment | <start_of_line> )
  #   l-comment*

  @::s_l_comments.num = 79
  s_l_comments: ->
    debug1("s_l_comments")
    @all(
      @any(
        @s_b_comment,
        @start_of_line,
      ),
      @rep(0, 0, @l_comment),
    )



  # [080]
  # s-separate(n,c) ::=
  #   ( c = block-out => s-separate-lines(n) )
  #   ( c = block-in => s-separate-lines(n) )
  #   ( c = flow-out => s-separate-lines(n) )
  #   ( c = flow-in => s-separate-lines(n) )
  #   ( c = block-key => s-separate-in-line )
  #   ( c = flow-key => s-separate-in-line )

  @::s_separate.num = 80
  s_separate: (n, c)->
    debug1("s_separate",n,c)
    @case(c, {
      'block-in': [ @s_separate_lines, n ],
      'block-key': @s_separate_in_line,
      'block-out': [ @s_separate_lines, n ],
      'flow-in': [ @s_separate_lines, n ],
      'flow-key': @s_separate_in_line,
      'flow-out': [ @s_separate_lines, n ],
    })



  # [081]
  # s-separate-lines(n) ::=
  #   ( s-l-comments
  #   s-flow-line-prefix(n) )
  #   | s-separate-in-line

  @::s_separate_lines.num = 81
  s_separate_lines: (n)->
    debug1("s_separate_lines",n)
    @any(
      @all(
        @s_l_comments,
        [ @s_flow_line_prefix, n ],
      ),
      @s_separate_in_line,
    )



  # [082]
  # l-directive ::=
  #   '%'
  #   ( ns-yaml-directive
  #   | ns-tag-directive
  #   | ns-reserved-directive )
  #   s-l-comments

  @::l_directive.num = 82
  l_directive: ->
    debug1("l_directive")
    @all(
      @chr('%'),
      @any(
        @ns_yaml_directive,
        @ns_tag_directive,
        @ns_reserved_directive,
      ),
      @s_l_comments,
    )



  # [083]
  # ns-reserved-directive ::=
  #   ns-directive-name
  #   ( s-separate-in-line ns-directive-parameter )*

  @::ns_reserved_directive.num = 83
  ns_reserved_directive: ->
    debug1("ns_reserved_directive")
    @all(
      @ns_directive_name,
      @rep(0, 0,
        @all(
          @s_separate_in_line,
          @ns_directive_parameter,
        )),
    )



  # [084]
  # ns-directive-name ::=
  #   ns-char+

  @::ns_directive_name.num = 84
  ns_directive_name: ->
    debug1("ns_directive_name")
    @rep(1, 0, @ns_char)



  # [085]
  # ns-directive-parameter ::=
  #   ns-char+

  @::ns_directive_parameter.num = 85
  ns_directive_parameter: ->
    debug1("ns_directive_parameter")
    @rep(1, 0, @ns_char)



  # [086]
  # ns-yaml-directive ::=
  #   'Y' 'A' 'M' 'L'
  #   s-separate-in-line ns-yaml-version

  @::ns_yaml_directive.num = 86
  ns_yaml_directive: ->
    debug1("ns_yaml_directive")
    @all(
      @chr('Y'),
      @chr('A'),
      @chr('M'),
      @chr('L'),
      @s_separate_in_line,
      @ns_yaml_version,
    )



  # [087]
  # ns-yaml-version ::=
  #   ns-dec-digit+ '.' ns-dec-digit+

  @::ns_yaml_version.num = 87
  ns_yaml_version: ->
    debug1("ns_yaml_version")
    @all(
      @rep(1, 0, @ns_dec_digit),
      @chr('.'),
      @rep(1, 0, @ns_dec_digit),
    )



  # [088]
  # ns-tag-directive ::=
  #   'T' 'A' 'G'
  #   s-separate-in-line c-tag-handle
  #   s-separate-in-line ns-tag-prefix

  @::ns_tag_directive.num = 88
  ns_tag_directive: ->
    debug1("ns_tag_directive")
    @all(
      @chr('T'),
      @chr('A'),
      @chr('G'),
      @s_separate_in_line,
      @c_tag_handle,
      @s_separate_in_line,
      @ns_tag_prefix,
    )



  # [089]
  # c-tag-handle ::=
  #   c-named-tag-handle
  #   | c-secondary-tag-handle
  #   | c-primary-tag-handle

  @::c_tag_handle.num = 89
  c_tag_handle: ->
    debug1("c_tag_handle")
    @any(
      @c_named_tag_handle,
      @c_secondary_tag_handle,
      @c_primary_tag_handle,
    )



  # [090]
  # c-primary-tag-handle ::=
  #   '!'

  @::c_primary_tag_handle.num = 90
  c_primary_tag_handle: ->
    debug1("c_primary_tag_handle")
    @chr('!')



  # [091]
  # c-secondary-tag-handle ::=
  #   '!' '!'

  @::c_secondary_tag_handle.num = 91
  c_secondary_tag_handle: ->
    debug1("c_secondary_tag_handle")
    @all(
      @chr('!'),
      @chr('!'),
    )



  # [092]
  # c-named-tag-handle ::=
  #   '!' ns-word-char+ '!'

  @::c_named_tag_handle.num = 92
  c_named_tag_handle: ->
    debug1("c_named_tag_handle")
    @all(
      @chr('!'),
      @rep(1, 0, @ns_word_char),
      @chr('!'),
    )



  # [093]
  # ns-tag-prefix ::=
  #   c-ns-local-tag-prefix | ns-global-tag-prefix

  @::ns_tag_prefix.num = 93
  ns_tag_prefix: ->
    debug1("ns_tag_prefix")
    @any(
      @c_ns_local_tag_prefix,
      @ns_global_tag_prefix,
    )



  # [094]
  # c-ns-local-tag-prefix ::=
  #   '!' ns-uri-char*

  @::c_ns_local_tag_prefix.num = 94
  c_ns_local_tag_prefix: ->
    debug1("c_ns_local_tag_prefix")
    @all(
      @chr('!'),
      @rep(0, 0, @ns_uri_char),
    )



  # [095]
  # ns-global-tag-prefix ::=
  #   ns-tag-char ns-uri-char*

  @::ns_global_tag_prefix.num = 95
  ns_global_tag_prefix: ->
    debug1("ns_global_tag_prefix")
    @all(
      @ns_tag_char,
      @rep(0, 0, @ns_uri_char),
    )



  # [096]
  # c-ns-properties(n,c) ::=
  #   ( c-ns-tag-property
  #   ( s-separate(n,c) c-ns-anchor-property )? )
  #   | ( c-ns-anchor-property
  #   ( s-separate(n,c) c-ns-tag-property )? )

  @::c_ns_properties.num = 96
  c_ns_properties: (n, c)->
    debug1("c_ns_properties",n,c)
    @any(
      @all(
        @c_ns_tag_property,
        @rep(0, 1,
          @all(
            [ @s_separate, n, c ],
            @c_ns_anchor_property,
          )),
      ),
      @all(
        @c_ns_anchor_property,
        @rep(0, 1,
          @all(
            [ @s_separate, n, c ],
            @c_ns_tag_property,
          )),
      ),
    )



  # [097]
  # c-ns-tag-property ::=
  #   c-verbatim-tag
  #   | c-ns-shorthand-tag
  #   | c-non-specific-tag

  @::c_ns_tag_property.num = 97
  c_ns_tag_property: ->
    debug1("c_ns_tag_property")
    @any(
      @c_verbatim_tag,
      @c_ns_shorthand_tag,
      @c_non_specific_tag,
    )



  # [098]
  # c-verbatim-tag ::=
  #   '!' '<' ns-uri-char+ '>'

  @::c_verbatim_tag.num = 98
  c_verbatim_tag: ->
    debug1("c_verbatim_tag")
    @all(
      @chr('!'),
      @chr('<'),
      @rep(1, 0, @ns_uri_char),
      @chr('>'),
    )



  # [099]
  # c-ns-shorthand-tag ::=
  #   c-tag-handle ns-tag-char+

  @::c_ns_shorthand_tag.num = 99
  c_ns_shorthand_tag: ->
    debug1("c_ns_shorthand_tag")
    @all(
      @c_tag_handle,
      @rep(1, 0, @ns_tag_char),
    )



  # [100]
  # c-non-specific-tag ::=
  #   '!'

  @::c_non_specific_tag.num = 100
  c_non_specific_tag: ->
    debug1("c_non_specific_tag")
    @chr('!')



  # [101]
  # c-ns-anchor-property ::=
  #   '&' ns-anchor-name

  @::c_ns_anchor_property.num = 101
  c_ns_anchor_property: ->
    debug1("c_ns_anchor_property")
    @all(
      @chr('&'),
      @ns_anchor_name,
    )



  # [102]
  # ns-anchor-char ::=
  #   ns-char - c-flow-indicator

  @::ns_anchor_char.num = 102
  ns_anchor_char: ->
    debug1("ns_anchor_char")
    @but(
      @ns_char,
      @c_flow_indicator,
    )



  # [103]
  # ns-anchor-name ::=
  #   ns-anchor-char+

  @::ns_anchor_name.num = 103
  ns_anchor_name: ->
    debug1("ns_anchor_name")
    @rep(1, 0, @ns_anchor_char)



  # [104]
  # c-ns-alias-node ::=
  #   '*' ns-anchor-name

  @::c_ns_alias_node.num = 104
  c_ns_alias_node: ->
    debug1("c_ns_alias_node")
    @all(
      @chr('*'),
      @ns_anchor_name,
    )



  # [105]
  # e-scalar ::=
  #   <empty>

  @::e_scalar.num = 105
  e_scalar: ->
    debug1("e_scalar")
    @empty



  # [106]
  # e-node ::=
  #   e-scalar

  @::e_node.num = 106
  e_node: ->
    debug1("e_node")
    @e_scalar



  # [107]
  # nb-double-char ::=
  #   c-ns-esc-char | ( nb-json - '\' - '"' )

  @::nb_double_char.num = 107
  nb_double_char: ->
    debug1("nb_double_char")
    @any(
      @c_ns_esc_char,
      @but(
        @nb_json,
        @chr("\\"),
        @chr('"'),
      ),
    )



  # [108]
  # ns-double-char ::=
  #   nb-double-char - s-white

  @::ns_double_char.num = 108
  ns_double_char: ->
    debug1("ns_double_char")
    @but(
      @nb_double_char,
      @s_white,
    )



  # [109]
  # c-double-quoted(n,c) ::=
  #   '"' nb-double-text(n,c)
  #   '"'

  @::c_double_quoted.num = 109
  c_double_quoted: (n, c)->
    debug1("c_double_quoted",n,c)
    @all(
      @chr('"'),
      [ @nb_double_text, n, c ],
      @chr('"'),
    )



  # [110]
  # nb-double-text(n,c) ::=
  #   ( c = flow-out => nb-double-multi-line(n) )
  #   ( c = flow-in => nb-double-multi-line(n) )
  #   ( c = block-key => nb-double-one-line )
  #   ( c = flow-key => nb-double-one-line )

  @::nb_double_text.num = 110
  nb_double_text: (n, c)->
    debug1("nb_double_text",n,c)
    @case(c, {
      'block-key': @nb_double_one_line,
      'flow-in': [ @nb_double_multi_line, n ],
      'flow-key': @nb_double_one_line,
      'flow-out': [ @nb_double_multi_line, n ],
    })



  # [111]
  # nb-double-one-line ::=
  #   nb-double-char*

  @::nb_double_one_line.num = 111
  nb_double_one_line: ->
    debug1("nb_double_one_line")
    @rep(0, 0, @nb_double_char)



  # [112]
  # s-double-escaped(n) ::=
  #   s-white* '\'
  #   b-non-content
  #   l-empty(n,flow-in)* s-flow-line-prefix(n)

  @::s_double_escaped.num = 112
  s_double_escaped: (n)->
    debug1("s_double_escaped",n)
    @all(
      @rep(0, 0, @s_white),
      @chr("\\"),
      @b_non_content,
      @rep(0, 0, [ @l_empty, n, "flow-in" ]),
      [ @s_flow_line_prefix, n ],
    )



  # [113]
  # s-double-break(n) ::=
  #   s-double-escaped(n) | s-flow-folded(n)

  @::s_double_break.num = 113
  s_double_break: (n)->
    debug1("s_double_break",n)
    @any(
      [ @s_double_escaped, n ],
      [ @s_flow_folded, n ],
    )



  # [114]
  # nb-ns-double-in-line ::=
  #   ( s-white* ns-double-char )*

  @::nb_ns_double_in_line.num = 114
  nb_ns_double_in_line: ->
    debug1("nb_ns_double_in_line")
    @rep(0, 0,
      @all(
        @rep(0, 0, @s_white),
        @ns_double_char,
      ))



  # [115]
  # s-double-next-line(n) ::=
  #   s-double-break(n)
  #   ( ns-double-char nb-ns-double-in-line
  #   ( s-double-next-line(n) | s-white* ) )?

  @::s_double_next_line.num = 115
  s_double_next_line: (n)->
    debug1("s_double_next_line",n)
    @all(
      [ @s_double_break, n ],
      @rep(0, 1,
        @all(
          @ns_double_char,
          @nb_ns_double_in_line,
          @any(
            [ @s_double_next_line, n ],
            @rep(0, 0, @s_white),
          ),
        )),
    )



  # [116]
  # nb-double-multi-line(n) ::=
  #   nb-ns-double-in-line
  #   ( s-double-next-line(n) | s-white* )

  @::nb_double_multi_line.num = 116
  nb_double_multi_line: (n)->
    debug1("nb_double_multi_line",n)
    @all(
      @nb_ns_double_in_line,
      @any(
        [ @s_double_next_line, n ],
        @rep(0, 0, @s_white),
      ),
    )



  # [117]
  # c-quoted-quote ::=
  #   ''' '''

  @::c_quoted_quote.num = 117
  c_quoted_quote: ->
    debug1("c_quoted_quote")
    @all(
      @chr("'"),
      @chr("'"),
    )



  # [118]
  # nb-single-char ::=
  #   c-quoted-quote | ( nb-json - ''' )

  @::nb_single_char.num = 118
  nb_single_char: ->
    debug1("nb_single_char")
    @any(
      @c_quoted_quote,
      @but(
        @nb_json,
        @chr("'"),
      ),
    )



  # [119]
  # ns-single-char ::=
  #   nb-single-char - s-white

  @::ns_single_char.num = 119
  ns_single_char: ->
    debug1("ns_single_char")
    @but(
      @nb_single_char,
      @s_white,
    )



  # [120]
  # c-single-quoted(n,c) ::=
  #   ''' nb-single-text(n,c)
  #   '''

  @::c_single_quoted.num = 120
  c_single_quoted: (n, c)->
    debug1("c_single_quoted",n,c)
    @all(
      @chr("'"),
      [ @nb_single_text, n, c ],
      @chr("'"),
    )



  # [121]
  # nb-single-text(n,c) ::=
  #   ( c = flow-out => nb-single-multi-line(n) )
  #   ( c = flow-in => nb-single-multi-line(n) )
  #   ( c = block-key => nb-single-one-line )
  #   ( c = flow-key => nb-single-one-line )

  @::nb_single_text.num = 121
  nb_single_text: (n, c)->
    debug1("nb_single_text",n,c)
    @case(c, {
      'block-key': @nb_single_one_line,
      'flow-in': [ @nb_single_multi_line, n ],
      'flow-key': @nb_single_one_line,
      'flow-out': [ @nb_single_multi_line, n ],
    })



  # [122]
  # nb-single-one-line ::=
  #   nb-single-char*

  @::nb_single_one_line.num = 122
  nb_single_one_line: ->
    debug1("nb_single_one_line")
    @rep(0, 0, @nb_single_char)



  # [123]
  # nb-ns-single-in-line ::=
  #   ( s-white* ns-single-char )*

  @::nb_ns_single_in_line.num = 123
  nb_ns_single_in_line: ->
    debug1("nb_ns_single_in_line")
    @rep(0, 0,
      @all(
        @rep(0, 0, @s_white),
        @ns_single_char,
      ))



  # [124]
  # s-single-next-line(n) ::=
  #   s-flow-folded(n)
  #   ( ns-single-char nb-ns-single-in-line
  #   ( s-single-next-line(n) | s-white* ) )?

  @::s_single_next_line.num = 124
  s_single_next_line: (n)->
    debug1("s_single_next_line",n)
    @all(
      [ @s_flow_folded, n ],
      @rep(0, 1,
        @all(
          @ns_single_char,
          @nb_ns_single_in_line,
          @any(
            [ @s_single_next_line, n ],
            @rep(0, 0, @s_white),
          ),
        )),
    )



  # [125]
  # nb-single-multi-line(n) ::=
  #   nb-ns-single-in-line
  #   ( s-single-next-line(n) | s-white* )

  @::nb_single_multi_line.num = 125
  nb_single_multi_line: (n)->
    debug1("nb_single_multi_line",n)
    @all(
      @nb_ns_single_in_line,
      @any(
        [ @s_single_next_line, n ],
        @rep(0, 0, @s_white),
      ),
    )



  # [126]
  # ns-plain-first(c) ::=
  #   ( ns-char - c-indicator )
  #   | ( ( '?' | ':' | '-' )
  #   <followed_by_an_ns-plain-safe(c)> )

  @::ns_plain_first.num = 126
  ns_plain_first: (c)->
    debug1("ns_plain_first",c)
    @any(
      @but(
        @ns_char,
        @c_indicator,
      ),
      @all(
        @any(
          @chr('?'),
          @chr(':'),
          @chr('-'),
        ),
        @chk('=', [ @ns_plain_safe, c ]),
      ),
    )



  # [127]
  # ns-plain-safe(c) ::=
  #   ( c = flow-out => ns-plain-safe-out )
  #   ( c = flow-in => ns-plain-safe-in )
  #   ( c = block-key => ns-plain-safe-out )
  #   ( c = flow-key => ns-plain-safe-in )

  @::ns_plain_safe.num = 127
  ns_plain_safe: (c)->
    debug1("ns_plain_safe",c)
    @case(c, {
      'block-key': @ns_plain_safe_out,
      'flow-in': @ns_plain_safe_in,
      'flow-key': @ns_plain_safe_in,
      'flow-out': @ns_plain_safe_out,
    })



  # [128]
  # ns-plain-safe-out ::=
  #   ns-char

  @::ns_plain_safe_out.num = 128
  ns_plain_safe_out: ->
    debug1("ns_plain_safe_out")
    @ns_char



  # [129]
  # ns-plain-safe-in ::=
  #   ns-char - c-flow-indicator

  @::ns_plain_safe_in.num = 129
  ns_plain_safe_in: ->
    debug1("ns_plain_safe_in")
    @but(
      @ns_char,
      @c_flow_indicator,
    )



  # [130]
  # ns-plain-char(c) ::=
  #   ( ns-plain-safe(c) - ':' - '#' )
  #   | ( <an_ns-char_preceding> '#' )
  #   | ( ':' <followed_by_an_ns-plain-safe(c)> )

  @::ns_plain_char.num = 130
  ns_plain_char: (c)->
    debug1("ns_plain_char",c)
    @any(
      @but(
        [ @ns_plain_safe, c ],
        @chr(':'),
        @chr('#'),
      ),
      @all(
        @chk('<=', @ns_char),
        @chr('#'),
      ),
      @all(
        @chr(':'),
        @chk('=', [ @ns_plain_safe, c ]),
      ),
    )



  # [131]
  # ns-plain(n,c) ::=
  #   ( c = flow-out => ns-plain-multi-line(n,c) )
  #   ( c = flow-in => ns-plain-multi-line(n,c) )
  #   ( c = block-key => ns-plain-one-line(c) )
  #   ( c = flow-key => ns-plain-one-line(c) )

  @::ns_plain.num = 131
  ns_plain: (n, c)->
    debug1("ns_plain",n,c)
    @case(c, {
      'block-key': [ @ns_plain_one_line, c ],
      'flow-in': [ @ns_plain_multi_line, n, c ],
      'flow-key': [ @ns_plain_one_line, c ],
      'flow-out': [ @ns_plain_multi_line, n, c ],
    })



  # [132]
  # nb-ns-plain-in-line(c) ::=
  #   ( s-white*
  #   ns-plain-char(c) )*

  @::nb_ns_plain_in_line.num = 132
  nb_ns_plain_in_line: (c)->
    debug1("nb_ns_plain_in_line",c)
    @rep(0, 0,
      @all(
        @rep(0, 0, @s_white),
        [ @ns_plain_char, c ],
      ))



  # [133]
  # ns-plain-one-line(c) ::=
  #   ns-plain-first(c)
  #   nb-ns-plain-in-line(c)

  @::ns_plain_one_line.num = 133
  ns_plain_one_line: (c)->
    debug1("ns_plain_one_line",c)
    @all(
      [ @ns_plain_first, c ],
      [ @nb_ns_plain_in_line, c ],
    )



  # [134]
  # s-ns-plain-next-line(n,c) ::=
  #   s-flow-folded(n)
  #   ns-plain-char(c) nb-ns-plain-in-line(c)

  @::s_ns_plain_next_line.num = 134
  s_ns_plain_next_line: (n, c)->
    debug1("s_ns_plain_next_line",n,c)
    @all(
      [ @s_flow_folded, n ],
      [ @ns_plain_char, c ],
      [ @nb_ns_plain_in_line, c ],
    )



  # [135]
  # ns-plain-multi-line(n,c) ::=
  #   ns-plain-one-line(c)
  #   s-ns-plain-next-line(n,c)*

  @::ns_plain_multi_line.num = 135
  ns_plain_multi_line: (n, c)->
    debug1("ns_plain_multi_line",n,c)
    @all(
      [ @ns_plain_one_line, c ],
      @rep(0, 0, [ @s_ns_plain_next_line, n, c ]),
    )



  # [136]
  # in-flow(c) ::=
  #   ( c = flow-out => flow-in )
  #   ( c = flow-in => flow-in )
  #   ( c = block-key => flow-key )
  #   ( c = flow-key => flow-key )

  @::in_flow.num = 136
  in_flow: (c)->
    debug1("in_flow",c)
    @flip(c, {
      'block-key': "flow-key",
      'flow-in': "flow-in",
      'flow-key': "flow-key",
      'flow-out': "flow-in",
    })



  # [137]
  # c-flow-sequence(n,c) ::=
  #   '[' s-separate(n,c)?
  #   ns-s-flow-seq-entries(n,in-flow(c))? ']'

  @::c_flow_sequence.num = 137
  c_flow_sequence: (n, c)->
    debug1("c_flow_sequence",n,c)
    @all(
      @chr('['),
      @rep(0, 1, [ @s_separate, n, c ]),
      @rep(0, 1, [ @ns_s_flow_seq_entries, n, [ @in_flow, c ] ]),
      @chr(']'),
    )



  # [138]
  # ns-s-flow-seq-entries(n,c) ::=
  #   ns-flow-seq-entry(n,c)
  #   s-separate(n,c)?
  #   ( ',' s-separate(n,c)?
  #   ns-s-flow-seq-entries(n,c)? )?

  @::ns_s_flow_seq_entries.num = 138
  ns_s_flow_seq_entries: (n, c)->
    debug1("ns_s_flow_seq_entries",n,c)
    @all(
      [ @ns_flow_seq_entry, n, c ],
      @rep(0, 1, [ @s_separate, n, c ]),
      @rep(0, 1,
        @all(
          @chr(','),
          @rep(0, 1, [ @s_separate, n, c ]),
          @rep(0, 1, [ @ns_s_flow_seq_entries, n, c ]),
        )),
    )



  # [139]
  # ns-flow-seq-entry(n,c) ::=
  #   ns-flow-pair(n,c) | ns-flow-node(n,c)

  @::ns_flow_seq_entry.num = 139
  ns_flow_seq_entry: (n, c)->
    debug1("ns_flow_seq_entry",n,c)
    @any(
      [ @ns_flow_pair, n, c ],
      [ @ns_flow_node, n, c ],
    )



  # [140]
  # c-flow-mapping(n,c) ::=
  #   '{' s-separate(n,c)?
  #   ns-s-flow-map-entries(n,in-flow(c))? '}'

  @::c_flow_mapping.num = 140
  c_flow_mapping: (n, c)->
    debug1("c_flow_mapping",n,c)
    @all(
      @chr('{'),
      @rep(0, 1, [ @s_separate, n, c ]),
      @rep(0, 1, [ @ns_s_flow_map_entries, n, [ @in_flow, c ] ]),
      @chr('}'),
    )



  # [141]
  # ns-s-flow-map-entries(n,c) ::=
  #   ns-flow-map-entry(n,c)
  #   s-separate(n,c)?
  #   ( ',' s-separate(n,c)?
  #   ns-s-flow-map-entries(n,c)? )?

  @::ns_s_flow_map_entries.num = 141
  ns_s_flow_map_entries: (n, c)->
    debug1("ns_s_flow_map_entries",n,c)
    @all(
      [ @ns_flow_map_entry, n, c ],
      @rep(0, 1, [ @s_separate, n, c ]),
      @rep(0, 1,
        @all(
          @chr(','),
          @rep(0, 1, [ @s_separate, n, c ]),
          @rep(0, 1, [ @ns_s_flow_map_entries, n, c ]),
        )),
    )



  # [142]
  # ns-flow-map-entry(n,c) ::=
  #   ( '?' s-separate(n,c)
  #   ns-flow-map-explicit-entry(n,c) )
  #   | ns-flow-map-implicit-entry(n,c)

  @::ns_flow_map_entry.num = 142
  ns_flow_map_entry: (n, c)->
    debug1("ns_flow_map_entry",n,c)
    @any(
      @all(
        @chr('?'),
        [ @s_separate, n, c ],
        [ @ns_flow_map_explicit_entry, n, c ],
      ),
      [ @ns_flow_map_implicit_entry, n, c ],
    )



  # [143]
  # ns-flow-map-explicit-entry(n,c) ::=
  #   ns-flow-map-implicit-entry(n,c)
  #   | ( e-node
  #   e-node )

  @::ns_flow_map_explicit_entry.num = 143
  ns_flow_map_explicit_entry: (n, c)->
    debug1("ns_flow_map_explicit_entry",n,c)
    @any(
      [ @ns_flow_map_implicit_entry, n, c ],
      @all(
        @e_node,
        @e_node,
      ),
    )



  # [144]
  # ns-flow-map-implicit-entry(n,c) ::=
  #   ns-flow-map-yaml-key-entry(n,c)
  #   | c-ns-flow-map-empty-key-entry(n,c)
  #   | c-ns-flow-map-json-key-entry(n,c)

  @::ns_flow_map_implicit_entry.num = 144
  ns_flow_map_implicit_entry: (n, c)->
    debug1("ns_flow_map_implicit_entry",n,c)
    @any(
      [ @ns_flow_map_yaml_key_entry, n, c ],
      [ @c_ns_flow_map_empty_key_entry, n, c ],
      [ @c_ns_flow_map_json_key_entry, n, c ],
    )



  # [145]
  # ns-flow-map-yaml-key-entry(n,c) ::=
  #   ns-flow-yaml-node(n,c)
  #   ( ( s-separate(n,c)?
  #   c-ns-flow-map-separate-value(n,c) )
  #   | e-node )

  @::ns_flow_map_yaml_key_entry.num = 145
  ns_flow_map_yaml_key_entry: (n, c)->
    debug1("ns_flow_map_yaml_key_entry",n,c)
    @all(
      [ @ns_flow_yaml_node, n, c ],
      @any(
        @all(
          @rep(0, 1, [ @s_separate, n, c ]),
          [ @c_ns_flow_map_separate_value, n, c ],
        ),
        @e_node,
      ),
    )



  # [146]
  # c-ns-flow-map-empty-key-entry(n,c) ::=
  #   e-node
  #   c-ns-flow-map-separate-value(n,c)

  @::c_ns_flow_map_empty_key_entry.num = 146
  c_ns_flow_map_empty_key_entry: (n, c)->
    debug1("c_ns_flow_map_empty_key_entry",n,c)
    @all(
      @e_node,
      [ @c_ns_flow_map_separate_value, n, c ],
    )



  # [147]
  # c-ns-flow-map-separate-value(n,c) ::=
  #   ':' <not_followed_by_an_ns-plain-safe(c)>
  #   ( ( s-separate(n,c) ns-flow-node(n,c) )
  #   | e-node )

  @::c_ns_flow_map_separate_value.num = 147
  c_ns_flow_map_separate_value: (n, c)->
    debug1("c_ns_flow_map_separate_value",n,c)
    @all(
      @chr(':'),
      @chk('!', [ @ns_plain_safe, c ]),
      @any(
        @all(
          [ @s_separate, n, c ],
          [ @ns_flow_node, n, c ],
        ),
        @e_node,
      ),
    )



  # [148]
  # c-ns-flow-map-json-key-entry(n,c) ::=
  #   c-flow-json-node(n,c)
  #   ( ( s-separate(n,c)?
  #   c-ns-flow-map-adjacent-value(n,c) )
  #   | e-node )

  @::c_ns_flow_map_json_key_entry.num = 148
  c_ns_flow_map_json_key_entry: (n, c)->
    debug1("c_ns_flow_map_json_key_entry",n,c)
    @all(
      [ @c_flow_json_node, n, c ],
      @any(
        @all(
          @rep(0, 1, [ @s_separate, n, c ]),
          [ @c_ns_flow_map_adjacent_value, n, c ],
        ),
        @e_node,
      ),
    )



  # [149]
  # c-ns-flow-map-adjacent-value(n,c) ::=
  #   ':' ( (
  #   s-separate(n,c)?
  #   ns-flow-node(n,c) )
  #   | e-node )

  @::c_ns_flow_map_adjacent_value.num = 149
  c_ns_flow_map_adjacent_value: (n, c)->
    debug1("c_ns_flow_map_adjacent_value",n,c)
    @all(
      @chr(':'),
      @any(
        @all(
          @rep(0, 1, [ @s_separate, n, c ]),
          [ @ns_flow_node, n, c ],
        ),
        @e_node,
      ),
    )



  # [150]
  # ns-flow-pair(n,c) ::=
  #   ( '?' s-separate(n,c)
  #   ns-flow-map-explicit-entry(n,c) )
  #   | ns-flow-pair-entry(n,c)

  @::ns_flow_pair.num = 150
  ns_flow_pair: (n, c)->
    debug1("ns_flow_pair",n,c)
    @any(
      @all(
        @chr('?'),
        [ @s_separate, n, c ],
        [ @ns_flow_map_explicit_entry, n, c ],
      ),
      [ @ns_flow_pair_entry, n, c ],
    )



  # [151]
  # ns-flow-pair-entry(n,c) ::=
  #   ns-flow-pair-yaml-key-entry(n,c)
  #   | c-ns-flow-map-empty-key-entry(n,c)
  #   | c-ns-flow-pair-json-key-entry(n,c)

  @::ns_flow_pair_entry.num = 151
  ns_flow_pair_entry: (n, c)->
    debug1("ns_flow_pair_entry",n,c)
    @any(
      [ @ns_flow_pair_yaml_key_entry, n, c ],
      [ @c_ns_flow_map_empty_key_entry, n, c ],
      [ @c_ns_flow_pair_json_key_entry, n, c ],
    )



  # [152]
  # ns-flow-pair-yaml-key-entry(n,c) ::=
  #   ns-s-implicit-yaml-key(flow-key)
  #   c-ns-flow-map-separate-value(n,c)

  @::ns_flow_pair_yaml_key_entry.num = 152
  ns_flow_pair_yaml_key_entry: (n, c)->
    debug1("ns_flow_pair_yaml_key_entry",n,c)
    @all(
      [ @ns_s_implicit_yaml_key, "flow-key" ],
      [ @c_ns_flow_map_separate_value, n, c ],
    )



  # [153]
  # c-ns-flow-pair-json-key-entry(n,c) ::=
  #   c-s-implicit-json-key(flow-key)
  #   c-ns-flow-map-adjacent-value(n,c)

  @::c_ns_flow_pair_json_key_entry.num = 153
  c_ns_flow_pair_json_key_entry: (n, c)->
    debug1("c_ns_flow_pair_json_key_entry",n,c)
    @all(
      [ @c_s_implicit_json_key, "flow-key" ],
      [ @c_ns_flow_map_adjacent_value, n, c ],
    )



  # [154]
  # ns-s-implicit-yaml-key(c) ::=
  #   ns-flow-yaml-node(n/a,c)
  #   s-separate-in-line?
  #   <at_most_1024_characters_altogether>

  @::ns_s_implicit_yaml_key.num = 154
  ns_s_implicit_yaml_key: (c)->
    debug1("ns_s_implicit_yaml_key",c)
    @all(
      @max(1024),
      [ @ns_flow_yaml_node, null, c ],
      @rep(0, 1, @s_separate_in_line),
    )



  # [155]
  # c-s-implicit-json-key(c) ::=
  #   c-flow-json-node(n/a,c)
  #   s-separate-in-line?
  #   <at_most_1024_characters_altogether>

  @::c_s_implicit_json_key.num = 155
  c_s_implicit_json_key: (c)->
    debug1("c_s_implicit_json_key",c)
    @all(
      @max(1024),
      [ @c_flow_json_node, null, c ],
      @rep(0, 1, @s_separate_in_line),
    )



  # [156]
  # ns-flow-yaml-content(n,c) ::=
  #   ns-plain(n,c)

  @::ns_flow_yaml_content.num = 156
  ns_flow_yaml_content: (n, c)->
    debug1("ns_flow_yaml_content",n,c)
    [ @ns_plain, n, c ]



  # [157]
  # c-flow-json-content(n,c) ::=
  #   c-flow-sequence(n,c) | c-flow-mapping(n,c)
  #   | c-single-quoted(n,c) | c-double-quoted(n,c)

  @::c_flow_json_content.num = 157
  c_flow_json_content: (n, c)->
    debug1("c_flow_json_content",n,c)
    @any(
      [ @c_flow_sequence, n, c ],
      [ @c_flow_mapping, n, c ],
      [ @c_single_quoted, n, c ],
      [ @c_double_quoted, n, c ],
    )



  # [158]
  # ns-flow-content(n,c) ::=
  #   ns-flow-yaml-content(n,c) | c-flow-json-content(n,c)

  @::ns_flow_content.num = 158
  ns_flow_content: (n, c)->
    debug1("ns_flow_content",n,c)
    @any(
      [ @ns_flow_yaml_content, n, c ],
      [ @c_flow_json_content, n, c ],
    )



  # [159]
  # ns-flow-yaml-node(n,c) ::=
  #   c-ns-alias-node
  #   | ns-flow-yaml-content(n,c)
  #   | ( c-ns-properties(n,c)
  #   ( ( s-separate(n,c)
  #   ns-flow-yaml-content(n,c) )
  #   | e-scalar ) )

  @::ns_flow_yaml_node.num = 159
  ns_flow_yaml_node: (n, c)->
    debug1("ns_flow_yaml_node",n,c)
    @any(
      @c_ns_alias_node,
      [ @ns_flow_yaml_content, n, c ],
      @all(
        [ @c_ns_properties, n, c ],
        @any(
          @all(
            [ @s_separate, n, c ],
            [ @ns_flow_yaml_content, n, c ],
          ),
          @e_scalar,
        ),
      ),
    )



  # [160]
  # c-flow-json-node(n,c) ::=
  #   ( c-ns-properties(n,c)
  #   s-separate(n,c) )?
  #   c-flow-json-content(n,c)

  @::c_flow_json_node.num = 160
  c_flow_json_node: (n, c)->
    debug1("c_flow_json_node",n,c)
    @all(
      @rep(0, 1,
        @all(
          [ @c_ns_properties, n, c ],
          [ @s_separate, n, c ],
        )),
      [ @c_flow_json_content, n, c ],
    )



  # [161]
  # ns-flow-node(n,c) ::=
  #   c-ns-alias-node
  #   | ns-flow-content(n,c)
  #   | ( c-ns-properties(n,c)
  #   ( ( s-separate(n,c)
  #   ns-flow-content(n,c) )
  #   | e-scalar ) )

  @::ns_flow_node.num = 161
  ns_flow_node: (n, c)->
    debug1("ns_flow_node",n,c)
    @any(
      @c_ns_alias_node,
      [ @ns_flow_content, n, c ],
      @all(
        [ @c_ns_properties, n, c ],
        @any(
          @all(
            [ @s_separate, n, c ],
            [ @ns_flow_content, n, c ],
          ),
          @e_scalar,
        ),
      ),
    )



  # [162]
  # c-b-block-header(m,t) ::=
  #   ( ( c-indentation-indicator(m)
  #   c-chomping-indicator(t) )
  #   | ( c-chomping-indicator(t)
  #   c-indentation-indicator(m) ) )
  #   s-b-comment

  @::c_b_block_header.num = 162
  c_b_block_header: (m, t)->
    debug1("c_b_block_header",m,t)
    @all(
      @any(
        @all(
          [ @c_indentation_indicator, m ],
          [ @c_chomping_indicator, t ],
        ),
        @all(
          [ @c_chomping_indicator, t ],
          [ @c_indentation_indicator, m ],
        ),
      ),
      @s_b_comment,
    )



  # [163]
  # c-indentation-indicator(m) ::=
  #   ( ns-dec-digit => m = ns-dec-digit - x:30 )
  #   ( <empty> => m = auto-detect() )

  @::c_indentation_indicator.num = 163
  c_indentation_indicator: (m)->
    debug1("c_indentation_indicator",m)
    @any(
      @if(@ns_dec_digit, @set('m', @ord(@match))),
      @if(@empty, @set('m', "auto-detect")),
    )



  # [164]
  # c-chomping-indicator(t) ::=
  #   ( '-' => t = strip )
  #   ( '+' => t = keep )
  #   ( <empty> => t = clip )

  @::c_chomping_indicator.num = 164
  c_chomping_indicator: (t)->
    debug1("c_chomping_indicator",t)
    @any(
      @if(@chr('-'), @set('t', "strip")),
      @if(@chr('+'), @set('t', "keep")),
      @if(@empty, @set('t', "clip")),
    )



  # [165]
  # b-chomped-last(t) ::=
  #   ( t = strip => b-non-content | <end_of_file> )
  #   ( t = clip => b-as-line-feed | <end_of_file> )
  #   ( t = keep => b-as-line-feed | <end_of_file> )

  @::b_chomped_last.num = 165
  b_chomped_last: (t)->
    debug1("b_chomped_last",t)
    @case(t, {
      'clip': @any( @b_as_line_feed, @end_of_stream ),
      'keep': @any( @b_as_line_feed, @end_of_stream ),
      'strip': @any( @b_non_content, @end_of_stream ),
    })



  # [166]
  # l-chomped-empty(n,t) ::=
  #   ( t = strip => l-strip-empty(n) )
  #   ( t = clip => l-strip-empty(n) )
  #   ( t = keep => l-keep-empty(n) )

  @::l_chomped_empty.num = 166
  l_chomped_empty: (n, t)->
    debug1("l_chomped_empty",n,t)
    @case(t, {
      'clip': [ @l_strip_empty, n ],
      'keep': [ @l_keep_empty, n ],
      'strip': [ @l_strip_empty, n ],
    })



  # [167]
  # l-strip-empty(n) ::=
  #   ( s-indent(<=n) b-non-content )*
  #   l-trail-comments(n)?

  @::l_strip_empty.num = 167
  l_strip_empty: (n)->
    debug1("l_strip_empty",n)
    @all(
      @rep(0, 0,
        @all(
          [ @s_indent_le, n ],
          @b_non_content,
        )),
      @rep(0, 1, [ @l_trail_comments, n ]),
    )



  # [168]
  # l-keep-empty(n) ::=
  #   l-empty(n,block-in)*
  #   l-trail-comments(n)?

  @::l_keep_empty.num = 168
  l_keep_empty: (n)->
    debug1("l_keep_empty",n)
    @all(
      @rep(0, 0, [ @l_empty, n, "block-in" ]),
      @rep(0, 1, [ @l_trail_comments, n ]),
    )



  # [169]
  # l-trail-comments(n) ::=
  #   s-indent(<n)
  #   c-nb-comment-text b-comment
  #   l-comment*

  @::l_trail_comments.num = 169
  l_trail_comments: (n)->
    debug1("l_trail_comments",n)
    @all(
      [ @s_indent_lt, n ],
      @c_nb_comment_text,
      @b_comment,
      @rep(0, 0, @l_comment),
    )



  # [170]
  # c-l+literal(n) ::=
  #   '|' c-b-block-header(m,t)
  #   l-literal-content(n+m,t)

  @::c_l_literal.num = 170
  c_l_literal: (n)->
    debug1("c_l_literal",n)
    @all(
      @chr('|'),
      [ @c_b_block_header, @m, @t ],
      [ @l_literal_content, @add(n, @m), @t ],
    )



  # [171]
  # l-nb-literal-text(n) ::=
  #   l-empty(n,block-in)*
  #   s-indent(n) nb-char+

  @::l_nb_literal_text.num = 171
  l_nb_literal_text: (n)->
    debug1("l_nb_literal_text",n)
    @all(
      @rep(0, 0, [ @l_empty, n, "block-in" ]),
      [ @s_indent, n ],
      @rep(1, 0, @nb_char),
    )



  # [172]
  # b-nb-literal-next(n) ::=
  #   b-as-line-feed
  #   l-nb-literal-text(n)

  @::b_nb_literal_next.num = 172
  b_nb_literal_next: (n)->
    debug1("b_nb_literal_next",n)
    @all(
      @b_as_line_feed,
      [ @l_nb_literal_text, n ],
    )



  # [173]
  # l-literal-content(n,t) ::=
  #   ( l-nb-literal-text(n)
  #   b-nb-literal-next(n)*
  #   b-chomped-last(t) )?
  #   l-chomped-empty(n,t)

  @::l_literal_content.num = 173
  l_literal_content: (n, t)->
    debug1("l_literal_content",n,t)
    @all(
      @rep(0, 1,
        @all(
          [ @l_nb_literal_text, n ],
          @rep(0, 0, [ @b_nb_literal_next, n ]),
          [ @b_chomped_last, t ],
        )),
      [ @l_chomped_empty, n, t ],
    )



  # [174]
  # c-l+folded(n) ::=
  #   '>' c-b-block-header(m,t)
  #   l-folded-content(n+m,t)

  @::c_l_folded.num = 174
  c_l_folded: (n)->
    debug1("c_l_folded",n)
    @all(
      @chr('>'),
      [ @c_b_block_header, @m, @t ],
      [ @l_folded_content, @add(n, @m), @t ],
    )



  # [175]
  # s-nb-folded-text(n) ::=
  #   s-indent(n) ns-char
  #   nb-char*

  @::s_nb_folded_text.num = 175
  s_nb_folded_text: (n)->
    debug1("s_nb_folded_text",n)
    @all(
      [ @s_indent, n ],
      @ns_char,
      @rep(0, 0, @nb_char),
    )



  # [176]
  # l-nb-folded-lines(n) ::=
  #   s-nb-folded-text(n)
  #   ( b-l-folded(n,block-in) s-nb-folded-text(n) )*

  @::l_nb_folded_lines.num = 176
  l_nb_folded_lines: (n)->
    debug1("l_nb_folded_lines",n)
    @all(
      [ @s_nb_folded_text, n ],
      @rep(0, 0,
        @all(
          [ @b_l_folded, n, "block-in" ],
          [ @s_nb_folded_text, n ],
        )),
    )



  # [177]
  # s-nb-spaced-text(n) ::=
  #   s-indent(n) s-white
  #   nb-char*

  @::s_nb_spaced_text.num = 177
  s_nb_spaced_text: (n)->
    debug1("s_nb_spaced_text",n)
    @all(
      [ @s_indent, n ],
      @s_white,
      @rep(0, 0, @nb_char),
    )



  # [178]
  # b-l-spaced(n) ::=
  #   b-as-line-feed
  #   l-empty(n,block-in)*

  @::b_l_spaced.num = 178
  b_l_spaced: (n)->
    debug1("b_l_spaced",n)
    @all(
      @b_as_line_feed,
      @rep(0, 0, [ @l_empty, n, "block-in" ]),
    )



  # [179]
  # l-nb-spaced-lines(n) ::=
  #   s-nb-spaced-text(n)
  #   ( b-l-spaced(n) s-nb-spaced-text(n) )*

  @::l_nb_spaced_lines.num = 179
  l_nb_spaced_lines: (n)->
    debug1("l_nb_spaced_lines",n)
    @all(
      [ @s_nb_spaced_text, n ],
      @rep(0, 0,
        @all(
          [ @b_l_spaced, n ],
          [ @s_nb_spaced_text, n ],
        )),
    )



  # [180]
  # l-nb-same-lines(n) ::=
  #   l-empty(n,block-in)*
  #   ( l-nb-folded-lines(n) | l-nb-spaced-lines(n) )

  @::l_nb_same_lines.num = 180
  l_nb_same_lines: (n)->
    debug1("l_nb_same_lines",n)
    @all(
      @rep(0, 0, [ @l_empty, n, "block-in" ]),
      @any(
        [ @l_nb_folded_lines, n ],
        [ @l_nb_spaced_lines, n ],
      ),
    )



  # [181]
  # l-nb-diff-lines(n) ::=
  #   l-nb-same-lines(n)
  #   ( b-as-line-feed l-nb-same-lines(n) )*

  @::l_nb_diff_lines.num = 181
  l_nb_diff_lines: (n)->
    debug1("l_nb_diff_lines",n)
    @all(
      [ @l_nb_same_lines, n ],
      @rep(0, 0,
        @all(
          @b_as_line_feed,
          [ @l_nb_same_lines, n ],
        )),
    )



  # [182]
  # l-folded-content(n,t) ::=
  #   ( l-nb-diff-lines(n)
  #   b-chomped-last(t) )?
  #   l-chomped-empty(n,t)

  @::l_folded_content.num = 182
  l_folded_content: (n, t)->
    debug1("l_folded_content",n,t)
    @all(
      @rep(0, 1,
        @all(
          [ @l_nb_diff_lines, n ],
          [ @b_chomped_last, t ],
        )),
      [ @l_chomped_empty, n, t ],
    )



  # [183]
  # l+block-sequence(n) ::=
  #   ( s-indent(n+m)
  #   c-l-block-seq-entry(n+m) )+
  #   <for_some_fixed_auto-detected_m_>_0>

  @::l_block_sequence.num = 183
  l_block_sequence: (n)->
    debug1("l_block_sequence",n)
    @all(
      @set('m', @auto_detect_indent),
      @rep(1, 0,
        @all(
          [ @s_indent, @add(n, @m) ],
          [ @c_l_block_seq_entry, @add(n, @m) ],
        )),
    )



  # [184]
  # c-l-block-seq-entry(n) ::=
  #   '-' <not_followed_by_an_ns-char>
  #   s-l+block-indented(n,block-in)

  @::c_l_block_seq_entry.num = 184
  c_l_block_seq_entry: (n)->
    debug1("c_l_block_seq_entry",n)
    @all(
      @chr('-'),
      @chk('!', @ns_char),
      [ @s_l_block_indented, n, "block-in" ],
    )



  # [185]
  # s-l+block-indented(n,c) ::=
  #   ( s-indent(m)
  #   ( ns-l-compact-sequence(n+1+m)
  #   | ns-l-compact-mapping(n+1+m) ) )
  #   | s-l+block-node(n,c)
  #   | ( e-node s-l-comments )

  @::s_l_block_indented.num = 185
  s_l_block_indented: (n, c)->
    debug1("s_l_block_indented",n,c)
    @any(
      @all(
        [ @s_indent, @m ],
        @any(
          [ @ns_l_compact_sequence, @add(n, @add(1, @m)) ],
          [ @ns_l_compact_mapping, @add(n, @add(1, @m)) ],
        ),
      ),
      [ @s_l_block_node, n, c ],
      @all(
        @e_node,
        @s_l_comments,
      ),
    )



  # [186]
  # ns-l-compact-sequence(n) ::=
  #   c-l-block-seq-entry(n)
  #   ( s-indent(n) c-l-block-seq-entry(n) )*

  @::ns_l_compact_sequence.num = 186
  ns_l_compact_sequence: (n)->
    debug1("ns_l_compact_sequence",n)
    @all(
      [ @c_l_block_seq_entry, n ],
      @rep(0, 0,
        @all(
          [ @s_indent, n ],
          [ @c_l_block_seq_entry, n ],
        )),
    )



  # [187]
  # l+block-mapping(n) ::=
  #   ( s-indent(n+m)
  #   ns-l-block-map-entry(n+m) )+
  #   <for_some_fixed_auto-detected_m_>_0>

  @::l_block_mapping.num = 187
  l_block_mapping: (n)->
    debug1("l_block_mapping",n)
    @all(
      @set('m', @auto_detect_indent),
      @rep(1, 0,
        @all(
          [ @s_indent, @add(n, @m) ],
          [ @ns_l_block_map_entry, @add(n, @m) ],
        )),
    )



  # [188]
  # ns-l-block-map-entry(n) ::=
  #   c-l-block-map-explicit-entry(n)
  #   | ns-l-block-map-implicit-entry(n)

  @::ns_l_block_map_entry.num = 188
  ns_l_block_map_entry: (n)->
    debug1("ns_l_block_map_entry",n)
    @any(
      [ @c_l_block_map_explicit_entry, n ],
      [ @ns_l_block_map_implicit_entry, n ],
    )



  # [189]
  # c-l-block-map-explicit-entry(n) ::=
  #   c-l-block-map-explicit-key(n)
  #   ( l-block-map-explicit-value(n)
  #   | e-node )

  @::c_l_block_map_explicit_entry.num = 189
  c_l_block_map_explicit_entry: (n)->
    debug1("c_l_block_map_explicit_entry",n)
    @all(
      [ @c_l_block_map_explicit_key, n ],
      @any(
        [ @l_block_map_explicit_value, n ],
        @e_node,
      ),
    )



  # [190]
  # c-l-block-map-explicit-key(n) ::=
  #   '?'
  #   s-l+block-indented(n,block-out)

  @::c_l_block_map_explicit_key.num = 190
  c_l_block_map_explicit_key: (n)->
    debug1("c_l_block_map_explicit_key",n)
    @all(
      @chr('?'),
      [ @s_l_block_indented, n, "block-out" ],
    )



  # [191]
  # l-block-map-explicit-value(n) ::=
  #   s-indent(n)
  #   ':' s-l+block-indented(n,block-out)

  @::l_block_map_explicit_value.num = 191
  l_block_map_explicit_value: (n)->
    debug1("l_block_map_explicit_value",n)
    @all(
      [ @s_indent, n ],
      @chr(':'),
      [ @s_l_block_indented, n, "block-out" ],
    )



  # [192]
  # ns-l-block-map-implicit-entry(n) ::=
  #   (
  #   ns-s-block-map-implicit-key
  #   | e-node )
  #   c-l-block-map-implicit-value(n)

  @::ns_l_block_map_implicit_entry.num = 192
  ns_l_block_map_implicit_entry: (n)->
    debug1("ns_l_block_map_implicit_entry",n)
    @all(
      @any(
        @ns_s_block_map_implicit_key,
        @e_node,
      ),
      [ @c_l_block_map_implicit_value, n ],
    )



  # [193]
  # ns-s-block-map-implicit-key ::=
  #   c-s-implicit-json-key(block-key)
  #   | ns-s-implicit-yaml-key(block-key)

  @::ns_s_block_map_implicit_key.num = 193
  ns_s_block_map_implicit_key: ->
    debug1("ns_s_block_map_implicit_key")
    @any(
      [ @c_s_implicit_json_key, "block-key" ],
      [ @ns_s_implicit_yaml_key, "block-key" ],
    )



  # [194]
  # c-l-block-map-implicit-value(n) ::=
  #   ':' (
  #   s-l+block-node(n,block-out)
  #   | ( e-node s-l-comments ) )

  @::c_l_block_map_implicit_value.num = 194
  c_l_block_map_implicit_value: (n)->
    debug1("c_l_block_map_implicit_value",n)
    @all(
      @chr(':'),
      @any(
        [ @s_l_block_node, n, "block-out" ],
        @all(
          @e_node,
          @s_l_comments,
        ),
      ),
    )



  # [195]
  # ns-l-compact-mapping(n) ::=
  #   ns-l-block-map-entry(n)
  #   ( s-indent(n) ns-l-block-map-entry(n) )*

  @::ns_l_compact_mapping.num = 195
  ns_l_compact_mapping: (n)->
    debug1("ns_l_compact_mapping",n)
    @all(
      [ @ns_l_block_map_entry, n ],
      @rep(0, 0,
        @all(
          [ @s_indent, n ],
          [ @ns_l_block_map_entry, n ],
        )),
    )



  # [196]
  # s-l+block-node(n,c) ::=
  #   s-l+block-in-block(n,c) | s-l+flow-in-block(n)

  @::s_l_block_node.num = 196
  s_l_block_node: (n, c)->
    debug1("s_l_block_node",n,c)
    @any(
      [ @s_l_block_in_block, n, c ],
      [ @s_l_flow_in_block, n ],
    )



  # [197]
  # s-l+flow-in-block(n) ::=
  #   s-separate(n+1,flow-out)
  #   ns-flow-node(n+1,flow-out) s-l-comments

  @::s_l_flow_in_block.num = 197
  s_l_flow_in_block: (n)->
    debug1("s_l_flow_in_block",n)
    @all(
      [ @s_separate, @add(n, 1), "flow-out" ],
      [ @ns_flow_node, @add(n, 1), "flow-out" ],
      @s_l_comments,
    )



  # [198]
  # s-l+block-in-block(n,c) ::=
  #   s-l+block-scalar(n,c) | s-l+block-collection(n,c)

  @::s_l_block_in_block.num = 198
  s_l_block_in_block: (n, c)->
    debug1("s_l_block_in_block",n,c)
    @any(
      [ @s_l_block_scalar, n, c ],
      [ @s_l_block_collection, n, c ],
    )



  # [199]
  # s-l+block-scalar(n,c) ::=
  #   s-separate(n+1,c)
  #   ( c-ns-properties(n+1,c) s-separate(n+1,c) )?
  #   ( c-l+literal(n) | c-l+folded(n) )

  @::s_l_block_scalar.num = 199
  s_l_block_scalar: (n, c)->
    debug1("s_l_block_scalar",n,c)
    @all(
      [ @s_separate, @add(n, 1), c ],
      @rep(0, 1,
        @all(
          [ @c_ns_properties, @add(n, 1), c ],
          [ @s_separate, @add(n, 1), c ],
        )),
      @any(
        [ @c_l_literal, n ],
        [ @c_l_folded, n ],
      ),
    )



  # [200]
  # s-l+block-collection(n,c) ::=
  #   ( s-separate(n+1,c)
  #   c-ns-properties(n+1,c) )?
  #   s-l-comments
  #   ( l+block-sequence(seq-spaces(n,c))
  #   | l+block-mapping(n) )

  @::s_l_block_collection.num = 200
  s_l_block_collection: (n, c)->
    debug1("s_l_block_collection",n,c)
    @all(
      @rep(0, 1,
        @all(
          [ @s_separate, @add(n, 1), c ],
          [ @c_ns_properties, @add(n, 1), c ],
        )),
      @s_l_comments,
      @any(
        [ @l_block_sequence, [ @seq_spaces, n, c ] ],
        [ @l_block_mapping, n ],
      ),
    )



  # [201]
  # seq-spaces(n,c) ::=
  #   ( c = block-out => n-1 )
  #   ( c = block-in => n )

  @::seq_spaces.num = 201
  seq_spaces: (n, c)->
    debug1("seq_spaces",n,c)
    @flip(c, {
      'block-in': n,
      'block-out': @sub(n, 1),
    })



  # [202]
  # l-document-prefix ::=
  #   c-byte-order-mark? l-comment*

  @::l_document_prefix.num = 202
  l_document_prefix: ->
    debug1("l_document_prefix")
    @all(
      @rep(0, 1, @c_byte_order_mark),
      @rep(0, 0, @l_comment),
    )



  # [203]
  # c-directives-end ::=
  #   '-' '-' '-'

  @::c_directives_end.num = 203
  c_directives_end: ->
    debug1("c_directives_end")
    @all(
      @chr('-'),
      @chr('-'),
      @chr('-'),
    )



  # [204]
  # c-document-end ::=
  #   '.' '.' '.'

  @::c_document_end.num = 204
  c_document_end: ->
    debug1("c_document_end")
    @all(
      @chr('.'),
      @chr('.'),
      @chr('.'),
    )



  # [205]
  # l-document-suffix ::=
  #   c-document-end s-l-comments

  @::l_document_suffix.num = 205
  l_document_suffix: ->
    debug1("l_document_suffix")
    @all(
      @c_document_end,
      @s_l_comments,
    )



  # [206]
  # c-forbidden ::=
  #   <start_of_line>
  #   ( c-directives-end | c-document-end )
  #   ( b-char | s-white | <end_of_file> )

  @::c_forbidden.num = 206
  c_forbidden: ->
    debug1("c_forbidden")
    @all(
      @start_of_line,
      @any(
        @c_directives_end,
        @c_document_end,
      ),
      @any(
        @b_char,
        @s_white,
        @end_of_stream,
      ),
    )



  # [207]
  # l-bare-document ::=
  #   s-l+block-node(-1,block-in)
  #   <excluding_c-forbidden_content>

  @::l_bare_document.num = 207
  l_bare_document: ->
    debug1("l_bare_document")
    @all(
      @exclude(@c_forbidden),
      [ @s_l_block_node, -1, "block-in" ],
    )



  # [208]
  # l-explicit-document ::=
  #   c-directives-end
  #   ( l-bare-document
  #   | ( e-node s-l-comments ) )

  @::l_explicit_document.num = 208
  l_explicit_document: ->
    debug1("l_explicit_document")
    @all(
      @c_directives_end,
      @any(
        @l_bare_document,
        @all(
          @e_node,
          @s_l_comments,
        ),
      ),
    )



  # [209]
  # l-directive-document ::=
  #   l-directive+
  #   l-explicit-document

  @::l_directive_document.num = 209
  l_directive_document: ->
    debug1("l_directive_document")
    @all(
      @rep(1, 0, @l_directive),
      @l_explicit_document,
    )



  # [210]
  # l-any-document ::=
  #   l-directive-document
  #   | l-explicit-document
  #   | l-bare-document

  @::l_any_document.num = 210
  l_any_document: ->
    debug1("l_any_document")
    @any(
      @l_directive_document,
      @l_explicit_document,
      @l_bare_document,
    )



  # [211]
  # l-yaml-stream ::=
  #   l-document-prefix* l-any-document?
  #   ( ( l-document-suffix+ l-document-prefix*
  #   l-any-document? )
  #   | ( l-document-prefix* l-explicit-document? ) )*

  @::l_yaml_stream.num = 211
  l_yaml_stream: ->
    debug1("l_yaml_stream")
    @all(
      @rep(0, 0, @l_document_prefix),
      @rep(0, 1, @l_any_document),
      @rep(0, 0,
        @any(
          @all(
            @rep(1, 0, @l_document_suffix),
            @rep(0, 0, @l_document_prefix),
            @rep(0, 1, @l_any_document),
          ),
          @all(
            @rep(0, 0, @l_document_prefix),
            @rep(0, 1, @l_explicit_document),
          ),
        )),
    )



