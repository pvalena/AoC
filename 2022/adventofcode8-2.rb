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
    v = 0

    a.each_with_index {
      |q, qi|

      q.each_with_index {
        |g, gi|

        r = scene a, qi, gi
        #r = scene a, 3, 2

        dss :run, qi, gi, r

        #err :r, v, r

        v = r if r > v

      }
    }

    @r = v
  end

  def scene a, x, y
    v = 1

    v *= play a, x, y, -1,  0
    #deb :up, x, y, v

    v *= play a, x, y,  0, -1
    #deb :left, x, y, v

    v *= play a, x, y,  1,  0
    #deb :down, x, y, v

    v *= play a, x, y,  0,  1
    #deb :right, x, y, v

    v
  end

  def play a, x, y, xi, yi

    m = a[x][y]
    v = 0

    loop do
      x += xi
      y += yi

      #dss xi, yi, a[x][y], x, y 

      break unless a[x] && a[x][y] && x >= 0 && y >= 0

      z = a[x][y]
      v += 1

      #deb :play, x, y, z, m, v

      break if z >= m
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
