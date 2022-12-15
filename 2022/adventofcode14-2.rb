#!/usr/bin/env -S ruby

DEB = false

require_relative 'class'

class R

  def initialize

    #@s = arg

    a = \
    inp() {
      |x, i|

      next if x == '->'

      (to_i x.split(?,)).reverse!

      #err :ix, i, x

      #x = eval x

      #x = x.gsub(/[,:]/,' ').split

      #x = to_sym x
    }

    @s = [0, 500]
    @d = true

    ben {
      @r = run a
    }
  end

  def run a

    w = dra a

    @n = w.max[0]
    @m = w.map { |(_, x)| x }.max

    o = []
    oo = []
    i = 0
    t = [0, 0]
    a = []
    l = E

    j = 10
    f = 1000

    # skip-frames + 1
    e = 1

    while true
      if (i % j == 0) || a.empty?
        s = san(w + oo, o)

        break unless s || @s == s
        a << s
      end

      a.map! {
        |s|

        san(w + oo, o, s)
      }

      a -= [nil]

      if @d && i % e == 0
        out w, (o + a), oo, b: true
        sleep 0.1
      end

      i += 1

      if @d && i % 100 == 0
        m = (o + oo).max[0]

        q = \
        o.select {
          |z|

          z[0] == m

        }

        if q.size == 1 && q[0] == t
          o -= q
        end

        t = q[0]
      end
      
      if @d && i % f == 0 && i > 0

        #j -= 1 if j > 2 && i % f * 3 == 0

        oo += o
        o = oo.pop(200)

        oo.uniq!
        o.uniq!
        
        #err :o, o.size, oo.size, j, i if oo.size > 0
      end
    end

    out w, o+oo

    (oo+o).size + 1
  end

  def san w, o, s = nil, n = @n
    s ||= dcl @s

    r = s

    s = rux( w + o, s )

    unless r != s && s[0] < n + 1
      o << s
      return
    end

    s
  end

  R = [[1, 0], [1, 0], [1, -1], [1, 1]]

  def rux w, s
    #dss :rux, s

    R.shuffle.each {
      |x|

      n = [ s[0] + x[0], s[1] + x[1] ]

      return n unless w.include?(n)
    }

    s
  end

  def out(w, o = [], oo = [], h: false, b: false, l: nil)
    w = dcl w
    o = dcl o
    oo = dcl oo
    s = dcl @s

    m = [0, 0]
    n = [E, E]
    d = 2

    if @d
      k = o.map { |(_, x)| x }

      kd = k.min - d*2
      kd = 0 if kd < 0

      w += lin([@n+d, kd], [@n+d, k.max+d*2])

      l = o.max[0]

      w.select! {
        |(x, _)|

        x < l + d
      }

      oo.select! {
        |(x, _)|

        x < l + d
      }
    end

    o += oo

    w += o
    w << s
  
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

    o = w.last(o.size + 1)
    s = o.pop

    #err :o, o.size
    
    #err :w, w

    x, y = m[0] - r + d, m[1] - c + d

    a = [ [ '#'.colorize(:cyan) ] * y ] * x
    a = dcl a

    set(a, s, @d ? ' ' : :+)

    o.each {
      |g|
      set(a, g, 'o'.colorize(:white))
    }

    super(a, w, h: h, b: b, o: true)
  end
end

res R.new
