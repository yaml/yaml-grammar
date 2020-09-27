require './prelude'

global.TestReceiver = class TestReceiver
  constructor: ->
    @event = []
    @cache = []

  add: (event)->
    if @cache.length
      _.last(@cache).push event
    else
      @send event

  cache_up: ->
    @cache.push []

  cache_down: ->
    events = @cache.pop() or xxxxx @
    @add e for e in events

  cache_drop: ->
    @cache.pop() or xxxxx @

  send: (event)->
    @event.push event

  output: ->
    [@event..., ''].join "\n"

  try__l_yaml_stream: ->
    @add '+STR'
  got__l_yaml_stream: ->
    @add '-STR'

  try__l_bare_document: ->
    @add '+DOC'
  got__l_bare_document: ->
    @add '-DOC'

  got__c_flow_mapping__all__x7b: ->
    @add '+MAP {}'
  got__c_flow_mapping__all__x7d: ->
    @add '-MAP'

  got__c_flow_sequence__all__x5b: ->
    @add '+SEQ []'
  got__c_flow_sequence__all__x5d: ->
    @add '-SEQ'

  try__l_block_mapping: ->
    @cache_up()
    @add '+MAP'
  got__l_block_mapping: ->
    @cache_down()
    @add '-MAP'
  not__l_block_mapping: ->
    @cache_drop()

  try__l_block_sequence: ->
    @cache_up()
    @add '+SEQ'
  got__l_block_sequence: ->
    @cache_down()
    @add '-SEQ'
  not__l_block_sequence: ->
    @cache_drop()

  try__ns_flow_pair: -> @cache_up()
  got__ns_flow_pair: -> xxxxx @
  not__ns_flow_pair: -> @cache_drop()

  try__c_ns_flow_map_empty_key_entry: -> @cache_up()
  got__c_ns_flow_map_empty_key_entry: -> xxxxx @
  not__c_ns_flow_map_empty_key_entry: -> @cache_drop()

  got__ns_plain: (o)->
    @add "=VAL :#{o.text}"
  got__c_single_quoted: (o)->
    value = o.text[1...-1]
    @add "=VAL '#{value}"
  got__c_double_quoted: (o)->
    value = o.text[1...-1]
    @add "=VAL \"#{value}"
  got__e_scalar: ->
    @add "=VAL :"

# vim: sw=2:
