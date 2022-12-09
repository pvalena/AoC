#!/usr/bin/env -S ruby

require_relative 'class'

class R

  def initialize
    # data
    a = \
    inp {
      |x, i|

      to_sym(x)
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

    a.each {
      |q|

      break if q.empty?  

      s += play q
    }

    @r = s
  end

  def play a
    s = 0
    q = []

    while a.any?
      n = a.shift

      break if n.nil?

      s += 1
      q << n
      q.shift if q.size > 4

      next if q.size < 4

      dss :play, q, q.uniq.size, s

      break if q.uniq.size == 4
    end

    s
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
