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
      x.split('').tally

  end
}

res \
z.select {
  |(f, t), r, s|

  n = s[r]
  n ||= 0

  ass f, n, t

  f <= n && n <= t

}.count
