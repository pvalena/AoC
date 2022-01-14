#!/usr/bin/ruby -W0

require_relative 'class'

z = inp {
  |x, i|

  x = x.gsub /[,.]/, ''

  next if %w{bags bag other contain}.include? x

  i == 4 || i == 8 ? x.to_i : x.to_sym

}.map {
  |l|
  l - [nil]
}

h = []
n = [[:shiny, :gold]]

while n.any?
  c = n
  n = []
  h += c

  c.each {
    |b|

    #deb :b, b, z.size

    z.reject! {
      |v|
      v = dcl v
      r = v.shift(2)
      o = n.size

      while v.any?
        l = v.shift
        f = v.shift(2)

        #deb b, f, b == f, r

        n << r if b == f
      end

      o != n.size
    }

  }

end

h.uniq!
h -= [[:shiny, :gold]]

dar h, 1

res h.size
