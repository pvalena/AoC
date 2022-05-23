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

    s = \
    a.inject(0) {
      |t, m|

      t += fuel m
    }

    @r = s
  end

  def fuel m
    m / 3 - 2
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
