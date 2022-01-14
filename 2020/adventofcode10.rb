#!/usr/bin/ruby -W0

require_relative 'class'

class R
  def initialize
    @z = inp {
      |x, i|

      x.to_i

    }.sort

    @r = 3

    @d = {}
  end

  def run z = @z, d = @d, r = @r

    v = 0
    d[1] = 0
    d[2] = 0
    d[3] = 1

    z.each_with_index {
      |x, i|

      f = x - v

      #deb v, x, f

      err :f, x, v, i if f > 3

      d[f] += 1

      v = x
    }

    d[1] * d[3]
  end
end

res R.new.run
