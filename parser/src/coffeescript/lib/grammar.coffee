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


global.Grammar = Grammar
