require './grammar-spec'

class Grammar extends GrammarSpec
  m: 0
  t: 'keep'

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


global.Grammar = Grammar
