#!/usr/bin/env -S ruby

DEB = false

require_relative 'class'

class R

  def initialize

#    @s = arg.to_i
    @t = 26
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

    @m = 1978

    s = [s, s]

    #deb :a, a.size, s, t, o: true

    #b = play(a, s, t / 2)

    b = 1245

    deb :b, a.size, s, t, b, o: true

    play(a, s, t, l: b)
  end

  def play a, y, t, v = [], r = {}, \
    c = 0, l: nil, h: @t / 2 + 1, h2: @t / 4 * 3

    #deb :play, y, t, v

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

    i = [y, t, v]

    return r[i] if r[i]

    if !l.nil? && t == h

      unless c >= l
        return 0

      end

    end

    m = 0

    o = [[],[]]

    y.each_with_index {
      |x, j|

      w = a[x]

      ass :w, w, y

      unless v.include?(x) || w[0] <= 0

        f = t * w[0]

        o[j] << [f, x, [x]]

      end

      w[1].each {
        |g|

        o[j] << [0, g, []]
      }

      #deb :ri, i, m

    }

    q = []

    o[0].shuffle.each {
      |e|
      
      o[1].shuffle.each {
        |z|

        next if e[0] > 0 && e[0] == z[0] && e[1] == z[1]

        n = [ e[1], z[1] ].sort

        next if q.include?(n)

        q << n

        w = v + z[2] + e[2]
        w.sort!

        s = e[0] + z[0]

        #dss :play, n, t, c+s

        g = s + play(a, n, t, w, r, c + s, l: l, h: h, h2: h2)

        m = g if g > m

      }

    }

    r[i] = m if t < h2
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
