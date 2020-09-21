require './generate-yaml-grammar'

global.generator_class = \
  class YamlGrammarCoffeeScriptGenerator \
  extends YamlGrammarGenerator

  gen_grammar_head: (top)->
    name = @rule_name top
    """\
    # #{@gen_grammar_info()}
    __all__ = ["Grammar"]

    from prelude import *

    class Grammar:

      def TOP(self):
        return self.#{name}
    \n\n
    """

  gen_rule_code: (num, comment, rule_name, debug_args, rule_args, rule_body)->
    @indent """\
    #{comment}
    # @::#{rule_name}.num = #{Number @num}
    def #{rule_name}#{rule_args}:
      debug_rule("#{rule_name}"#{debug_args})
      return #{rule_body.replace /^ +/, ''}
    \n\n\n
    """

  gen_rule_args: (name)->
    rule = @spec[name] or XXX name
    return '(self)' unless _.isPlainObject rule
    @args = rule['(...)']
    return '(self)' unless @args?
    delete rule['(...)']
    @args = [ @args ] unless _.isArray @args
    @args.unshift 'self'
    "(#{@args.join ', '})"

  gen_debug_args: (name)->
    rule = @spec[name] or XXX name
    return '' unless _.isPlainObject rule
    args = rule['(...)']
    return '' unless args?
    args = [ args ] unless _.isArray args
    args = _.map args, (a)-> "#{a}"
    str = ',' + args.join(', ')
      .replace /\ /g, ''
      .replace /^\(\)$/, ''

  gen_hex_code: (hex)->
    if hex.length == 2
      return "'\\x#{hex}'"
    if hex.length == 4
      return "'\\u#{hex}'"
    if hex.length == 6
      return "'\\U00#{hex}'"
    if hex.length == 8
      return "'\\U#{hex}'"
    XXX hex

  gen_pair_sep: -> ': '

  gen_null: -> 'None'

  gen_method_call: (method, args...)->
    if method == 'if'
      method = 'if_'
    [args, sep] = @gen_method_call_args args
    "self.#{method}(#{sep}#{args}#{sep})"

  gen_method_ref: (name)->
    "self.#{name}"

  gen_comment_block: (text)->
    text = text
      .replace /^/g, '# '
      .replace /\n$/, ''
    """\
    ###
    #{text}
    ###
    """

# vim: set sw=2:
