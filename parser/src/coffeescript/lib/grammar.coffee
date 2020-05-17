require './grammar-spec'

class Grammar extends GrammarSpec
  m: 0
  t: 'keep'


  #----------------------------------------------------------------
  # Required hand written rules
  #----------------------------------------------------------------
  start_of_line: ->
    @pos == 0 or
      @input[@pos - 1] == "\n"

  end_of_file: ->
    @pos >= @input.length

  empty: -> true

  excluding_c_forbidden_content: -> true

  at_most_1024_characters_altogether: -> true

  where_m_lt_n: ->
    die "Not implemented 'where_m_lt_n'"

  where_m_le_n: ->
    die "Not implemented 'where_m_le_n'"

  for_some_fixed_auto_detected_m_gt_0: ->
    die "Not implemented 'for_some_fixed_auto_detected_m_gt_0'"

  followed_by_an_ns_plain_safe: (c)->
    pos = @pos
    ok = @call [@ns_plain_safe, c]
    @pos = pos
    ok

  not_followed_by_an_ns_plain_safe: ->
    die "Not implemented 'not_followed_by_an_ns_plain_safe'"

  not_followed_by_an_ns_char: ->
    die "Not implemented 'not_followed_by_an_ns_char'"

  an_ns_char_preceding: ->
    if @pos == 0
      false
    else
      @input[@pos - 1] not in " \t"


  #----------------------------------------------------------------
  # Debugging:
  #----------------------------------------------------------------
  match_regex: (rgx)->
    return false unless @pos < @len
    if m = @input[@pos..].match rgx
      @pos += m[0].length
      return true
    else
      return false

  XXX_s_separate_in_line: ->
    @match_regex(/^[\ \t]+/) or
    @start_of_line()

  # 114, 123, 132 has bug. @all not needed if only 1 param

  XXX_ns_plain_one_line: (c)->
    @match ///^
    126
    ///

  #----------------------------------------------------------------
  # Patches that need to be generated:
  #----------------------------------------------------------------
  @::ns_plain_char.num = 130
  ns_plain_char: (c)->
    @any(
      @but(
        [@ns_plain_safe, c],
        @chr(':'),
        @chr('#'),
      ),
      @all(
        @an_ns_char_preceding,
        @chr('#'),
      ),
      @all(
        @chr(':'),
        [@followed_by_an_ns_plain_safe, c],
      ),
    )


  #----------------------------------------------------------------
  # Debugging
  #----------------------------------------------------------------

#   ns_s_flow_map_entries: (n, c)->
#     WWW n,c
#     super(n, c)


global.Grammar = Grammar
