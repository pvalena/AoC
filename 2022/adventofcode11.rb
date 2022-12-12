#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

class R

  def initialize
    # data
    a = []
    n = 0

    inp(true, false) {
      |x, i|

      x = x.gsub(/[,:]/,' ').split

      next if x.empty?

      x = \
      case x[0].to_sym
        when :Monkey
          n = x[1].to_i
          next

        when :Starting
          l = :i
          to_i x[2..]

        when :Operation
          l = :o
          [ x[4].to_sym, x[5].to_i ]

        when :Test
          l = :t
          x[3].to_i

        when :If
          l = x[1] == 'true'
          x[5].to_i

        else 
          err :inp, x, i
      end

      a[n] ||= { s: 0 }
      a[n][l] = x

      nil
    }

    b = \
    Benchmark.measure {
      run a
    }

    deb :b, b.real, o: true
  end

  def run a

    20.times {
      a.each_with_index {
        |q, qi|

        play a, q
      }
    }

    @r = fin a
  end

  def play a, m

    #dss :play, m[:i]

    m[:i].each {
      |i|

      ins a, i, m
    }
    m[:i] = []

  end

  def ins a, i, m
    o, v = m[:o]

    m[:s] += 1

    case o
      when :*
        v = i if v == 0
        err :*, v unless v > 0

        i *= v

      when :+
        err :+, v unless v > 0

        i += v

      else
        err :ins, o, v
    end

    i /= 3

    t = (i % m[:t]) == 0

    n = m[t]

    ass :ins, i, n

    a[n][:i] << i
  end

  def fin a
    mul \
    a.map {
      |x|
      x[:s]

    }.max(2)
  end

  def out v
    g = []

    0.upto(W-1) {
      |i|

      g[i] = v[i] ? '#' : ' '

    }
    puts g.join
  end

  def to_s
    @r.to_s
  end   
end

res R.new
