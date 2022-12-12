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
    w = [1, 1, 0]

    a.each_with_index {
      |q, qi|

      dss :run, q, w

      w = play q, w

      print '.' unless DEB || qi % 100 != 0

      #err :r, v, r
    }

    puts unless DEB

    @r = w.last
  end

  def str x, c, i

    f = \
    [c, c+1].detect {
      |d|

      d >= 20 \
      && (d-20) % 40 == 0 \
      && (d == c || i == :addx)
    }

    f ? (f * x) : 0 
  end

  def play q, w
    x, c, s = w
    i, v = q

    s += str x, c, i

    if i == :addx
      x += v
      c += 1
    end

#    deb :play, q, x, s

    [x, c+1, s]    
  end


  def out v
    return unless DEB

    z = v.inject([0, 0, 0, 0]) {
      |b, a|

      b[0] = a[0] if a[0] > b[0]
      b[1] = a[1] if a[1] > b[1]

      b[2] = a[0] if a[0] < b[2]
      b[3] = a[1] if a[1] < b[3]

      b
    }

    g = []

    z[2].upto(z[0]) {
      |i|

      g[i-z[2]] ||= []

      z[3].upto(z[1]) {
        |j|

        g[i-z[2]][j-z[3]] = v.include?([i, j])

        #dss :ij, [i, j], g[i][j]
      }
    }

    #dss :g, z, g

    pra(g, 0) {
      |y, w|
      y ? '#' : ' '
    }
  end

  def to_s
    @r.to_s
  end   
end

res R.new
