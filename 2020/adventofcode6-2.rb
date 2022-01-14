#!/usr/bin/ruby -W0

require_relative 'class'

z = inp(false) {
  |x, i|

  sym x
}

def val v, n
  v.tally.select {
    |w, x|

    x == n

  }.size
end

c = []
q = 0
n = 0

z.each {
  |v|

  if iss v
    c << v
    n += 1

  elsif v.any?
    c += v
    n += 1

  else
    q += val c, n

    c = []
    n = 0
  end
}

q += val c, n

res q
