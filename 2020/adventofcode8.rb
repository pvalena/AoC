#!/usr/bin/ruby -W0

require_relative 'class'

z = inp {
  |x, i|

  i == 1 ? x.to_i : x.to_sym
}

v = []
i = 0
a = 0

while !v.include? i
  v << i

  c, n = z[i]

#  deb c, n, v

  case c
    when :nop
      i += 1

    when :acc
      a += n
      i += 1

    when :jmp
      i += n

    else
      err c, n

  end

end

deb i, z[i]

res a
