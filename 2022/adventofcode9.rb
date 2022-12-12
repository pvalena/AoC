#!/usr/bin/env -S ruby

DEB = false

require_relative 'class'

class R

  def initialize
    # data
    a = \
    inp {
      |x, i|

      s = x.to_sym

      if (:A..:Z).include?(s)
        s
      else
        x.to_i
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
    v = [[0, 0]]
    l = [ [0, 0] ] * 2
    l = dcl l

    a.each_with_index {
      |q, qi|

      #dss :run, qi, q

      play l, q, v

      print '.' unless DEB || qi % 100 != 0

      #err :r, v, r
    }

    v.uniq!

    puts unless DEB

    out v, :run

    @r = v
  end

  def play l, q, v
    d, n = q

    d = dir(d)

    #dss :play, d, n, l

    1.upto(n) do
      move(l, d)

      v << dcl(l[1])
    end

    #err :l, l, v

    #out(v, :play) if DEB
  end

  def dir x
    case x
      when :L; [ 0, -1]
      when :R; [ 0, +1]
      when :U; [-1,  0]
      when :D; [+1,  0]
    end
  end

  def move l, d
    h, t = l

    add h, d

    x = (-1..1)
    d = [0, 0]
    o = [ true, true ]

    x.each {
      |c|
      o[0] = false if h[0] == t[0] + c
      o[1] = false if h[1] == t[1] + c
    }

    o[0] ||= o[1] && h[0] != t[0]
    o[1] ||= o[0] && h[1] != t[1]

    [0, 1].each {
      |y|
      
      if o[y]
        n = h[y] > t[y] ? 1 : -1 

        d[y] = n
      end
    }
    add t, d

    #deb :move, l

    #out(l, :move)
  end

  def out(v, l)
    return unless DEB
    puts "> #{l}"
  
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

  def fin r
    #err :r, r if r >= 31148261
    r.size
  end

  def to_s
    r = fin @r
    r.to_s
  end   
end

res R.new
