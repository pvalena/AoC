#!/usr/bin/ruby -W0

require_relative 'class'

z = inp {
  |x, i|

  x.split('').map {
    |y|
    case y
      when '.'
        nil

      when '#'
        true

      else
        err :inp, x

    end
  }
}

i = 0
v = 0

z[1..].each {
  |l|

  i += 3

  i %= l.size

  v += 1 if l[i]
}

res v
