#!/usr/bin/env -S ruby

require_relative 'class'

class R

  def initialize
    # data
    a = \
    inp(true, false) {
      |x, i|

      unless x.split.first == 'move'
        x = x.split('')
        n = -1
        w = x.size / 3

        1.upto(w).map {
          |g|
          g = g * 4 - 3

          y = x[g]

          # deb :g, "#{g}, #{n}", y, q

          next if y.nil? or y.empty? or y == ' '

          to_sym(y)
        }
      else
        x = x.split

        to_i [ x[1], x[3], x[5] ]
      end
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
    q = []

    while a.any?
      n = a.pop

      break if n.empty?  

      q << n      
    end

    q.reverse!

    a.pop

    ass :run, a, q

    x = []

    a.each_with_index.map {
      |b, i|

      b.each_with_index.map {
        |v, j|

        next if v.nil?

        x[j] ||= [] 
        x[j] << v
      }
    }

    x.each {
      |z|
      z.reverse!
    }

    # loop
    q.each_with_index {
      |m, mi|

      s += 1 if play x, *m
    }

    @r = x
  end

  def play a, n, f, t
    dss :play, n, f, t

    n.times {
      move a, f, t
    }
  end

  def move a, f, t

    f -= 1
    t -= 1

    a[t] << a[f].pop
  end

  def out a
    pra(a, 1) {
      |z, y|
      case z
        when nil; ' '
        else
          y
      end
    }
  end

  def fin r
    r.map {
      |x|
      x.pop
    }.join
  end

  def to_s
    r = fin @r
    r.to_s
  end   
end

#DEB = false

res R.new
