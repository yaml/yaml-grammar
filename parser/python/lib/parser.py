###
# This is a parser class. It has a parse() method and parsing primitives for the
# grammar. It calls methods in the receiver class, when a rule matches:
###

__all__ = [
  'Parser',
]

import re

from prelude import *
from grammar import *

TRACE = ENV('TRACE')

class Parser(Grammar):
  def __init__(self, receiver):
    self.receiver = receiver
    self.pos = 0
    self.end = 0
    self.state = [
      {
        'name': None,
        'lvl': 0,
        'beg': 0,
        'end': 0,
        'm': None,
        't': None,
      }
    ]

    self.trace_num = 1
    self.trace_on = True
    self.trace_off = 0
    self.trace_info = ['', '', '']

  def parse(self, input):
    self.input = input
    self.end = len(input)

    if TRACE:
      self.trace_on = not self.trace_start()

    try:
      ok = self.call(self.TOP)
      self.trace_flush()
    except Exception as err:
      self.trace_flush()
      die(err)

    if not ok:
      die("Parser failed")
    if self.pos < self.end:
      die("Parser finised before end of input")

    return True

  def state_curr(self):
    return self.state[-1]

  def state_prev(self):
    return self.state[len(self.state) - 2]

  def state_push(self, name):
    prev = self.state_curr()

    self.state.append({
      'name': name,
      'lvl': prev.get('lvl') + 1,
      'beg': self.pos,
      'end': None,
      'm': prev.get('m'),
      't': prev.get('t'),
    })

  def state_pop(self):
    curr = self.state.pop()
    prev = self.state_prev()
    if prev is None:
      return
    prev['beg'] = curr.get('beg')
    prev['end'] = self.pos

  def call(self, func, type="boolean"):
    args = []
    if isArray(func):
      args = func[1:]
      func  = func[0]

    if isNumber(func):
      return func

    if not isCallable(func):
      xxxxx(f"Bad call type '{typeof(func)}' for '{func}'")

    if not hasattr(func, 'trace'):
      func_trace(func, func_name(func))

    self.state_push(func.trace)

    if TRACE: self.trace('?', func, args)

    def m1(a):
      if isArray(a): return self.call(a, 'any')
      if isCallable(a): return a()
      return a

    args = map(m1, args)

    pos = self.pos
    self.receive(func, 'try', pos)

    value = func(*args)
    if value is None:
      die(1)
    while isCallable(value) or isArray(value):
      value = self.call(value)
      if value is None: die(2)

    if type != 'any' and typeof(value) != type:
      xxxxx(f"Calling '{func.trace}' returned '{typeof(value)}' instead of '{type}'")
    if type != 'boolean':
      if TRACE: self.trace('>', value)
    else:
      if value:
        if TRACE: self.trace('+', func)
        self.receive(func, 'got', pos)
      else:
        if TRACE: self.trace('x', func)
        self.receive(func, 'not', pos)

    self.state_pop()
    return value

  def receive(self, func, type, pos):
    pass
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



  # Match all subrule methods:
  def all(self, *funcs):
    def all():
      pos = self.pos
      for func in funcs:
        if not self.call(func):
          self.pos = pos
          return False

      return True
    return all

  # Match any subrule method. Rules are tried in order and stops on
  # first match:
  def any(self, *funcs):
    def any():
      for func in funcs:
        if self.call(func):
          return True

      return False
    return any

  def may(self, func):
    def may():
      return self.call(func)
    return may

  # Repeat a rule a certain number of times:
  def rep(self, min, max, func):
    def rep():
      count = 0
      pos = self.pos
      pos_start = pos
      while self.pos < self.end and self.call(func):
        if self.pos == pos:
          break
        count += 1
        pos = self.pos
      if count >= min and (max == 0 or count <= max):
        return True
      self.pos = pos_start
      return False
    return name('rep', rep, f"rep({min},{max})")

  # Call a rule depending on state value:
  def case(self, var, map):
    def case():
      rule = map.get(var)
      if rule is None:
        xxxxx(f"Can't find '{var}' in:", map)
      return self.call(rule)
    return name('case', case, f"case({var},{stringify(map)})")

  # Call a rule depending on state value:
  def flip(self, var, map):
    value = map.get(var)
    if not value:
      xxxxx(f"Can't find '{var}' in:", map)
    if isString(value): return value
    return self.call(value, 'number')

  # Match a single char:
  def chr(self, char):
    def chr():
      if self.pos >= self.end:
        return False
      if self.input[self.pos] == char:
        self.pos += 1
        return True
      return False
    return name('chr', chr, f"chr({stringify(char)})")

  # Match a char in a range:
  def rng(self, low, high):
    def rng():
      if self.pos >= self.end:
        return False
      if low <= self.input[self.pos] <= high:
        self.pos += 1
        return True
      return False
    return name('rng', rng, f"rng({stringify(low)},{stringify(high)})")

  # Must match first rule but none of others:
  def but(self, *funcs):
    def but():
      pos1 = self.pos
      if not(self.call(funcs[0])):
        return False
      pos2 = self.pos
      self.pos = pos1
      for func in funcs[1:]:
        if self.call(func):
          self.pos = pos1
          return False
      self.pos = pos2
      return True
    return but

  def chk(self, type, expr):
    def chk():
      pos = self.pos
      if type == '<=':
        self.pos -= 1
      ok = self.call(expr)
      self.pos = pos
      return not(ok) if type == '!' else ok
    return name('chk', chk, f"chk({type}, {stringify(expr)})")

  def set(self, var, expr):
    def set():
      value = self.call(expr, 'any')
      self.state_prev()[var] = value
      return True
    return name('set', set, f"set('{var}', {stringify(expr)})")

  def max(self, max):
    def max():
      return True
    return max

  def exclude(self, rule):
    def exclude():
      return True
    return exclude

  def add(self, x, y):
    def add():
      y1 = y
      if isFunction(y1):
        y1 = self.call(y1, 'number')
      return x + y1
    return name('add', add, "add({x},{y})")

  def sub(self, x, y):
    def sub ():
      return x - y
    return sub

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
#      name 'if', if_

