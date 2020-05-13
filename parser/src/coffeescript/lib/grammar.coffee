require './grammar-spec'

class Grammar extends GrammarSpec
  m: 0
  t: 'keep'


  #----------------------------------------------------------------
  # Required hand written rules
  #----------------------------------------------------------------
  empty: ->
    true

  #----------------------------------------------------------------
  # Debugging
  #----------------------------------------------------------------

#   ns_s_flow_map_entries: (n, c)->
#     WWW n,c
#     super(n, c)

  #----------------------------------------------------------------
  # Fix for case switcher
  #----------------------------------------------------------------
  # [201] seq-spaces(n,c) ::=
  # ( c = block-out => n-1 )
  # ( c = block-in => n )
  @::seq_spaces.num = 201
  seq_spaces: (n, c)->
    @case(c, {
      'block-out': n - 1,
      'block-in': n,
    })


  #----------------------------------------------------------------
  # Fixes for @m
  #----------------------------------------------------------------
  # [170] c-l+literal(n) ::=
  # '|' c-b-block-header(m,t)
  # l-literal-content(n+m,t)
  @::c_l_literal.num = 170
  c_l_literal: (n)->
    @all(
      @chr('|'),
      [@c_b_block_header, @m, @t],
      [@l_literal_content, (n + @m), @t],
    )


  # [174] c-l+folded(n) ::=
  # '>' c-b-block-header(m,t)
  # l-folded-content(n+m,t)
  @::c_l_folded.num = 174
  c_l_folded: (n)->
    @all(
      @chr('>'),
      [@c_b_block_header, @m, @t],
      [@l_folded_content, (n + @m), @t],
    )


  # [183] l+block-sequence(n) ::=
  # ( s-indent(n+m)
  # c-l-block-seq-entry(n+m) )+
  # <for_some_fixed_auto-detected_m_>_0>
  @::l_block_sequence.num = 183
  l_block_sequence: (n)->
    @all(
      @x10(
        @all(
          [@s_indent, (n + @m)],
          [@c_l_block_seq_entry, (n + @m)],
        )
      ),
      @for_some_fixed_auto_detected_m_gt_0,
    )


  # [187] l+block-mapping(n) ::=
  # ( s-indent(n+m)
  # ns-l-block-map-entry(n+m) )+
  # <for_some_fixed_auto-detected_m_>_0>
  @::l_block_mapping.num = 187
  l_block_mapping: (n)->
    @all(
      @x10(
        @all(
          [@s_indent, (n + @m)],
          [@c_l_block_seq_entry, (n + @m)],
        )
      ),
      @for_some_fixed_auto_detected_m_gt_0,
    )


global.Grammar = Grammar
