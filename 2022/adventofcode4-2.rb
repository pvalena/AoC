#!/usr/bin/env -S ruby

require_relative 'class'

class R

  def initialize
    # data
    a = \
      inp {
        |x, i|

        x = \
        x.split(?,).map {
          |y|
          to_i y.split(?-)
        }
      }

    b = \
    Benchmark.measure {
      run a
    }

    deb :b, b.real
  end

  def run a
    # init
    s = 0

    # loop
    a.each_with_index {
      |m, mi|

      s += 1 if play *m
    }

    @r = s
  end

  def play l, r
    ins(l,r) || ins(r,l)
  end

  def ins l, r
    ( l[0] <= r[0] && r[0] <= l[1] ) \
      || \
    ( l[0] <= r[1] && r[1] <= l[1] ) \
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
