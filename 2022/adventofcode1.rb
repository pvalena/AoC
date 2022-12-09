#!/usr/bin/env -S ruby

require_relative 'class'

class R

  def initialize
    # data
    a = \
      inp(false) {
        |x, i|

        x.to_i
      }

    b = \
    Benchmark.measure {
      run a
    }

    deb :b, b.real
  end

  def run a
    # init
    z = []
    s = 0

    # loop
    a.each {
      |m|

      if m == []
        z << s
        s = 0
        next
      end

      s += m
    }

    @r = z
  end

  def fin_part_1 r
    r.max
  end

  def fin r
    r.sort.last(3).sum
  end

  def to_s
    r = fin @r
    r.to_s
  end   
end

#DEB = false

res R.new
