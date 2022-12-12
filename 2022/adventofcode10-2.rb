#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

class R

  def initialize
    # data
    a = \
    inp {
      |x, i|

      case i
        when 0; x.to_sym
        when 1; x.to_i

        else 
          err :inp, x, i
      end        
      #x.split('')
    }

    b = \
    Benchmark.measure {
      run a
    }

    deb :b, b.real, o: true
  end

  def run a
    # init
    w = [1, 1, []]

    a.each_with_index {
      |q, qi|

      #dss :run, q

      w = play q, w, qi

#      print '.' unless DEB || qi % 100 != 0

    }

#    puts unless DEB

#    out w.last

    puts

    @r = w.last.size
  end

  W = 40

  def play q, w, qi
    x, c, l = w
    i, v = q

    #dss :play, q, [x, c]

    l = lit x, c, l, qi

    if i == :addx
      c = c % W + 1

      l = lit x, c, l, qi

      x += v
    end

    [x, c % W + 1, l]
  end

  def lit x, c, l, qi

    #dss :l, c, x, qi

    (-1..1).detect {
      |z|
      l[c-1] = true if (x + z) == c - 1
    }

    if W == c
      out l
      []
    else
      l
    end
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
