__all__ = [
  'DebugParser',
]

from parser import *
from prelude import *

methods = [
  'all', 'any', 'may', 'rep',
  'case', 'flip',
  'chr', 'rng', 'but', 'chk',
  'set', 'max', 'exclude',
  'add', 'sub',
  'match', 'len', 'ord', 'if', 'lt', 'le',
  'm', 't',
  'start_of_line', 'end_of_stream', 'empty', 'auto_detect_indent',
]

class DebugParser(Parser):
  pass

# vim: sw=2:
