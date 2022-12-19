#!/usr/bin/env -S ruby

DEB = false

require_relative 'class'

class R

  def initialize

#    @s = arg.to_i
    @t = 30
    @s = :AA

    a = {}

    inp(s: false) {
      |x, i|

      #next if x == '->'

      #(to_i x.split(?,)).reverse!

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

      #x = eval x
      #x = to_sym x
    }

    ben {
      @r = run a
    }
  end

  def run a, t = @t, s = @s

    deb :a, a.size, s, t

    @m = 1450

    play(a, s, t)
  end

  def play a, x, t, v = [], c = 0, r = {}

    deb :play, x, t, v

    t -= 1
    unless t > 0
      #print '.' unless DEB

      if c > @m
        deb :r, r
        deb :c, c, o: true
        @m = c
      end

      return 0
    end

    i = [x, t, v.sort]

    return r[i] if r[i]

    m = 0
    w = a[x]

    unless v.include?(x) || w[0] <= 0

      f = t * w[0]

      s = f + play(a, x, t, v + [x], c + f, r) 

      m = s
      # if s > m
    end

    w[1].shuffle.each {
      |g|
      g = play(a, g, t, v, c, r)

      m = g if g > m
    }

    #deb :ri, i, m

    r[i] = m
    m
  end

  def out(w, s = [], wc: '#'.colorize(:cyan), sc: 'X'.colorize(:green))

    return unless DEB

    w = dcl w
    s = dcl s

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

    super(a, w, b: false, h: false)
  end
end

res R.new
