class TestReceiver
  constructor: ->
    @flow_start = false

  events: []

  output: ->
    [@events..., ''].join "\n"

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


module.exports = TestReceiver
