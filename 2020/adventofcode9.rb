#!/usr/bin/ruby -W0

require_relative 'class'

class R
  def initialize
    @z = inp {
      |x, i|

      x.to_i
    }

    @r = 25

    @d = Hash.new([])

    @g = @z.shift(@r)

    @g.each_with_index {
      |x, i|

      @g[(i+1)..].each_with_index {
        |y, j|
        @d[x+y] += [[i, i+1+j]]
      }
    }
  end

  def nex v, w,   g = @g, d = @d, r = @r
    d.each {
      |x, i|

      #err x, i, d[x]

      i.reject! {
        |y|
        y.include? v
      }

      d.delete(x) if i.empty?
    }

    g.shift

    g.each_with_index {
      |n, i|

      d[n+w] += [[v + 1 + i, v + r]]
    }

    g << w
  end

  def val v, w,  z = @z, d = @d, r = @r

    w unless d[w].any?
  end

  def run z = @z, d = @d, g = @g
    z.each_with_index {
      |w, v|

      x = val v, w
      return x if x

      nex v, w
    }
  end
end

res R.new.run
