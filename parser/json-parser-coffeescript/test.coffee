#!/usr/bin/env coffee

require 'ingy-prelude'
require './parser'
require './json-parser'


# This is a Receiver class for the Parser. It outputs event lines in the exact
# format of the YAML Test Suite.
class Receiver
  mapBegin: (t)-> say "+MAP"
  mapEnd:   (t)-> say "-MAP"
  seqBegin: (t)-> say "+SEQ"
  seqEnd:   (t)-> say "-SEQ"
  string:   (t)-> say "=VAL \"#{t[1..-2]}"
  number:   (t)-> say "=VAL :#{t}"
  boolean:  (t)-> say "=VAL :#{t}"
  null:     (t)-> say "=VAL :#{t}"


# A parser testing function:
test = (json)->
  say "\nTest JSON: '#{json}'"

  parser = new Grammar(new Receiver)

  try
    parser.parse json
    say 'OK'
  catch error
    snip = parser.input[parser.pos..]
      .replace(/\t/g, '\\t')
      .replace(/\r/g, '\\r')
      .replace(/\n/g, '\\n')
    say "Error: #{error}\n at -> '#{snip}'"


# Tests:
test '[ %1, "two" ]'
test '[ 1, "two" ]'
test '"xyz"'
test '"foo \\"bar\\""'
test 'true'
test 'false'
test 'null'
test '123'
test '123.456'
test '-123.456'
test '123 456'
test ' { "foo": 123 }'
test ' [ { } , [ ] , { "foo" : null, "ba\\"r\\ " : 123.4 } , "" , 0 , -1.23 , true , false , null ] '

