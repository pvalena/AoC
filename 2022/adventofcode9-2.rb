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

  L = 8

  def run a
    # init
    v = [[0, 0]]

    h = [0, 0]

    k = [ [0, 0] ] * (L+1)
    k = dcl k

    l = [h, k]

    a.each_with_index {
      |q, qi|

      dss :run, q

      play l, q, v

      print '.' unless DEB || qi % 100 != 0

      #err :r, v, r
    }

    v.uniq!

    puts unless DEB

    dss :run, v.size
    out v

    @r = v
  end

  def play l, q, v
    d, n = q
    h, k = l

    d = dir(d)

    r = dcl k[L]

    1.upto(n) do
      n = move(l, d)

      unless r == n
        v << dcl(n)
        r = v.last
      end
    end

    s = [h] + k
    dss :play_s
    out s

    dss :play_v
    out v

    #err :l, l, v if n == 3
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
    h, k = l
    add h, d

    x = (-1..1)
    h = dcl h

    k.each {
      |t|

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

      break if [0,0] == d

      add t, d
      h = t
    }

    deb :move, k[L]

    #out(l, :move)

    k[L]
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
