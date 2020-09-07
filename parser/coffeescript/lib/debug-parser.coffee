require './prelude'

CoffeeScript = require 'coffeescript'

methods = [
  'all',
  'any',
  'rep',
  'case',
  'flip',
  'chr',
  'rng',
  'but',
  'chk',
  'set',
  'max',
  'exclude',
  'add',
  'sub',
  'm',
  't',
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
