###
This is a parser class. It has a parse() method and parsing primitives for the
grammar. It also calls matching methods in the receiver class, when a rule
matches:
###

require './grammar'

class Parser extends Grammar

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

    if typeof(func) != 'boolean'  # XXX
      die "Calling '#{name}' returned '#{typeof func}' instead of 'boolean'"

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
      "#{_.repeat ' ', @level}> %-25s  %-4d '%s'",
      name,
      @pos,
      input
    )

global.Parser = Parser
