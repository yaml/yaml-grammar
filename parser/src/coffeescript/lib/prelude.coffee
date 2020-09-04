require 'ingy-prelude'

global.name_ = (name, func, trace)->
  if trace?
    func.trace = trace
  func

global.stringify = (c)->
  if c == "\ufeff"
    return "\\uFEFF"
  if typeof_(c) == 'function'
    return "@#{c.name}"
  return JSON.stringify(c).replace /^"(.*)"$/, '$1'

global.typeof_ = (value)->
  return 'null' if _.isNull value
  return 'boolean' if _.isBoolean value
  return 'number' if _.isNumber value
  return 'string' if _.isString value
  return 'function' if _.isFunction value
  return 'array' if _.isArray value
  return 'object' if _.isObject value
  xxx [value, typeof(value)]

global.die_ = (msg)->
  die((new Error().stack) + "\n" + msg)

global.debug = (msg)->
  warn ">>> #{msg}"

global.debug1 = (name, args...)->
  return unless process.env.DEBUG
  args = _.join _.map args, (a)->
    stringify(a)
  , ','
  debug "#{name}(#{args})"

global.timer = (start=null)->
  if start?
    time = process.hrtime(start)
    time[0] + time[1] / 1000000000
  else
    process.hrtime()

# vim: sw=2:
