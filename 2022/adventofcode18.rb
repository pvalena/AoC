#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

class R

  def initialize

#    @s = arg.to_i

    a = \
    inp(s: false) {
      |x, i|

      #next if x == '->'

      #err :inp, x

      unless true
        x = x.gsub(/[,:;]/,' ').split.each_with_index.map {
          |z, i|

          if i == 4
            z
          else
            z.to_sym
          end
        }

        case x[0]
          when :Valve
          
            #dss :x, x

            a[ x[1] ] = [ x[4].split(?=)[1].to_i, x[9..] ]

          else
            err :ix, i, x, @s
        end
      end

      #x = eval x
      #x = to_sym x
      x = (to_i x.split(?,))
    }

    ben {
      @r = run a
    }
  end

  def run a
    dss :run, a.size

    s = []

    a.inject(0) {
      |k, x|

      k + play(x, s)
    }
  end

  def play q, s

    a, b, c = q

    s << q

    D3.inject(0) {
      |k, (x, y, z)|

      t = [ a+x, b+y, c+z ]

      r = s.include?( t )

      unless r
        k + 1
      else
        k - 1
      end
    }
  end

  def chc v, w
    x, y, z = w
    a, b, c = v

    deb :d3, D3

    deb :chc, a == x, b == y, c == z
  
  end

  def out(w, s = [], wc: '#'.colorize(:cyan), sc: '-'.colorize(:green), o: false)

    return unless DEB || o

    w = dcl w
    s = dcl s

    # flip

    w.map! {
      |(x, y)|

      [-x, y]
    }

    s.map! {
      |(x, y)|

      [-x, y]
    }

    m = [0, 0]
    n = [E, E]
    d = 2

    #deb :w, w

    # store
    w += s

    w.each {
      |l|

      [0, 1].each {
        |i|
        m[i] = l[i] if l[i] > m[i]
        n[i] = l[i] if l[i] < n[i]
      }
    }

    r, c = n
    c -= d
    
    w.map! {
      |l|

      [ l[0] - r, l[1] - c ]
    }

    # load
    s = w.last(s.size)

    x, y = m[0] - r + d, m[1] - c + d

    a = [ [ wc ] * y ] * x
    a = dcl a

    #err :w, w.size, s.size

    s.each {
      |g|
      set(a, g, sc)
    }

    super(a, w, b: false, h: false, o: true)
  end
end

res R.new
