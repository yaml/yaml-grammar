require './prelude'

CoffeeScript = require 'coffeescript'

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

coffee = """
global.DebugParser = class DebugParser extends Parser
"""

for method in methods
  coffee += """

      #{method}: (args...)->
        debug "#{method}"
        super.#{method} args...

    """.replace /^/gm, '  '

eval CoffeeScript.compile coffee, bare: true

# vim: sw=2:
