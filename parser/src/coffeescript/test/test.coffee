#!/usr/bin/env coffee

require '../lib/prelude'
require '../lib/parser'
require '../lib/test-receiver'

main = (yaml, rule='TOP', args...)->
  args = _.map args, (a)->
    if a == 'null' then null
    else if a.match /^-?[0-9]+$/ then Number a
    else a

  test_parse yaml, rule, args

test_parse = (yaml, rule=null, args=[])->
  parser = new Parser(new TestReceiver)

  rule ?= 'TOP'

  if _.isString rule
    rule = parser[rule]
  if args.length > 0
    rule = [rule, args...]

  pass = true
  trace = process.env.TRACE
  start = timer()

  try
    parser.parse(yaml, rule, trace)
  catch e
    warn e
    pass = false

  time = timer(start)

  if yaml.match /\n./
    n = "\n"
  else
    n = ''
    yaml = yaml.replace /\n$/, '\\n'

  if pass
    say "PASS - '#{n}#{yaml}'"
    say parser.receiver.output()
    say sprintf "Parse time %.5fs", time
    return true
  else
    say "FAIL - '#{n}#{yaml}'"
    say parser.receiver.output()
    say sprintf "Parse time %.5fs", time
    return false

if process.argv.length > 2
  if main process.argv[2..]...
    exit 0
  else
    exit 1


test_parse "[1,2 2  ,333,]"
# test_parse "[123]"
# test_parse "a: b"
# test_parse ""
# test_parse "---\n"
# test_parse "..."
# test_parse "[]  # foo"
# test_parse "[ foo ]"
# test_parse "{}"
# test_parse "{}\n"
# test_parse "''"
