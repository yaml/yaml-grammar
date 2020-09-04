yaml = require 'yaml'

class YamlGrammarPerlGenerator
  constructor: (spec)->
    @spec = yaml.parse spec
    @comments = @get_comments spec

  num: 0
  grammar: ''
  arg: false

  gen_grammar: (top)->
    @out @gen_grammar_head top

    for name in _.keys(@spec)
      continue if name[0] == ':'
      @out @gen_rule(name)

    @out @gen_grammar_tail()

    @grammar

  gen_grammar_head: (top)->
    name = @rule_name top
    """\
    ###
    # This grammar class was generated from https://yaml.org/spec/1.2/spec.html
    ###

    use v5.12;
    package Grammar;
    use Prelude;

    sub TOP {
      my ($self) = @_;
      $self->func('#{name}');
    }
    name 'TOP', \\&TOP;
    \n\n
    """

  gen_grammar_tail: (top)->
    """
    1;
    """

  gen_rule: (name)->
    num = "#{sprintf "%03d", ++@num}"
    comment = @comments[num]
    rule_name = @rule_name name
    debug_args = @gen_debug_args name
    rule_args = @gen_rule_args name
    rule_args if rule_args.match /,/
    rule_body = @indent(@gen @spec[name])

    """\
    #{comment}
    sub #{rule_name} {
      my #{rule_args} = @_;
      debug1("#{rule_name}"#{debug_args});
    #{rule_body};
    }
    name '#{rule_name}', \\&#{rule_name};




    """

  gen_rule_args: (name)->
    rule = @spec[name] or XXX name
    return '($self)' unless _.isPlainObject rule
    args = rule['(...)']
    return '($self)' unless args?
    delete rule['(...)']
    @args = args
    args = [ args ] unless _.isArray args
    args = _.map args, (a)-> "$#{a}"
    args.unshift '$self'
    "(#{args.join ', '})"

  gen_debug_args: (name)->
    rule = @spec[name] or XXX name
    return '' unless _.isPlainObject rule
    args = rule['(...)']
    return '' unless args?
    args = [ args ] unless _.isArray args
    args = _.map args, (a)-> "$#{a}"
    str = ',' + args.join(', ')
      .replace /\ /g, ''
      .replace /^\(\)$/, ''

  gen: (rule)->
    if _.isPlainObject rule
      return @gen_from_hash rule

    if _.isArray rule
      return @gen_from_array rule

    if _.isString rule
      return @gen_from_string rule

    if _.isNumber rule
      return "#{rule}"

    if rule == null
      return 'undef'

    xxx "[#{@num}] unknown rule type", rule

  gen_from_hash: (rule)->
    set = rule['(set)']

    keys = _.keys rule
    if keys.length > 1 and not set?
      XXX ["[#{@num}] unknown keys", keys]

    key = keys[0]
    val = rule[key]

    if m = key.match /^\(\{(.)\}\)$/
      return @gen_rep val, m[1], m[1]

    if m = key.match /^(([bcls]|n[bs]|in|seq)[-+][-+a-z]+)$/
      return @gen_call key, val

    switch key
      when '(any)'  then return @gen_group val, 'any'
      when '(all)'  then return @gen_group val, 'all'
      when '(---)'  then return @gen_group val, 'but'

      when '(+++)'  then return @gen_rep val, 1, 0
      when '(***)'  then return @gen_rep val, 0, 0
      when '(???)'  then return @gen_rep val, 0, 1

      when '(<<<)'  then return @gen_may val
      when '(===)'  then return @gen_chk val, '='
      when '(!==)'  then return @gen_chk val, '!'
      when '(<==)'  then return @gen_chk val, '<='

      when '(+)'    then return @gen_add val
      when '(-)'    then return @gen_sub val
      when '(<)'    then return @gen_lt val
      when '(<=)'   then return @gen_le val

      when '(case)' then return @gen_case val
      when '(flip)' then return @gen_flip val
      when '(max)'  then return @gen_max val
      when '(if)'   then return @gen_if val, set
      when '(set)'  then return @gen_set val
      when '(ord)'  then return @gen_ord val
      when '(len)'  then return @gen_len val
      when '(exclude)' then return @gen_exclude val

      else xxx "[#{@num}] unknown hash rule", rule, @num

  gen_from_array: (rule)->
    if rule.length == 2 and rule[0].match /^x/
      [x, y] = rule
      return "$self->rng(\"\\x{#{x[1..]}}\", \"\\x{#{y[1..]}}\")"

    xxx "[#{@num}] Unknown array rule type", rule

  gen_from_string: (rule)->
    if m = rule.match /^x([0-9A-F]+)$/
      return "$self->chr(\"\\x{#{m[1]}}\")"
    if rule.match(/^(?:b|c|e|l|nb|ns|s)(?:[-+][a-z0-9]+)+$/)
      return "$self->func('#{@rule_name rule}')"
    if rule.length == 1
      if rule == "'"
        return "$self->chr(\"'\")"
      if rule == "\\"
        return "$self->chr(\"\\\\\")"
      if @arg
        if rule in ['m', 't']
          if not(rule in @args)
            return "$self->#{rule}"
        return "$#{rule}"
      return "$self->chr('#{rule}')"
    if rule.match(/^(flow|block)-(in|out|key)$/) or
      rule in ['auto-detect', 'strip', 'clip', 'keep']
        return '"' + rule + '"'
    if m = rule.match /^<(\w.+)>$/
      return "$self->func('#{@rule_name m[1]}')"
    if rule == '(match)'
      return "$self->func('match')"

    xxx "[#{@num}] Unknown string rule type", rule

  gen_group: (list, kind)->
    out = "$self->#{kind}(\n"
    for item in list
      out += @indent(@gen(item)) + ",\n"
    out += ")"
    out

  gen_rep: (rule, min, max)->
    out = @gen(rule)

    if out.match(/\n/)
      out = "\n#{@indent(out)}"
    else
      out = " #{out}"

    min = "$#{min}" unless _.isNumber min
    max = "$#{max}" unless _.isNumber max

    "$self->rep(#{min}, #{max},#{out})"

  gen_call: (call, args)->
    args = [ args ] unless _.isArray args

    list = _.map args, (arg)=> @gen_arg arg
    list = _.join list, ', '

    "[ $self->func('#{@rule_name call}'), #{list} ]"

  gen_arg: (arg)->
    @arg = true
    arg = @gen arg
    @arg = false
    arg

  gen_may: (rule)->
    "$self->may(\n#{@indent @gen rule}\n)"

  gen_chk: (rule, kind)->
    "$self->chk('#{kind}', #{@gen rule})"

  gen_case: (obj)->
    out = "$self->case($#{obj.var}, {\n"
    delete obj.var
    for key, val of obj
      rule = @gen(val)
        .replace(/\s+/g, ' ')
        .replace(/,\ \)/, ' )')
      out += @indent "'#{key}' => #{rule},\n"
    out += "})"
    out

  gen_flip: (obj)->
    out = "$self->flip($#{obj.var}, {\n"
    delete obj.var
    for key, val of obj
      rule = @gen_arg val
      out += "  '#{key}' => #{rule},\n"
    out += "})"
    out

  gen_max: (max)->
    "$self->max(#{max})"

  gen_if: (cond, set)->
    "$self->if(#{@gen(cond)}, #{@gen_set(set)})"

  gen_set: ([vari, expr])->
    "$self->set('#{vari}', #{@gen(expr)})"

  gen_ord: (expr)->
    "$self->ord(#{@gen expr})"

  gen_len: (expr)->
    "$self->len(#{@gen expr})"

  gen_exclude: (rule)->
    "$self->exclude(#{@gen rule})"

  gen_add: ([x, y])->
    "$self->add(#{@gen x}, #{@gen y})"

  gen_sub: ([x, y])->
    "$self->sub(#{@gen x}, #{@gen y})"

  gen_lt: ([x, y])->
    "$self->lt(#{@gen_arg x}, #{@gen_arg y})"

  gen_le: ([x, y])->
    "$self->le(#{@gen x}, #{@gen y})"

  out: (text)->
    @grammar += text

  indent: (text, n=1)->
    text.replace(/^(.)/gm, "#{_.repeat('  ', n)}$1")

  rule_name: (name)->
    name.replace /[-+]/g, '_'

  get_comments: (spec)->
    comments = {}
    lines = spec.split "\n"
    while (line = lines.shift())?
      if m = line.match /^:(\d+):/
        num = m[1]
        key = "#{num}"
        comments[key] = "# [#{num}]\n"
        while (line = lines.shift())?
          break unless line.match /^# /
          comments[key] += line + '\n'
    comments


module.exports =
  generator_class: YamlGrammarPerlGenerator

# vim: set sw=2:
