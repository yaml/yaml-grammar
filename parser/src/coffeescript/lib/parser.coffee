###
This is a parser class. It has a parse() method and parsing primitives for the
grammar. It calls methods in the receiver class, when a rule matches:
###

require './prelude'
require './grammar'

global.Parser = class Parser extends Grammar

  constructor: (receiver)->
    super()
    @receiver = receiver
    @pos = 0
    @len = 0
    @stack = []
    @trace_num = 1
    @trace_off = 0
    @trace_info = ['', '', '']

  parse: (@input, rule=@TOP, trace=false)->
    @len = @input.length

    @trace = @noop
    @trace = @trace_func if trace

    try
      ok = @call rule
    catch err
      @trace_flush()
      throw err

    @trace_flush()

    if not ok
      throw "Parser failed"

    if @pos < @input.length
      throw "Parser finished before end of input"

    return true

  state: ->
    _.last(@stack) || lvl: 0

  new_state: (name)->
    prev = @state()

    name: name
    lvl: prev.lvl + 1
    pos: @pos
    m: null

  call: (func, type='boolean')->
    args = []
    if typeof_(func) == 'array'
      [func, args...] = func
      args = _.map args, (a)=>
        if typeof_(a) == 'array' then @call(a, 'any') else \
        if typeof_(a) == 'function' then a() else \
        a

    return func if typeof_(func) == 'number'

    die "Bad call type '#{typeof_ func}' for '#{func}'" \
      unless typeof_(func) == 'function'

    trace = func.trace || func.name or xxx func

    @stack.push @new_state(func.name)

    @trace '?', trace, args

    pos = @pos
    @receive func, 'try', pos

    func2 = func.apply(@, args)
    value = func2
    while typeof_(func2) == 'function' or typeof_(func2) == 'array'
      value = func2 = @call func2

    die "Calling '#{trace}' returned '#{typeof_ value}' instead of '#{type}'" \
      if type != 'any' and typeof_(value) != type

    if type != 'boolean'
      @stack.pop()
      return value

    if value
      @trace '+', trace
      @receive func, 'got', pos
    else
      @trace 'x', trace
      @receive func, 'not', pos

    @stack.pop()

    return value

  receive: (func, type, pos)->
    receiver = (func.receivers ?=
      @make_receivers())[type]

    return unless receiver

    # warn receiver.name

    receiver.call @receiver,
      text: @input[pos..@pos-1]
      state: @state()
      start: pos

  make_receivers: ->
    i = @stack.length
    names = []
    while i > 0 and not (n = @stack[--i].name).match /_/
      if m = n.match /^chr\((.)\)$/
        n = 'chr_' + m[1].charCodeAt(0).toString(16)
      names.unshift n
    name = [n, names...].join '__'

    try: @receiver.constructor.prototype["try__#{name}"] || false
    got: @receiver.constructor.prototype["got__#{name}"] || false
    not: @receiver.constructor.prototype["not__#{name}"] || false



  # Match all subrule methods:
  all: (funcs...)->
    all = ->
      pos = @pos
      for func in funcs
        if not func?
          xxx '*** Missing function in @all group:', funcs

        if not @call func
          @pos = pos
          return false

      return true

  # Match any subrule method. Rules are tried in order and stops on first
  # match:
  any: (funcs...)->
    any = ->
      for func in funcs
        if @call func
          return true

      return false

  # Repeat a rule a certain number of times:
  rep: (min, max, func)->
    rep = ->
      count = 0
      pos = @pos
      while @pos < @len and @call func
        return true if min == 0 and pos == @pos
        count++
      if count >= min and (max == 0 or count <= max)
        true
      else
        @pos = pos
        false
    name_ 'rep', rep, "rep(#{min},#{max})"

  # Call a rule depending on state value:
  case: (var_, map)->
    case_ = ->
      rule = map[var_] or
        xxx "Can't find '#{var_}' in:", map
      @call rule
    name_ 'case', case_, "case(#{var_}, #{stringify map})"

  # Call a rule depending on state value:
  flip: (var_, map)->
    value = map[var_] or
      xxx "Can't find '#{var_}' in:", map
    return value if typeof_(value) == 'string'
    return @call value

  # Match a single char:
  chr: (char)->
    chr = ->
      if @pos >= @len
        false
      else if @input[@pos] == char
        @pos++
        true
      else
        false
    name_ 'chr', chr, "chr(#{stringify char})"

  # Match a char in a range:
  rng: (low, high)->
    rng = ->
      if @pos >= @input.length
        false
      else if low <= @input[@pos] <= high
        @pos++
        true
      else
        false
    name_ 'rng', rng, "rng(#{stringify(low)},#{stringify(high)})"
    rng

  # Must match first rule but none of others:
  but: (funcs...)->
    but = ->
      pos1 = @pos
      return false unless @call funcs[0]
      pos2 = @pos
      @pos = pos1
      for func in funcs[1..]
        if @call func
          @pos = pos1
          return false
      @pos = pos2
      return true

  chk: (type, expr)->
    chk = ->
      pos = @pos
      @pos-- if type == '<='
      ok = @call expr
      @pos = pos
      return if type == '!' then not(ok) else ok
    name_ 'chk', chk, "chk(#{type}, #{stringify expr})"

  set: (var_, expr)->
    set = ->
      @state()[var_] = @call expr, 'any'
      true

  max: (max)->
    max = ->
      true

  exclude: (rule)->
    exclude = ->
      true

  add: (x, y)->
    add = ->
      x + y
    add.trace = "add(#{x},#{y})"
    add

  sub: (x, y)->
    sub = ->
      x - y

  m: ->
  t: ->

#------------------------------------------------------------------------------
# Trace debugging:
#------------------------------------------------------------------------------
  noop: ->
  trace_func: (type, call, args=[])->
    if type == 'report'
      return @trace_report()

    level = @state().lvl
    indent = _.repeat ' ', level
    if level > 0
      l = "#{level}".length
      indent = "#{level}" + indent[l..]

    input = @input[@pos..]
      .replace(/\t/g, '\\t')
      .replace(/\r/g, '\\r')
      .replace(/\n/g, '\\n')

    line = sprintf(
      "%5d %s%s %-30s  %4d '%s'",
      @trace_num++,
      indent,
      type,
      @trace_format_call call, args
      @pos,
      input,
    )

    trace_info = null
    level = "#{level}_#{call}"
    if type == '?' and @trace_off == 0
      trace_info = [type, level, line]
    if call in @trace_no_descend
      @trace_off += if type == '?' then 1 else -1
    if type != '?' and @trace_off == 0
      trace_info = [type, level, line]

    if trace_info?
      [prev_type, prev_level, prev_line] = @trace_info
      if prev_type == '?' and prev_level == level
        trace_info[1] = ''
        if line.match /^\d*\ *\+/
          warn prev_line.replace /\?/, '='
        else
          warn prev_line.replace /\?/, '!'
      else if prev_level
        warn prev_line

      @trace_info = trace_info

  trace_format_call: (call, args)->
    return call unless args.length
    list = _.map args, (a)->
      return a.call if typeof_(a) == 'function'
      return 'null' if typeof_(a) == 'null'
      return "#{a}"
    return call + '(' + list.join(',') + ')'

  trace_flush: ->
    if line = @trace_info[2]
      warn line

  trace_no_descend: [
#     'l_document_prefix',
#     'l_directive_document',
#     'l_explicit_document',
#     's_l_block_in_block',
#     's_separate',
#     'c_ns_alias_node',
#     'ns_plain',
#     's_l_comments',
#     'c_ns_properties',
#     'ns_flow_pair',

#     'c_printable',
#     'b_char',
#     'c_byte_order_mark',
#     'nb_char',
#     'ns_char',
#     'c_indicator',
#     'ns_plain_char',
#     's_white',
#     'c_flow_indicator',
#     'l_comment',
#     's_l_block_collection',
  ]

# vim: sw=2:
