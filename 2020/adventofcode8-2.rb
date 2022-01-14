#!/usr/bin/ruby -W0

require_relative 'class'

z = inp {
  |x, i|

  i == 1 ? x.to_i : x.to_sym
}

def go z
  v = {}
  i = 0
  a = 0

  while !v[i] && z[i]
    v[i] = true

    c, n = z[i]

    #deb c, n, v

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

  a if i == z.size
end

a = nil
z.each_with_index {
  |(c, n), i|

  next unless [:jmp, :nop].include? c

  x = dcl z
  x[i][0] = c == :jmp ? :nop : :jmp

  #err i, z, x if i > 0

  #deb :i, i, c, x[i][0]

  a = go x
  break if a
}

res a
