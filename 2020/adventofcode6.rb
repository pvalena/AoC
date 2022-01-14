#!/usr/bin/ruby -W0

require_relative 'class'

z = inp(false) {
  |x, i|

  sym x
}

def val v
  return v.uniq.size
end

c = []
q = 0

z.each {
  |v|

  if iss v
    c << v

  elsif v.any?
    c += v

  else
    q += val c

    c = []

  end
}

q += val c

res q
