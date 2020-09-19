import os, sys, re, yaml

__all__ = [
  'file_read',
  'isArray',
  'isNumber',
  'isFunction',
  'ENV',
  'WWW',
  'XXX',
  'warn',
  'die',
  'timer',
]

def file_read(name):
  return sys.stdin.readlines()

ENV = os.environ

def WWW(*o):
  for n in o:
    sys.stderr.write(yaml.dump(n))
  return o[0]
  

def XXX(*o):
  for n in o:
    sys.stderr.write(yaml.dump(n))
  sys.exit(1)

#  global.name_ = (name, func, trace)->
#    func.trace = trace || name
#    func

#  global.isNull = _.isNull
#  global.isBoolean = _.isBoolean
def isNumber(v):
  return isinstance(v, int)
#  global.isString = _.isString
def isFunction(v):
  return callable(v)
def isArray(v):
  return isinstance(v, list)

#  global.isObject = _.isPlainObject

#  global.typeof_ = (value)->
#    return 'null' if _.isNull value
#    return 'boolean' if _.isBoolean value
#    return 'number' if _.isNumber value
#    return 'string' if _.isString value
#    return 'function' if _.isFunction value
#    return 'array' if _.isArray value
#    return 'object' if _.PlainisObject value
#    xxx [value, typeof(value)]

#  global.stringify = (o)->
#    if o == "\ufeff"
#      return "\\uFEFF"
#    if isFunction o
#      return "@#{o.name}"
#    if isObject o
#      return JSON.stringify _.keys(o)
#    if isArray o
#      return "[#{(_.map o, (e)-> stringify e).join ','}]"
#    return JSON.stringify(o).replace /^"(.*)"$/, '$1'

#  global.hex_char = (chr)->
#    return chr.charCodeAt(0).toString(16)

#  global.die_ = (msg)->
#    die((new Error().stack) + "\n" + msg)

#  global.debug = (msg)->
#    warn ">>> #{msg}"

#  global.debug_rule = (name, args...)->
#    return unless ENV.DEBUG
#    args = _.join _.map args, (a)->
#      stringify(a)
#    , ','
#    debug "#{name}(#{args})"

#  global.dump = (o)->
#    require('yaml').stringify o

#  global.xxxxx = (o...)->
#    WWW o
#    die 'xxxxx'

def die(msg):
  raise Exception(msg)

def warn(msg):
  sys.stderr.write(str(msg) + "\n")

def timer(start=None):
  return 1.23
#  global.timer = (start=null)->
#    if start?
#      time = process.hrtime(start)
#      time[0] + time[1] / 1000000000
#    else
#      process.hrtime()

# vim: et sw=2:
