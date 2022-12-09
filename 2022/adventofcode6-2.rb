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

      r = play q

      dss :run, r

      s += r
    }

    @r = s
  end

  N = 14

  def play a
    s = 0
    q = []

    while a.any?
      n = a.shift

      break if n.nil?

      s += 1
      q << n

      qs = q.size

      if qs > N
        q.shift

      elsif qs < N
        next

      end

      #dss :play, q, q.uniq.size, s

      break if q.uniq.size == N
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
