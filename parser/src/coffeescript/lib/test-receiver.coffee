require './prelude'

global.TestReceiver = class TestReceiver
  constructor: ->
    @flow_start = false
    @events = []
    @flow_pair = false

  output: ->
    [@events..., ''].join "\n"

  try__ns_flow_pair: -> @flow_pair = true
  not__ns_flow_pair: -> @flow_pair = false
  got__ns_flow_pair: -> die()

  try__l_yaml_stream: ->
    @events.push '+STR'

  got__l_yaml_stream: ->
    @events.push '-STR'

  try__s_l_flow_in_block: ->
    @flow_start = true

  try__l_bare_document: ->
    @events.push '+DOC'

  got__l_bare_document: ->
    @events.push '-DOC'

  got__c_flow_sequence__all__chr_5b: ->
    if @flow_start
      @events.push '+SEQ []'

  got__c_flow_sequence__all__chr_5d: ->
    if @flow_start
      @events.push '-SEQ'

  got__ns_plain: (o)->
    return if @flow_pair
    @events.push "=VAL :#{o.text}"

# vim: sw=2:
