// Generated by CoffeeScript 2.5.1
(function() {
  require('ingy-prelude');

  global.ENV = process.env;

  global.name_ = function(name, func, trace) {
    func.trace = trace || name;
    return func;
  };

  global.isNull = _.isNull;

  global.isBoolean = _.isBoolean;

  global.isNumber = _.isNumber;

  global.isString = _.isString;

  global.isFunction = _.isFunction;

  global.isArray = _.isArray;

  global.isObject = _.isPlainObject;

  global.typeof_ = function(value) {
    if (_.isNull(value)) {
      return 'null';
    }
    if (_.isBoolean(value)) {
      return 'boolean';
    }
    if (_.isNumber(value)) {
      return 'number';
    }
    if (_.isString(value)) {
      return 'string';
    }
    if (_.isFunction(value)) {
      return 'function';
    }
    if (_.isArray(value)) {
      return 'array';
    }
    if (_.PlainisObject(value)) {
      return 'object';
    }
    return xxx([value, typeof value]);
  };

  global.stringify = function(o) {
    if (o === "\ufeff") {
      return "\\uFEFF";
    }
    if (isFunction(o)) {
      return `@${o.name}`;
    }
    if (isObject(o)) {
      return JSON.stringify(_.keys(o));
    }
    if (isArray(o)) {
      return `[${(_.map(o, function(e) {
        return stringify(e);
      })).join(',')}]`;
    }
    return JSON.stringify(o).replace(/^"(.*)"$/, '$1');
  };

  global.die_ = function(msg) {
    return die((new Error().stack) + "\n" + msg);
  };

  global.debug = function(msg) {
    return warn(`>>> ${msg}`);
  };

  global.debug1 = function(name, ...args) {
    if (!ENV.DEBUG) {
      return;
    }
    args = _.join(_.map(args, function(a) {
      return stringify(a);
    }, ','));
    return debug(`${name}(${args})`);
  };

  global.dump = function(o) {
    return require('yaml').stringify(o);
  };

  global.xxxxx = function(...o) {
    WWW(o);
    return die('xxxxx');
  };

  global.timer = function(start = null) {
    var time;
    if (start != null) {
      time = process.hrtime(start);
      return time[0] + time[1] / 1000000000;
    } else {
      return process.hrtime();
    }
  };

  // vim: sw=2:

}).call(this);
