#!/usr/bin/env coffee

require 'ingy-prelude'

require '../lib/parser'

require '../lib/grammar'

receiver = require '../lib/test-receiver'

test_parse = (yaml)->
  parser = new Parser(new receiver)

  pass = true
  try
    parser.parse(yaml)
  catch e
    warn e
    pass = false

  if yaml.match /\n./
    n = "\n"
  else
    n = ''
    yaml = yaml.replace /\n$/, '\\n'

  if pass
    say "PASS - '#{n}#{yaml}'"
    say parser.receiver.output()
    return true
  else
    say "FAIL - '#{n}#{yaml}'"
    return false

test_parse "[]"
# test_parse "a: b"
# test_parse ""
# test_parse "---\n"
# test_parse "..."
# test_parse "[]  # foo"
# test_parse "[ foo ]"
# test_parse "{}"
# test_parse "{}\n"
# test_parse "''"
