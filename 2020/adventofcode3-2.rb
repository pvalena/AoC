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

def enc z, r, d = 1
  i = 0
  v = 0

  z[1..].each_with_index {
    |l, j|

    next if d > 1 && j % d == 0

    i += r

    i %= l.size

    v += 1 if l[i]
  }

  v
end

r = 1

[1,3,5,7].each {
  |n|
  r *= enc(z, n)
}

r *= enc z, 1, 2

res r