#    lt: (x, y)->
#      lt = ->
#        x = @call x, 'number' unless isNumber x
#        y = @call y, 'number' unless isNumber y
#        return x < y
#      name 'lt', lt, "lt(#{stringify x},#{stringify y})"

#    le: (x, y)->
#      le = ->
#        x = @call x, 'number' unless isNumber x
#        y = @call y, 'number' unless isNumber y
#        return x <= y
#      name 'le', le, "le(#{stringify x},#{stringify y})"

  def m(self):
    return 1  # XXX
    def m():
      WWW(self.state_curr())['m']
    return m

  def t(self):
    def t():
      xxxxx(self)

#------------------------------------------------------------------------------
# Special grammar rules
#------------------------------------------------------------------------------
  def start_of_line(self):
    if self.pos == 0:
      return True
    return (self.input[self.pos - 1] == "\n")

  def end_of_stream(self):
    return (self.pos >= self.end)

  def empty(self):
    return True

  def auto_detect_indent(self):
    return 1

#------------------------------------------------------------------------------
# Trace debugging
#------------------------------------------------------------------------------
  def trace_start(self):
    return ENV('TRACE_START')

  def trace_quiet(self):
    return [
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
    ] #.concat(ENV('TRACE_QUIET').split ',')

  def trace(self, type, call, args=[]):
    call = func_trace(call)
    if not(self.trace_on or call == self.trace_start()):
      return

    level = self.state_curr().get('lvl')
    indent = ''.join([' '*level])
    if level > 0:
      l = len(f"{level}")
      indent = f"{level}" + indent[l:]

    input = self.input[self.pos:] \
      .replace("\t", "\\t") \
      .replace("\r", "\\r") \
      .replace("\n", "\\n")

    line = "%s%s %-30s  %4d '%s'" % (
      indent,
      type,
      self.trace_format_call(call, args),
      self.pos,
      input,
    )

    trace_info = None
    level = f"{level}_{call}"
    if type == '?' and self.trace_off == 0:
      trace_info = [type, level, line]
    if call in self.trace_quiet():
      self.trace_off += 1 if type == '?' else -1
    if type != '?' and self.trace_off == 0:
      trace_info = [type, level, line]

    if trace_info:
      [prev_type, prev_level, prev_line] = self.trace_info
      if prev_type == '?' and prev_level == level:
        trace_info[1] = ''
        if re.match(r'^\d*\ *\+', line):
          prev_line = prev_line.replace('?', '=')
        else:
          prev_line = prev_line.replace('?', '!')
      if prev_level:
        warn("%5d %s" % (self.trace_num, prev_line))
        self.trace_num += 1

      self.trace_info = trace_info

    if call == self.trace_start():
      self.trace_on = not(self.trace_on)

  def trace_format_call(self, call, args):
    if len(args) == 0:
      return call
    list = ','.join(map(lambda a: stringify(a), args))
    return f"{call}({list})"

  def trace_flush(self):
    line = self.trace_info[2]
    if line:
      warn("%5d %s" % (self.trace_num, line))

# vim: sw=2:
