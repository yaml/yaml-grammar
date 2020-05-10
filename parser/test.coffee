#!/usr/bin/env coffee

require 'ingy-prelude'

require './lib/parser'

require './lib/grammar'

class Receiver

parser = new YamlGrammar(new Receiver)

parser.parse('{}')
# parser.parse('{""}')
