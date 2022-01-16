#!/usr/bin/ruby -W0

require_relative 'class'

class R
  def initialize
    @z = inp {
      |x, i|

      [x[0].to_sym, x[1..].to_i]
    }

    @c = [0, 0]
    @w = [10, 1]
  end

  def nex i,  z = @z, d = @d, c = @c, r = @r, w = @w
    i, v = i

    case i
      when :F
        c[0] += w[0] * v
        c[1] += w[1] * v

      when :N
        w[1] += v

      when :S
        w[1] -= v

      when :E
        w[0] += v

      when :W
        w[0] -= v


      when :L
        rot(v, 0)

      when :R
        rot(v, 1)


      else
        err :u, i, v

    end

    #deb i, v, c, @w
  end

  def rot v, i,  w = @w, d = @d, r = @r
    err :R, v unless v % 90 == 0

    v /= 90

    v.times {
      w = [ w[1], w[0] ]

      w[i] *= -1
    }

    @w = w
  end

  def run z = @z, r = @r
    while z.any?
      nex z.shift
    end

    @c.map(&:abs).sum
  end
end

# DEB = false

res R.new.run
