import os, sys, re
import json, timeit, traceback, types, yaml

__all__ = [
  'ENV',
  'file_read',
  'name',
  'func_name',
  'func_trace',
  'isNull',
  'isBoolean',
  'isNumber',
  'isString',
  'isCallable',
  'isFunction',
  'isMethod',
  'isArray',
  'isObject',
  'typeof',
  'stringify',
  'die',
  'warn',
  'debug',
  'debug_rule',
  'dump',
  'WWW',
  'XXX',
  'xxxxx',
  'timer',
]

def ENV(var):
  value = os.environ.get(var, None)
  if value in ['', '0', '1']:
    return bool(value)
  if value is None:
    return ''
  return value

def file_read(name):
  return sys.stdin.readlines()

def name(name, func, trace):
  func.trace = trace or name
  return func

def func_name(func):
  if isFunction(func):
    return func.__name__
  if isMethod(func):
    return func.__func__.__name__

def func_trace(func, trace=None):
  if trace:
    if isFunction(func):
      func.trace = trace
    elif isMethod(func):
      func.__func__.trace = trace
    else:
      XXX(func, trace)
    return

  if isFunction(func):
    return func.trace
  if isMethod(func):
    return func.__func__.trace

def isNull(value):
  return value is None
def isBoolean(value):
  return isinstance(value, bool)
def isNumber(value):
  return isinstance(value, int)
def isString(value):
  return isinstance(value, str)
def isCallable(value):
  return isFunction(value) or isMethod(value)
def isFunction(value):
  return isinstance(value, types.FunctionType)
def isMethod(value):
  return isinstance(value, types.MethodType)
def isArray(value):
  return isinstance(value, list)
def isObject(value):
  return isinstance(value, dict)

def typeof(value):
  if value is None:
    return 'null'
  if isinstance(value, bool):
    return 'boolean'
  if isinstance(value, int):
    return 'number'
  if isinstance(value, str):
    return 'string'
  if isinstance(value, types.MethodType):
    return 'method'
  if isinstance(value, types.FunctionType):
    return 'function'
  if isinstance(value, list):
    return 'array'
  if isinstance(value, dict):
    return 'hash'
  XXX([value, type(value)])

def stringify(o):
  if o == "\ufeff":
    return "\\uFEFF"
  if isCallable(o):
    return f"@{func_name(o)}"
  if isObject(o):
    return json.dumps(list(o.keys()))
  if isArray(o):
    return f"[{','.join(map(lambda e: stringify(e), o))}]"
  return re.sub(r'^"(.*)"$', r'\1', json.dumps(o))

def hex_char(chr):
  return hex(ord(chr))[2:]

def die(msg):
  traceback.print_exception(*(sys.exc_info()))
  raise Exception(msg)

def warn(msg):
  sys.stderr.write(str(msg) + "\n")

def debug(msg):
  warn(f">>> {msg}")

def debug_rule(name, *args):
  if not(ENV('DEBUG')): return
  args = ','.join(map(lambda x: stringify(x), args))
  debug(f"{name}({args})")

def dump(o):
  return yaml.dump(
    o,
    default_flow_style=False,
    explicit_start=True,
    explicit_end=True,
  )

def WWW(*o):
  for n in list(o):
    sys.stderr.write(dump(n))
  return o[0]

def XXX(*o):
  WWW(*o)
  sys.exit(1)

def xxxxx(*o):
  WWW(*o)
  msg = 'xxxxx'
  if isString(o[0]):
    msg += f" - {o[0]}"
  die(msg)

def timer(start=None):
  time = timeit.timeit()
  if start is None:
    return time
  else:
    return time - start

# vim: et sw=2:
