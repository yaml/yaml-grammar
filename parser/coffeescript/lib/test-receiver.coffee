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

  got__c_flow_sequence__all__x5b: ->
    return unless @flow_start
    return if @flow_pair
    @events.push '+SEQ []'

  got__c_flow_sequence__all__x5d: ->
    return unless @flow_start
    return if @flow_pair
    @events.push '-SEQ'

  got__c_flow_mapping__all__x7b: ->
    return unless @flow_start
    return if @flow_pair
    @events.push '+MAP {}'

  got__c_flow_mapping__all__x7d: ->
    return unless @flow_start
    return if @flow_pair
    @events.push '-MAP'

  got__ns_plain: (o)->
    return if @flow_pair
    @events.push "=VAL :#{o.text}"

  got__c_single_quoted: (o)->
    return if @flow_pair
    value = o.text[1..-2]
    @events.push "=VAL '#{value}"

  got__c_double_quoted: (o)->
    return if @flow_pair
    value = o.text[1..-2]
    @events.push "=VAL \"#{value}"

# vim: sw=2:
