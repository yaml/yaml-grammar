require 'ingy-prelude'

global.timer = (start=null)->
  if start?
    time = process.hrtime(start)
    time[0] + time[1] / 1000000000
  else
    process.hrtime()

# vim: sw=2:
