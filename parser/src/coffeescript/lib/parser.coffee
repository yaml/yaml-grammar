###
This is a parser class. It has a parse() method and parsing primitives for the
grammar. It also calls matching methods in the receiver class, when a rule
matches:
###

require './grammar'

class Parser extends Grammar

  state: []

  constructor: (@receiver)-> super()

  parse: (@input)->
    @len = @input.length
    @pos = 0
    @level = 0

    if not @call @TOP
      throw "Parser failed"

    if @pos < @input.length
      throw "Parser finished before end of input"

    true

  containers: ['all', 'any', 'but', 'x00', 'x01', 'x10']

  call: (func)->
    args = []
    if _.isArray func
      [func, args...] = func
      args = _.map args, (a)=>
        if _.isArray a
          a[0].apply @, a[1..]
        else
          a

    unless typeof(func) == 'function'        # XXX
      die "Bad call type '#{typeof func}'"

    name = func.trace || func.name || func.toString()

    @state.push name

    @level++ if name in @containers

    @trace '?', name

    pos = @pos
    @receive func, 'try', pos

    result = func2 = func.apply(@, args)
    while typeof(func2) == 'function' or _.isArray func2
      result = func2 = @call func2

    if typeof(result) != 'boolean'  # XXX
      die "Calling '#{name}' returned '#{typeof result}' instead of 'boolean'"

    if result
      @trace '+', name
      @receive func, 'got', pos
    else
      @trace 'x', name

    @level-- if name in @containers

    @state.pop()

    return result

  receive: (func, type, pos)->
    receiver = (func.receivers ?= @make_receivers())[type]
    return unless receiver

    # warn receiver.name

    receiver.call @receiver,
      text: @input[pos..@pos-1]
      parser: @
      start: pos

  make_receivers: ->
    i = @state.length
    names = []
    while i > 0 and not (n = @state[--i]).match /_/
      if m = n.match /^chr\((.)\)$/
        n = 'chr_' + m[1].charCodeAt(0).toString(16)
      names.unshift n
    name = [n, names...].join '__'

    try: @receiver.constructor.prototype["try__#{name}"] || false
    got: @receiver.constructor.prototype["got__#{name}"] || false


  # Match all subrule methods:
  all: (fs...)->
    all = ->
      pos = @pos
      for f in fs
        if not f?
          xxx '*** Missing function in @all group:', fs
          return false

        if not @call f
          @pos = pos
          return false

      return true

  # Match any subrule method. Rules are tried in order and stops on first
  # match:
  any: (fs...)->
    any = ->
      for f in fs
        if @call f
          return true

      return false

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

    chr.trace = "chr(#{JSON.stringify(c)[1..-2]})"

    chr

  # Must match first rule but none of others:
  but: (fs...)->
    but = ->
      pos1 = @pos
      return false unless @call fs[0]
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

    if process.env.TRACE
      rng.trace = "rng(#{JSON.stringify(x)[1..-2]},#{JSON.stringify(y)[1..-2]})"

    rng


  # Trace debugging:
  trace: (marker, name)->
    return unless process.env.TRACE
#     return unless marker in ['x', '+']

    input = @input[@pos..]
      .replace(/\t/g, '\\t')
      .replace(/\r/g, '\\r')
      .replace(/\n/g, '\\n')

    warn sprintf(
      "#{_.repeat ' ', @level}%s %-30s  %4d '%s'",
      marker,
      "#{name}_#{@level}",
      @pos,
      input
    )

global.Parser = Parser
