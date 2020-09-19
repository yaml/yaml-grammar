__all__ = [
    'Parser',
    ]

###
# This is a parser class. It has a parse() method and parsing primitives for the
# grammar. It calls methods in the receiver class, when a rule matches:
###
import os, sys, re
from prelude import *
from grammar import *

#  TRACE = Boolean ENV.TRACE
TRACE = bool(ENV.get("TRACE", False))

class Parser(Grammar):
  def __init__(self, receiver):
    self.receiver = receiver
    self.pos = 0
    self.end = 0
    self.state = []
    self.trace_num = 1
    self.trace_on = True
    self.trace_off = 0
    self.trace_info = ['', '', '']

  def parse(self, input):
    self.end = len(input)

    if TRACE:
      self.trace_on = not self.trace_start()

    try:
      ok = self.call(self.TOP())
      self.trace_flush()
    except Exception as err:
      self.trace_flush()
      raise(WWW(err))

    if not ok:
      die("Parser failed")
    if self.pos < self.end:
      die("Parser finised before end of input")

    return True

#    state_curr: ->
#      @state[@state.length - 1] ||
#        name: null
#        lvl: 0
#        beg: 0
#        end: 0
#        m: null
#        t: null

#    state_prev: ->
#      @state[@state.length - 2]

#    state_push: (name)->
#      prev = @state_curr()

#      @state.push
#        name: name
#        lvl: prev.lvl + 1
#        beg: @pos
#        end: null
#        m: prev.m
#        t: prev.t

#    state_pop: ->
#      curr = @state.pop()
#      prev = @state_prev()
#      return unless prev?
#      prev.beg = curr.beg
#      prev.end = @pos

  def call(self, func, type_="boolean"):
    args = []
    if isArray(func):
      args = func[1:]
      func  = func[0]

    if isNumber(func):
      return func

    if not isFunction(func):
      xxxxx(f"Bad call type '{typeof(func)}' for '{func}'")

    if not hasattr(func, 'trace'):
      func.trace = func.name

    self.state_push(func.trace)

    if TRACE:
      self.trace('?', func.trace, args)

    def m1(a):
      if isArray(a):
        return self.call(a, 'any')
      elif isFunction(a):
        return a()
      else:
        return a

      args = map(m1, args)

      pos = self.pos
      self.receive(func, 'try', pos)

      value = func(self, args)
      while isFunction(value) or isArray(value):
        value = self.call(value)
      if type_ != 'any' and typeof(value) != type_:
        xxxxx(f"Calling '{func.trace}' returned '{typeof(value)}' instead of '{type}'")
      if type_ != 'boolean':
        if TRACE:
          self.trace('>', value)
      else:
        if value:
          if TRACE:
            self.trace('+', func.trace)
          self.receive(func, 'got', pos)
        else:
          if TRACE:
            self.trace('x', func.trace)
          self.receive(func, 'not', pos)
      
      self.state_pop()
      return value

#    receive: (func, type, pos)->
#      func.receivers ?= @make_receivers()
#      receiver = func.receivers[type]
#      return unless receiver

#      # warn receiver.name

#      receiver.call @receiver,
#        text: @input[pos...@pos]
#        state: @state_curr()
#        start: pos

#    make_receivers: ->
#      i = @state.length
#      names = []
#      while i > 0 and not((n = @state[--i].name).match /_/)
#        if m = n.match /^chr\((.)\)$/
#          n = 'x' + hex_char m[1]
#        names.unshift n
#      name = [n, names...].join '__'

#      return
#        try: @receiver.constructor.prototype["try__#{name}"]
#        got: @receiver.constructor.prototype["got__#{name}"]
#        not: @receiver.constructor.prototype["not__#{name}"]



#    # Match all subrule methods:
#    all: (funcs...)->
#      all = ->
#        pos = @pos
#        for func in funcs
#          xxxxx '*** Missing function in @all group:', funcs \
    #            unless func?

#          if not @call func
#            @pos = pos
#            return false

#        return true

#    # Match any subrule method. Rules are tried in order and stops on first
#    # match:
#    any: (funcs...)->
#      any = ->
#        for func in funcs
#          if @call func
#            return true

#        return false

#    may: (func)->
#      may = ->
#        @call func

#    # Repeat a rule a certain number of times:
#    rep: (min, max, func)->
#      rep = ->
#        count = 0
#        pos = @pos
#        pos_start = pos
#        while @pos < @end and @call func
#          break if @pos == pos
#          count++
#          pos = @pos
#        if count >= min and (max == 0 or count <= max)
#          return true
#        @pos = pos_start
#        return false
#      name_ 'rep', rep, "rep(#{min},#{max})"

#    # Call a rule depending on state value:
#    case: (var_, map)->
#      case_ = ->
#        rule = map[var_] or
#          xxxxx "Can't find '#{var_}' in:", map
#        @call rule
#      name_ 'case', case_, "case(#{var_},#{stringify map})"

#    # Call a rule depending on state value:
#    flip: (var_, map)->
#      value = map[var_] or
#        xxxxx "Can't find '#{var_}' in:", map
#      return value if isString value
#      return @call value, 'number'

#    # Match a single char:
#    chr: (char)->
#      chr = ->
#        if @pos >= @end
#          return false
#        if @input[@pos] == char
#          @pos++
#          return true
#        return false
#      name_ 'chr', chr, "chr(#{stringify char})"

#    # Match a char in a range:
#    rng: (low, high)->
#      rng = ->
#        if @pos >= @input.length
#          return false
#        if low <= @input[@pos] <= high
#          @pos++
#          return true
#        return false
#      name_ 'rng', rng, "rng(#{stringify(low)},#{stringify(high)})"

#    # Must match first rule but none of others:
#    but: (funcs...)->
#      but = ->
#        pos1 = @pos
#        return false unless @call funcs[0]
#        pos2 = @pos
#        @pos = pos1
#        for func in funcs[1..]
#          if @call func
#            @pos = pos1
#            return false
#        @pos = pos2
#        return true

#    chk: (type, expr)->
#      chk = ->
#        pos = @pos
#        @pos-- if type == '<='
#        ok = @call expr
#        @pos = pos
#        return if type == '!' then not(ok) else ok
#      name_ 'chk', chk, "chk(#{type}, #{stringify expr})"

#    set: (var_, expr)->
#      set = ->
#        value = @call expr, 'any'
#        @state_prev()[var_] = value
#        true
#      name_ 'set', set, "set('#{var_}', #{stringify expr})"

#    max: (max)->
#      max = ->
#        true

#    exclude: (rule)->
#      exclude = ->
#        true

#    add: (x, y)->
#      add = ->
#        y = @call y, 'number' if isFunction y
#        x + y
#      name_ 'add', add, "add(#{x},#{y})"

#    sub: (x, y)->
#      sub = ->
#        x - y

#    # This method does not need to return a function since it is never
#    # called in the grammar.
#    match: ->
#      state = @state
#      i = state.length - 1
#      while i > 0 && not state[i].end?
#        xxxxx "Can't find match" if i == 1
#        i--

#      {beg, end} = state[i]
#      return @input[beg...end]

#    len: (str)->
#      len = ->
#        str = @call str, 'string' unless isString str
#        return str.length

#    ord: (str)->
#      ord = ->
#        return str.charCodeAt(0)

#    if: (test, do_if_true)->
#      if_ = ->
#        test = @call test, 'boolean' unless isBoolean test
#        @call do_if_true if test
#        return test
#      name_ 'if', if_

#    lt: (x, y)->
#      lt = ->
#        x = @call x, 'number' unless isNumber x
#        y = @call y, 'number' unless isNumber y
#        return x < y
#      name_ 'lt', lt, "lt(#{stringify x},#{stringify y})"

#    le: (x, y)->
#      le = ->
#        x = @call x, 'number' unless isNumber x
#        y = @call y, 'number' unless isNumber y
#        return x <= y
#      name_ 'le', le, "le(#{stringify x},#{stringify y})"

#    m: ->
#      return 1  # XXX
#      m = ->
#        WWW(@state_curr())[m]

#    t: ->
#      t = ->
#        xxxxx @

#  #------------------------------------------------------------------------------
#  # Special grammar rules
#  #------------------------------------------------------------------------------
#    start_of_line: ->
#      @pos == 0 or
#        @input[@pos - 1] == "\n"

#    end_of_stream: ->
#      @pos >= @end

#    empty: -> true

#    auto_detect_indent: ->
#      1

#  #------------------------------------------------------------------------------
#  # Trace debugging
#  #------------------------------------------------------------------------------
#    trace_start: ->
#      '' || ENV.TRACE_START

#    trace_quiet: ->
#      [
#  #       'b_char',
#  #       'c_byte_order_mark',
#  #       'c_flow_indicator',
#  #       'c_indicator',
#  #       'c_ns_alias_node',
#  #       'c_ns_properties',
#  #       'c_printable',
#  #       'l_comment',
#  #       'l_directive_document',
#  #       'l_document_prefix',
#  #       'l_explicit_document',
#  #       'nb_char',
#  #       'ns_char',
#  #       'ns_flow_pair',
#  #       'ns_plain',
#  #       'ns_plain_char',
#  #       's_l_block_collection',
#  #       's_l_block_in_block',
#  #       's_l_comments',
#  #       's_separate',
#  #       's_white',
#      ].concat((ENV.TRACE_QUIET || '').split ',')

#    trace: (type, call, args=[])->
#      return unless @trace_on or call == @trace_start()

#      level = @state_curr().lvl
#      indent = _.repeat ' ', level
#      if level > 0
#        l = "#{level}".length
#        indent = "#{level}" + indent[l..]

#      input = @input[@pos..]
#        .replace(/\t/g, '\\t')
#        .replace(/\r/g, '\\r')
#        .replace(/\n/g, '\\n')

#      line = sprintf(
#        "%s%s %-30s  %4d '%s'",
#        indent,
#        type,
#        @trace_format_call call, args
#        @pos,
#        input,
#      )

#      trace_info = null
#      level = "#{level}_#{call}"
#      if type == '?' and @trace_off == 0
#        trace_info = [type, level, line]
#      if call in @trace_quiet()
#        @trace_off += if type == '?' then 1 else -1
#      if type != '?' and @trace_off == 0
#        trace_info = [type, level, line]

#      if trace_info?
#        [prev_type, prev_level, prev_line] = @trace_info
#        if prev_type == '?' and prev_level == level
#          trace_info[1] = ''
#          if line.match /^\d*\ *\+/
#            prev_line = prev_line.replace /\?/, '='
#          else
#            prev_line = prev_line.replace /\?/, '!'
#        if prev_level
#          warn sprintf "%5d %s", @trace_num++, prev_line

#        @trace_info = trace_info

#      if call == @trace_start()
#        @trace_on = not @trace_on

#    trace_format_call: (call, args)->
#      return call unless args.length
#      list = args.map (a)->
#        stringify a
#      list = list.join ','
#      return "#{call}(#{list})"

  def trace_flush(self):
    pass
#    trace_flush: ->
#      if line = @trace_info[2]
#        warn sprintf "%5d %s", @trace_num++, line

# vim: sw=2:
