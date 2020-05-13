###
This is a parser class. It has a parse() method and parsing primitives for the
grammar. It also calls matching methods in the receiver class, when a rule
matches:
###

require './grammar'

class Parser extends Grammar
  empty: -> true
  excluding_c_forbidden_content: -> false

  constructor: (@receiver)->
    super()

    methods =
      Reflect.ownKeys(@receiver.constructor.prototype).filter (k)->
        k not in ['constructor', 'TOP']

    for method in methods
      @makeReceiver method

  makeReceiver: (m)->
    method = @constructor.prototype[m]
    callback = @receiver.constructor.prototype[m]

    @[m] = ->
      pos = @pos
      if @call method
        if @pos > 0
          text = @input[pos..(@pos - 1)]
        else
          text = ''
        callback.call @receiver, text
        true
      else
        false

  parse: (@input)->
    @len = @input.length
    @pos = 0
    @level = 0

    if not @call @TOP
      @error("Parser failed")

    if @pos < @input.length
      @error("Parser finished before end of input")

    true

  containers: ['all', 'any', 'x00', 'x01', 'x10']

  call: (func)->
    args = []
    if _.isArray func
      [func, args...] = func
      args = _.map args, (a)=>
        if _.isArray a
          a = a[0].apply @, a[1..]
        a

    unless typeof(func) == 'function'        # XXX
      die "Bad call type '#{typeof func}'"

    name = func.name

    @trace func if process.env.TRACE

    @level++ if name in @containers

    func = func.apply(@, args)
    while typeof(func) == 'function' or _.isArray func
      func = @call func

    die typeof func unless typeof(func) == 'boolean'  # XXX

    @level-- if name in @containers

    return func

  # Match all subrule methods:
  all: (fs...)->
    all = ->
      for f in fs
        if not f?
          xxx '*** Missing function in @all group:', fs
          return false

        if not @call f
          return false
      true

  # Match any subrule method. Rules are tried in order and stops on first
  # match:
  any: (fs...)->
    any = ->
      for f in fs
        if @call f
          return true
      false

  # Match 0 or 1 times:
  x01: (f)->
    x01 = ->
      @call f
      true

  # Match 0 or more times:
  x00: (f)->
    x00 = ->
      pos = @pos
      while @call f
        break if pos == @pos
      true

  # Match 1 or more times:
  x10: (f)->
    x10 = ->
      if not @call f
        return false

      null while @call f

      true

  # Repeat a rule a certain number of times:
  rep: (f, m, n)->
    rep = ->
      c = 0
      p = @pos
      c++ while @call f
      if c >= m and (c == 0 or c <= n)
        true
      else
        @pos = p
        false

  # Call a rule depending on state value:
  case: (c, table)->
    table[c] or
      xxx "Can't find '#{c}' in:", table

  # Match a single char:
  chr: (c)->
    chr = ->
      if @pos >= @input.length
        false
      else if @input[@pos] == c
        @pos++
        true
      else
        false

    if process.env.TRACE
      chr.trace = "chr(#{JSON.stringify(c)[1..-2]})"

    chr

  # Must match first rule but none of others:
  but: (fs...)->
    but = ->
      pos1 = @pos
      return  false unless @call fs[0]
      pos2 = @pos
      @pos = pos1
      for f in fs[1..]
        if @call f
          @pos = pos1
          return false
      @pos = pos2
      return true

  # Match a char in a range:
  rng: (x, y)->
    rng = ->
      if @pos >= @input.length
        false
      else if x <= @input[@pos] <= y
        @pos++
        true
      else
        false

  chk: (foo...)->
    xxx foo


  # Special grammar rules (written by hand):
  # TODO Move to separate class module file.
  start_of_line: ->
    @pos == 0 or
      @input[@pos - 1] == "\n"
  end_of_file: ->
    @pos >= @input.length
  where_m_lt_n: ->
    warn "Not implemented 'where_m_lt_n'"
    false
  where_m_le_n: ->
    warn "Not implemented 'where_m_le_n'"
    false
  at_most_1024_characters_altogether: ->
    warn "Not implemented 'at_most_1024_characters_altogether'"
    false
  for_some_fixed_auto_detected_m_gt_0: ->
    warn "Not implemented 'for_some_fixed_auto_detected_m_gt_0'"
    false
  followed_by_an_ns_plain_safe: ->
    warn "Not implemented 'followed_by_an_ns_plain_safe'"
    false
  not_followed_by_an_ns_plain_safe: ->
    warn "Not implemented 'not_followed_by_an_ns_plain_safe'"
    false
  not_followed_by_an_ns_char: ->
    warn "Not implemented 'not_followed_by_an_ns_char'"
    false

  # Helper functions
  error: (msg)->
    throw msg

  indent: ->
    _.repeat ' ', @level

  # Trace debugging:
  trace: (f)->
    name = f.name
    name = f.trace if f.trace?
    name = f.toString() unless name

    input = @input[@pos..]
      .replace(/\t/g, '\\t')
      .replace(/\r/g, '\\r')
      .replace(/\n/g, '\\n')

    warn sprintf(
      "#{@indent()}> %-25s  %-4d '%s'",
      name,
      @pos,
      input
    )

global.Parser = Parser
