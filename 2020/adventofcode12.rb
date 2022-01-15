#!/usr/bin/ruby -W0

require_relative 'class'

class R
  def initialize
    @z = inp {
      |x, i|

      [x[0].to_sym, x[1..].to_i]
    }

    @c = [0, 0]

    @r = [:W, :N, :E, :S]
    @d = 2
  end

  def nex i, z = @z, d = @d, c = @c, r = @r
    i, v = i

    deb i, v

    case i
      when :F
        d = r[d]
        nex [d, v]


      when :N
        c[1] -= v

      when :S
        c[1] += v

      when :E
        c[0] -= v

      when :W
        c[0] += v


      when :L
        rot(-v)

      when :R
        rot v


      else
        err :u, i, v

    end
  end

  def rot v,  d = @d, r = @r
    err :R, v unless v % 90 == 0

    v /= 90

    n = d + v
    n += r.size if n < 0
    n %= r.size

    @d = n
  end

  def run z = @z, r = @r
    while z.any?
      nex z.shift
    end

    @c.map(&:abs).sum
  end
end

DEB = false

res R.new.run
