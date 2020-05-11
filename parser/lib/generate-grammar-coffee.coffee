yaml = require 'yaml'

class YamlGrammarCoffeeScriptGenerator
  constructor: (spec)->
    @spec = yaml.parse spec
    @comments = @get_comments spec

  num: 0

  grammar: ''

  miss: [64, 65, 163]
  true: [] # [80, 163,164,165,166]
  false: [] # [131, 200,202,208]

  generate_grammar: (top)->
    @out @generate_grammar_head top

    for name in _.keys(@spec)
      die "No rule for '#{name}'" unless @spec[name]?
      @num++

      @out \
        @generate_rule_info(name) +
        @generate_rule_meta(name) +
        @generate_rule_head(name) +
        @generate_rule_body(name)

      die @num if @num == Number process.env.NUM

    @out @generate_grammar_tail()

    @grammar

  generate_rule_info: (name)->
    @indent(@comments[@num].trim()) + "\n"

  generate_rule_meta: (name)->
    [name] = @rule_name name

    "  @::#{name}.num = #{@num}\n"

  generate_rule_head: (name)->
    [name, args...] = @rule_name name

    if args.length
      args = @format_args_sig args
      "  #{name}: (#{args})->"
    else
      "  #{name}: ->"

  generate_rule_body: (name)->
    if @num in @miss
      rule = @generate_miss name

    else if @num in @true
      rule = @generate_true name

    else if @num in @false
      rule = @generate_false name

    else
      rule = @generate_rule(@spec[name], name).trim()

    "\n" + @indent(rule, 2) + "\n\n\n"

  generate_miss: (name)->
    """
    die "[#{@num}] #{name} --> not implemented yet"
    """

  generate_true: (name)->
    """
    say "\#{@indent()}# [#{@num}] #{name} --> true"
    true
    """

  generate_false: (name)->
    """
    say "\#{@indent()}# [#{@num}] #{name} --> false"
    false
    """

  generate_rule: (rule, name='')->
    if _.isArray rule
      return @generate_from_array rule
    else if _.isString rule
      return @generate_from_string rule
    else
      xxx "[#{@num}] Unknown rule type", rule

  generate_from_array: (rule)->
    if _.isArray rule[0]
      if rule[0][1] == '=>'
        return @generate_set rule
      if rule[0][3] == '=>'
        return @generate_case rule
      else
        return @generate_all rule
    else
      if rule[0] == '<?>'
        return @generate_maybe_all rule[1..]
      if rule[0] == '<*>'
        return @generate_many_all rule[1..]
      if rule[0] == '<|*>'
        return @generate_many_any rule[1..]
      if rule[0] == '<|>'
        return @generate_any rule[1..]
      else if rule[0] == '<->'
        return @generate_but rule[1..]
      else if rule[0].match(
        ///^
          (?:b|c|e|l|nb|ns|s)-[-a-z0-9]+
          .*
        $///) or rule[0].match(/^\\?.$/)
        return @generate_all rule
      else if m = rule[0].match /^<(.+)>$/
        return @generate_ref m[1], ''
      else
        xxx "[#{@num}] Unknown array rule type", rule

  generate_from_string: (rule)->
    if m = rule.match /^x([0-9A-F]+)$/
      return "@chr(\"\\u{#{m[1]}}\")"
    else if m = rule.match /^x([0-9A-F]+)-x([0-9A-F]+)$/
      return "@rng(\"\\u{#{m[1]}}\", \"\\u{#{m[2]}}\")"
    else if rule.match(/^\\?.$/)
      if rule == "'"
        return "@chr(\"'\")"
      else if rule == "\\"
        return "@chr(\"\\\\\")"
      else
        return "@chr('#{rule}')"
    else if m = rule.match(///^
      (
        (?:b|c|e|l|nb|ns|s)(?:[-+][a-z0-9]+)+
        (?:
          \((?:
              <?[cmnt]
            | -1
            | flow-key
            | block-key
            | n/a
            | <=n
            | n\+m
            | n\+1
            | n\+1\+m
            | seq-spaces\(n,c\)
            )
            (?:,(?:
              [ct]
            | flow-in
            | flow-out
            | block-in
            | block-out
            | in-flow\(c\)
            ))?
          \)
        )?
      )(\?|\*|\+|\{[248mn]\})?
    $///)
      return @generate_ref m[1], m[2]
    else if m = rule.match /^<(\w.+)>$/
      return @generate_special m[1]
    else
      xxx "[#{@num}] Unknown string rule type", rule

  generate_ref: (name, qnt)->
    [name, args...] = @rule_name name

    ref = "@#{name}"
    if args.length
      ref = '[' + ref + ', ' + @format_args_call(args) + ']'

    if not qnt
    else if qnt == '?'
      ref = "@x01(#{ref})"
    else if qnt == '*'
      ref = "@x00(#{ref})"
    else if qnt == '+'
      ref = "@x10(#{ref})"
    else if m = qnt.match /^\{([248])\}$/
      ref = "@rep(#{ref}, #{m[1]})"
    else if m = qnt.match /^\{([mn])\}$/
      ref = "@rep(#{ref}, #{m[1]})"
    else
      xxx "[#{@num}] Unknown ref format", name, qnt

    ref

  generate_special: (name, qnt)->
    name = name.replace /\(.*/, ''
    name = @special_name name
    "@#{name}"

  generate_maybe_all: (list)->
    "@x01(\n" +
      @indent(@generate_all(list).replace(/\s+$/, '')) +
      "\n)"

  generate_many_any: (list)->
    "@x00(\n" +
      @indent(@generate_all(list).replace(/\s+$/, '')) +
      "\n)"

  generate_many_all: (list)->
    "@x00(\n" +
      @indent(@generate_all(list).replace(/\s+$/, '')) +
      "\n)"

  # TODO generate_{all,any,but} can probably be one function
  generate_all: (list)->
    out = "@all(\n"
    for item in list
      out += @indent(@generate_rule(item).trim()) + ",\n"
    out += ")\n"
    out

  generate_any: (list)->
    out = "@any(\n"
    for item in list
      out += @indent(@generate_rule(item).trim()) + ",\n"
    out += ")\n"
    out

  generate_but: (list)->
    out = "@but(\n"
    for item in list
      out += @indent(@generate_rule(item).trim()) + ",\n"
    out += ")\n"
    out

  generate_case: (list)->
    # www @num, list
    out = "@case(#{list[0][0]}, {\n"
    for item in list
      value = item[2]
      func = item[4]
      if _.isArray func
        call = @generate_rule(func)
          .trim()
          .replace(/\n/g, ' ')
          .replace(/ +/g, ' ')
          .replace(/, \)/, ')')
          .replace(/\( /, '(')
        out += "  '#{value}': #{call},\n"
      else
        [name, args...] = @rule_name func
        if args.length
          args = @format_args_case args
          out += "  '#{value}': [@#{name}, #{args}],\n"
        else
          out += "  '#{value}': @#{name},\n"
    out += "})\n"
    out

  generate_set: (list)->
    # www @num, list
    out = "@any(\n"
    for item in list
      rule = @generate_rule item[0]
      prop = item[2]
      value = item[4]
      out += "  @if_set(#{rule}, '#{prop}', '#{value}'),\n"
    out += ")\n"
    out

  generate_grammar_head: (top)->
    [name] = @rule_name top
    """\
    ###
    This grammar class was generated from https://yaml.org/spec/1.2/spec.html
    ###

    class Grammar extends Parser

      TOP: -> @#{name}



    """

  generate_grammar_tail: (top)->
    """
    global.YamlGrammar = Grammar
    """

  out: (text)->
    @grammar += text

  indent: (text, n=1)->
    text.replace(/^/gm, _.repeat('  ', n))

  rule_name: (name)->
    name = name.replace /[-+]/g, '_'

    return [name] unless name.match /\(/

    if m = name.match /(.*)\(<n\)$/
      return ["#{m[1]}_lt", 'n']

    if m = name.match /(.*)\(<=n\)$/
      return ["#{m[1]}_le", 'n']

    if m = name.match /(.*)\(([cmnt]|n_1_m|block_key|flow_key|seq_spaces\(n,c\))\)$/
      return [m[1], m[2]]

    if m = name.match /(.*)\(([mn]|_1|n_1|n_m|n\/a),([ct]|block_in|block_out|flow_in|flow_out|in_flow\(c\))\)$/
      return [m[1], m[2], m[3]]

    die "[#{@num}] Bad rule name in [#{@num}]: '#{name}'"

  special_name: (name)->
    [name] = @rule_name name
    name = name
      .replace /(?:_<=_|\(<=)/, '_le_'
      .replace /(?:_<_|\(<)/, '_lt_'
      .replace /(?:_>_)/, '_gt_'
#     warn ">>> " + name
#     name

  format_args_sig: (list)->
    t = (v)=>
      if v in "cmnt"
        v
      else
        xxx "[#{@num}] Bad list in format_args_sig:", list

    _.map(list, t).join ', '

  format_args_call: (list)->
    t = (v)=>
      if v in "cmnt"
        v
      else if v in ['n/a', 'block_key', 'block_in', 'block_out', 'flow_key', 'flow_in', 'flow_out']
        "'#{v.replace '_', '-'}'"
      else if v == 'n_m'
        '(n + @m)'
      else if v == '_1'
        '-1'
      else if v == 'n_1'
        '(n + 1)'
      else if v == 'n_1_m'
        '(n + 1 + @m)'
      else if v == 'in_flow(c)'
        '[@in_flow, c]'
      else if v == 'seq_spaces(n,c)'
        '[@seq_spaces, n, c]'
      else
        xxx "[#{@num}] Bad list in format_args_call:", list

    _.map(list, t).join ', '

  format_args_case: (list)->
    t = (v)=>
      if v in "cmnt"
        v
      else if v.match /^(?:flow|block)/
        "'#{v}'"
      else
        xxx "[#{@num}] Bad list in format_args_case:", list

    _.map(list, t).join ', '

  get_comments: (spec)->
    comments = {}
    lines = spec.split "\n"
    while (line = lines.shift())?
      if m = line.match /^# \[(\d+)\]/
        num = m[1]
        comments[num] = line + '\n'
        while (line = lines.shift())?
          break unless line.match /^# /
          comments[num] += line + '\n'
    comments


module.exports =
  coffee_generator_class: YamlGrammarCoffeeScriptGenerator

