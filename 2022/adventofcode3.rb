#!/usr/bin/env -S ruby

require_relative 'class'

class R

  def initialize
    # data
    a = \
      inp() {
        |x, i|

        x.to_sym
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
    a.each {
      |m|

      s += spot *m
    }

    @r = s
  end

  def spot x

    s = x.size / 2
    l, r = x[...s], x[s...]

    l, r = to_sym(l), to_sym(r)

    deb :spot, l, r

    m = l & r

    err :s, m unless m.size == 1

    m = m.first

    prio(m)
  end

  VAL = (:a .. :z).to_a + (:A..:Z).to_a

  def prio x
    ass :prio, x, VAL.include?(x)

    VAL.find_index(x) + 1
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
