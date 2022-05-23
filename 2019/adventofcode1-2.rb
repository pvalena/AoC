#!/usr/bin/env -S ruby

require_relative 'class'

class R

  def initialize
    # data
    a = \
      inp {
        |x, i|

        x.to_i

      } - ['']

    b = \
    Benchmark.measure {
      run a
    }

    deb :b, b.real
  end

  def run a
    # init

    s = 0

    a.each {
      |m|

      n = fuel(m)

      t = 0

      while n > 0
        ass :n, n

        t += n
        n = fuel(n)
      end

      s += t
    }

    @r = s
  end

  def fuel m
    f = m / 3 - 2

    f > 0 ? f : 0
  end

  def fin r

    r
  end

  def to_s
    r = fin @r
    r.to_s
  end   
end

#DEB = false

res R.new
