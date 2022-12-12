#!/usr/bin/env -S ruby

require_relative 'class'

class R

  def initialize
    # data
    a = \
    inp {
      |x, i|

      to_i x.split('')
    }

    b = \
    Benchmark.measure {
      run a
    }

    deb :b, b.real
  end

  def run a
    # init
    v = []
    l = a.first.size - 1
    h = a.size - 1

    a.each_with_index {
      |q, qi|

      break if q.empty?

      v += play a, qi, 0, 0,  1
      v += play a, qi, l, 0, -1

      q.each_with_index {
        |g, gi|

        v += play a, 0, gi,  1, 0
        v += play a, h, gi, -1, 0

      }
    }

    v.uniq!

    #err :v, v.sort, v.size

    @r = v.size
  end

  def play a, x, y, xi, yi, m = -1

    v = []

    while a[x] && a[x][y] do

      z = a[x][y]

#      deb :p, x, y, m, z

      if z > m
        v << [x, y]
        m = z
      end

      x += xi
      y += yi
    end

    v
  end

  def fin r
    #err :r, r if r >= 31148261
    r
  end

  def to_s
    r = fin @r
    r.to_s
  end   
end

#DEB = false

res R.new
