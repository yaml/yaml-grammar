# This is the JSON grammar. It is very regular and intends to be generated from
# BNF:
class Grammar extends Parser
  TOP: -> @json

  json: ->
    @all(
      @ws,
      @node,
      @ws,
    )

  node: ->
    @any(
      @object,
      @array,
      @scalar,
    )

  scalar: ->
    @any(
      @string,
      @number,
      @boolean,
      @null,
    )

  object: ->
    @all(
      @mapBegin,
      @ws,
      @x01(
        @all(
          @pair,
          @x00(
            @all(
              @ws,
              @comma,
              @ws,
              @pair
            ),
          )
        )
      )
      @mapEnd,
    )

  pair: ->
    @all(
      @string,
      @ws,
      @colon,
      @ws,
      @node,
      @ws,
    )

  array: ->
    @all(
      @seqBegin,
      @ws,
      @x01(
        @all(
          @node,
          @x00(
            @all(
              @ws,
              @comma,
              @ws,
              @node,
            )
          )
        )
      )
      @seqEnd,
      @ws,
    )

  string: ->
    @all(
      @quote,
      @x00(
        @any(
          @char,
          @all(
            @back,
            @any(
              @quote,
              @back,
              @space,
            )
          ),
        )
      ),
      @quote,
    )

  number: ->
    @any(
      @all(
        @x01(@dash),
        @first,
        @x00(@digit),
        @x01(
          @all(
            @dot,
            @x00(@digit),
          )
        )
      ),
      @zero,
    )

  boolean: ->
    @any(
      @true,
      @false,
    )

  ws: ->
    @x00(
      @any(
        @space,
        @tab,
        @cr,
        @nl,
      )
    )

  space:    -> @chr(' ')
  tab:      -> @chr("\t")
  cr:       -> @chr("\r")
  nl:       -> @chr("\n")

  char: ->
    @but(
      @rng("\u{20}", "\u{10FFFF}"),
      @quote,
      @all(
        @back,
        @any(
          @quote,
          @back,
        )
      )
    )

  quote:    -> @chr('"')
  back:     -> @chr('\\')

  dash:     -> @chr('-')
  dot:      -> @chr('.')
  zero:     -> @chr('0')
  first:    -> @rng('1', '9')
  digit:    -> @rng('0', '9')

  mapBegin: -> @chr('{')
  mapEnd:   -> @chr('}')

  seqBegin: -> @chr('[')
  seqEnd:   -> @chr(']')

  colon:    -> @chr(':')
  comma:    -> @chr(',')

  true: ->
    @all(
      @chr('t'),
      @chr('r'),
      @chr('u'),
      @chr('e'),
    )

  false: ->
    @all(
      @chr('f'),
      @chr('a'),
      @chr('l'),
      @chr('s'),
      @chr('e'),
    )

  null: ->
    @all(
      @chr('n'),
      @chr('u'),
      @chr('l'),
      @chr('l'),
    )

global.Grammar = Grammar
