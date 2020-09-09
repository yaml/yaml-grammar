require '../../test/testml/src/coffee/lib/testml/bridge'
require '../lib/prelude'
require '../lib/parser'
require '../lib/grammar'
require '../lib/test-receiver'

module.exports =
class TestMLBridge extends TestML.Bridge

  parse: (yaml)->
    parser = new Parser(new TestReceiver)

    error = ''
    try
      parser.parse yaml, undefined, process.env.TRACE
    catch e
      error = String e

    if error
      error
    else
      parser.receiver.output()
