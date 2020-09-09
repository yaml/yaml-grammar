require './prelude'

global.TestReceiver = class TestReceiver
  constructor: ->
    @event = []
    @pools = []

  add: (event)->
    if @pools.length
      _.last(@pools).push event
    else
      @send event

  pool_up: ->
    @pools.push []

  pool_down: ->
    events = @pools.pop() or xxxxx @
    @add e for e in events

  pool_drop: ->
    @pools.pop() or xxxxx @

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

  got__c_flow_sequence__all__x5b: ->
    @add '+SEQ []'

  got__c_flow_sequence__all__x5d: ->
    @add '-SEQ'

  got__c_flow_mapping__all__x7b: ->
    @add '+MAP {}'

  got__c_flow_mapping__all__x7d: ->
    @add '-MAP'

  got__ns_plain: (o)->
    @add "=VAL :#{o.text}"

  got__c_single_quoted: (o)->
    value = o.text[1..-2]
    @add "=VAL '#{value}"

  got__c_double_quoted: (o)->
    value = o.text[1..-2]
    @add "=VAL \"#{value}"

  got__e_scalar: ->
    @add "=VAL :"

  try__ns_flow_pair: -> @pool_up()
  got__ns_flow_pair: -> xxxxx @
  not__ns_flow_pair: -> @pool_drop()

  try__c_ns_flow_map_empty_key_entry: -> @pool_up()
  got__c_ns_flow_map_empty_key_entry: -> xxxxx @
  not__c_ns_flow_map_empty_key_entry: -> @pool_drop()

# vim: sw=2:
