###
This is a parser class. It has a parse() method and parsing primitives for the
grammar. It calls methods in the receiver class, when a rule matches:
###

require './prelude'
require './grammar'

TRACE = Boolean ENV.TRACE

global.Parser = class Parser extends Grammar

  constructor: (receiver)->
    super()
    @receiver = receiver
    @pos = 0
    @len = 0
    @state = []
    @trace_num = 1
    @trace_on = true
    @trace_off = 0
    @trace_info = ['', '', '']

  parse: (@input)->
    @len = @input.length

    @trace_on = not @trace_start() if TRACE

    try
      ok = @call @TOP
      @trace_flush()
    catch err
      @trace_flush()
      throw err

    if not ok
      throw "Parser failed"

    if @pos < @len
      throw "Parser finished before end of input"

    return true

  state_curr: ->
    _.last(@state) ||
      name: null
      lvl: 0
      beg: 0
      end: 0
      m: null
      t: null

  state_prev: ->
    @state[@state.length - 2] or xxxxx @

  state_push: (name)->
    prev = @state_curr()

    @state.push
      name: name
      lvl: prev.lvl + 1
      pos: @pos
      m: null

  state_pop: ->
    @state.pop()
    # state_prev = @state_prev()
    # state_curr = @state.pop()
    # state_prev.beg = state_curr.beg
    # state_prev.end = @pos

  call: (func, type='boolean')->
    args = []
    [func, args...] = func if isArray func

    return func if isNumber func

    xxxxx "Bad call type '#{typeof_ func}' for '#{func}'" \
      unless isFunction func

    func.trace ?= func.name

    @state_push(func.trace)

    @trace '?', func.trace, args if TRACE

    args = _.map args, (a)=>
      if isArray(a) then @call(a, 'any') else \
      if isFunction(a) then a() else \
      a

    pos = @pos
    @receive func, 'try', pos

    func2 = func.apply(@, args)
    value = func2
    while isFunction(func2) or isArray(func2)
      value = func2 = @call func2

    xxxxx "Calling '#{func.trace}' returned '#{typeof_ value}' instead of '#{type}'" \
      if type != 'any' and typeof_(value) != type

    if type != 'boolean'
      @trace '>', value if TRACE
      @state_pop()
      return value

    if value
      @trace '+', func.trace if TRACE
      @receive func, 'got', pos
    else
      @trace 'x', func.trace if TRACE
      @receive func, 'not', pos

    @state_pop()

    return value

  receive: (func, type, pos)->
    receiver = (func.receivers ?=
      @make_receivers())[type]

    return unless receiver

    # warn receiver.name

    receiver.call @receiver,
      text: @input[pos..@pos-1]
      state: @state_curr()
      start: pos

  make_receivers: ->
    i = @state.length
    names = []
    while i > 0 and not (n = @state[--i].name).match /_/
      if m = n.match /^chr\((.)\)$/
        n = 'x' + m[1].charCodeAt(0).toString(16)
      names.unshift n
    name = [n, names...].join '__'

    try: @receiver.constructor.prototype["try__#{name}"]
    got: @receiver.constructor.prototype["got__#{name}"]
    not: @receiver.constructor.prototype["not__#{name}"]



  # Match all subrule methods:
  all: (funcs...)->
    all = ->
      pos = @pos
      for func in funcs
        xxxxx '*** Missing function in @all group:', funcs \
          if not func?

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

  may: (func)->
    may = ->
      @call func

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
        xxxxx "Can't find '#{var_}' in:", map
      @call rule
    name_ 'case', case_, "case(#{var_}, #{stringify map})"

  # Call a rule depending on state value:
  flip: (var_, map)->
    value = map[var_] or
      xxxxx "Can't find '#{var_}' in:", map
    return value if isString value
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
      @state_curr()[var_] = @call expr, 'any'
      true
    name_ 'set', set, "set('#{var_}', #{stringify expr})"

  max: (max)->
    max = ->
      true

  exclude: (rule)->
    exclude = ->
      true

  add: (x, y)->
    add = ->
      x + y
    name_ 'add', add, "add(#{x},#{y})"

  sub: (x, y)->
    sub = ->
      x - y

  match: ->
    match = ->
      XXX [beg, end] = XXX @up_state()

  len: (str)->
    len = ->
      str =@call $str, 'string' unless isString str
      return str.length

  lt: (x, y)->
    lt = ->
      x = @call x, 'number' unless isNumber x
      y = @call y, 'number' unless isNumber y
      return x < y
    name 'lt', lt, "lt(#{stringify x},#{stringify y})"

  le: (x, y)->
    le = ->
      x = @call x, 'number' unless isNumber x
      y = @call y, 'number' unless isNumber y
      return x <= y
    name 'le', le, "le(#{stringify x},#{stringify y})"

  m: ->
    return 0  # XXX
    m = ->
      @state_curr[m]

  m: -> 0
  t: -> ''

#------------------------------------------------------------------------------
# Special grammar rules
#------------------------------------------------------------------------------
  start_of_line: ->
    @pos == 0 or
      @input[@pos - 1] == "\n"

  end_of_stream: ->
    @pos >= @len

  empty: -> true

  auto_detect_indent: ->
    1

#------------------------------------------------------------------------------
# Trace debugging
#------------------------------------------------------------------------------
  trace_start: ->
    '' || ENV.TRACE_START

  trace_quiet: ->
    [
#       'b_char',
#       'c_byte_order_mark',
#       'c_flow_indicator',
#       'c_indicator',
#       'c_ns_alias_node',
#       'c_ns_properties',
#       'c_printable',
#       'l_comment',
#       'l_directive_document',
#       'l_document_prefix',
#       'l_explicit_document',
#       'nb_char',
#       'ns_char',
#       'ns_flow_pair',
#       'ns_plain',
#       'ns_plain_char',
#       's_l_block_collection',
#       's_l_block_in_block',
#       's_l_comments',
#       's_separate',
#       's_white',
    ].concat((ENV.TRACE_QUIET || '').split ',')

  trace: (type, call, args=[])->
    return unless @trace_on or call == @trace_start()

    level = @state_curr().lvl
    indent = _.repeat ' ', level
    if level > 0
      l = "#{level}".length
      indent = "#{level}" + indent[l..]

    input = @input[@pos..]
      .replace(/\t/g, '\\t')
      .replace(/\r/g, '\\r')
      .replace(/\n/g, '\\n')

    line = sprintf(
      "%s%s %-30s  %4d '%s'",
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
    if call in @trace_quiet()
      @trace_off += if type == '?' then 1 else -1
    if type != '?' and @trace_off == 0
      trace_info = [type, level, line]

    if trace_info?
      [prev_type, prev_level, prev_line] = @trace_info
      if prev_type == '?' and prev_level == level
        trace_info[1] = ''
        if line.match /^\d*\ *\+/
          prev_line = prev_line.replace /\?/, '='
        else
          prev_line = prev_line.replace /\?/, '!'
      if prev_level
        warn sprintf "%5d %s", @trace_num++, prev_line

      @trace_info = trace_info

    if call == @trace_start()
      @trace_on = not @trace_on

  trace_format_call: (call, args)->
    return call unless args.length
    list = _.map args, (a)->
      stringify a
    list = list.join ','
    return "#{call}(#{list})"

  trace_flush: ->
    if line = @trace_info[2]
      warn sprintf "%5d %s", @trace_num++, line

# vim: sw=2:
