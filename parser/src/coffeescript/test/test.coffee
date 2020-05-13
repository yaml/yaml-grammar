#!/usr/bin/env coffee

require 'ingy-prelude'

require '../lib/parser'

require '../lib/grammar'

class Receiver

test_parse = (yaml)->
  parser = new Parser(new Receiver)

  pass = true
  try
    parser.parse(yaml)
  catch e
    warn e
    pass = false

  n = if yaml.match /\n./ then "\n" else ''

  if pass
    say "PASS - '#{n}#{yaml}'"
    return true
  else
    say "FAIL - '#{n}#{yaml}'"
    return false

# exit 1 unless test_parse "123 # foo"
test_parse "{}"
test_parse "{}\n"
test_parse "''\n"
test_parse '"'
