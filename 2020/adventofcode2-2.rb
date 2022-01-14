#!/usr/bin/ruby -W0

require_relative 'class'

z = inp {
  |x, i|

  case i

    when 0
      x.split(?-).map(&:to_i)

    when 1
      x.split(?:)[0]

    else
      x.split('').unshift nil

  end
}

res \
z.select {
  |(f, t), r, s|

  (s[f] == r) ^ (s[t] == r)

}.count
