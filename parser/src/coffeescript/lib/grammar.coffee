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

  end_of_stream: ->
    @pos >= @len

  empty: -> true

  auto_detect_indent: ->
    1

global.Grammar = Grammar
