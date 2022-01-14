#!/usr/bin/ruby -W0

require_relative 'class'

z = inp {
  |x, i|

  x = x.gsub /[,.]/, ''

  next if %w{bags bag other contain}.include? x

  (i > 1 && i % 4 == 0) ? x.to_i : x.to_sym

}.map {
  |l|
  l - [nil]
}

t = {}
o = -1

while o != t.size
  o = t.size

  z.each {
    |v|
    v = dcl v

    r = v.shift(2)

    next if t[r]

    while v.any?
      l = v.shift
      f = v.shift(2)

      t[r] = 0 if l == 0 && f.empty?
    end
  }
end

o = -1
n = [:shiny, :gold]

while o != t.size && !t[n]
  o = t.size

  z.each {
    |v|
    v = dcl v

    r = v.shift(2)

    next if t[r]

    d = true
    s = 0

    while v.any?
      l = v.shift
      f = v.shift(2)

      unless t[f]
        d = false
        break
      end

      err r, l, f, t[f] if iss t[f]

      s += l + l * t[f]
    end

    t[r] = s if d
  }
end

deb t

res t[n]
