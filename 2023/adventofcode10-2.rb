#!/usr/bin/env -S ruby

DEB = false

require_relative 'class'

class R
  def initialize

    puts
    @a = arg

    n, s, g, t = nil
#    n = false
#    s = false
    g = false
#    t = false

    a = []
    f = true

    a = \
    inp(n, s, g, t) {
      |x, i|

#      err :inp, x

        #eval x
#      x.to_i
#      if f
#        f = false
      w = to_sym(x)
#      else
#        x.to_sym
#      end

      w.map {
        |x|

        if x[0] == ?.
          x[0]
        else
          N.include?(x[0]) && x[0].to_i || x.to_sym
        end
      }

#        dss :inp, z, isi?(z) || i == 0
#
#      case i
#        when 0
#          x.split('').map {
#            |w|
#
#            N.include?(w) && w.to_i || w.to_sym
#
#          } #.map(&:to_i)
#
#        when 1
#
#          x.to_i
#
#      else
#
#        err :inp, x
#
#      end
#
    }

    ben {
      @run = run a
    }
  end

  # cons
  Q = {
    :|  => [[-1, 0], [1,  0]],
    :-  => [[0, -1], [0,  1]],
    :L  => [[-1, 0], [0,  1]],
    :J  => [[-1, 0], [0, -1]],
     7  => [[0, -1], [1,  0]],
    :F  => [[1,  0], [0,  1]],
    '.' => [],
  }

  L = [:-, :|]
  C = [7, :J, :F, :L]
  J = -1

  def run a
#    err :a, a
    ini

    # part 1
    b, c, z = sea a

    # starting point
    f = sta b, c, z

    # main loop
    z.each_with_index {
      |w, i|

      f = mov f, w, b, z
    }

    # postprocess
    w = b.keys - z

    out b, w
    deb :w, w.size

    w = gro b, w

    # result
    w.size

    #def b.[](i)
    #  err :oor, i if isi?(i) && i < 0
    #  super(i) || 0
    #end
  end

  def gro b, w

    g = dcl w

    while g.any?

      c = g.shift

      D.each {
        |o|

        n = nex c, o

        next if b[n]

        b[n] = true

        g << n
        w << n
      }

    end

    out b, w, o: true

    w
  end

  def mov f, w, b, z
 
    v = b[w]

    ass :v, v, w, Q[v], f, z.last

    r = D - Q[v]

    r.map! {
      |s|

      nex w, s
    }

    n = \
    r.select {
      |s|

      f.any? {
        |g|

        man(g, s) <= 1
      }
    }

    ###

    o = n

    ns = n.size

    if C.include?(v)

      if n.empty?

        z = rem w, v

        fa = \
        f.any? {
          |g|

          man(g, z[0]) <= 1
        }

        if z.one? && fa

          n = z

        else

          out b, z

          err :e, v, z, f

        end

      elsif ns == 1 && (n & r).any?

        n = r

      else

        out b, n

        err :c, v, n, r, f

      end

    elsif L.include?(v)

      if ns > 1
#        n = n & f

        err :ns, v, n, r, f
      end

    end

    ###

    ns = n.size

    n.each {
      |s|

      b[s] ||= true
    }

#    out b, n, o: true#, b: true

    d = [v, n, o]

    ###

    err :n, d, w, f, r if n.empty?

    err :a, d unless \
      f.any? {
        |g|

        n.any? {
          |s|

          man(g, s) <= 1
        }
      }

    if L.include?(v)

      err :m, d if ns > 1

    elsif C.include?(v)

      err :c, d if ns > 1 && n != r

    else

      err :t, d

    end

#    deb :mov, d, l: true

    n
  end

  def ini
    Q.each {
      |k, q|

      q.sort!
    }
  end
  
  def sta b, c, z
    v = b[c]
    q = c.dup.map { |w| -w } 

    err :S, v, q, c unless v == :S

    o = [nex(z[-2], q), nex(q, z.first)].sort

    q, _ = \
    Q.detect {
      |_, w|

      w == o
    }

    ass :q, q, Q[q], o

    b[c] = q

    out b, [c]
    deb :S, q, c

    f = nil

    loop do
      f = z.first.dup

      v = b[f]

      unless L.include?(v)
        out b, [f]

        c = f #ref

        deb :rot, v, f

        z.rotate!
        next
      end

      case
        when c[0] == f[0]
          f[0] += J

        when c[1] == f[1]
          f[1] += J

      else

        out b, [c, f]
        err :idk, v

      end

      break
    end

    b[f] ||= true

    f = [f]

    out b, f, J, o: true
    deb :f, f, o: true

    f
  end

  def rem w, v
    q = \
    Q[v].map {
      |g|

      nex w, g
    }

    z = []

    q.each {
      |g, _|

      q.each {
        |_, s|

        z << [g, s]
      }
    }

    z -= q + [w]
  end

  def sea a

    b = {}
    c = nil

    a.each_with_index {
      |w, i|

      w.each_with_index {
        |g, j|

        r = [i, j]

        b[r] = g

        c = r if g == :S
        
#        err :r, r, g

      }
    }

    q = \
    D.map {
      |o|

      x = nex c, o

      rcs(b, x, c)
    }

    z = nil
    s = 0

    q.each_with_index {
      |w|

      next unless w

      ws = w.size

      if ws > s
        z = w
        s = ws
      end
    }

    n = {}

    z.each {
      |w|

      n[w] = b[w]
    }

    out b, z
    deb :z, z.size

    [n, c, z]
  end

  def out a, s = [], t = [], **h

#    t = [t]

    f = a.keys

    t = \
    a.keys.select {
      |g|

      a[g] != true
    }
    
    t -= s
#    s -= f

#    s = s.keys
#    t = t.keys if ish?(t)

    fc = '.'.colorize :green
    sc = 'x'.colorize :red
    tc = '#'.colorize :cyan

    @outc = nil

    super(f, s, t, fc: fc, sc: sc, tc: tc, d: 1, h: false, **h) {
      |g, h|

      a[[g, h]].to_s.colorize :cyan
    }
  end

  def rcs a, k, l = nil, r = [], &b

    v = a[k]

    return unless v

    if v == :S
      r << k
    
      return r
    end

    d = Q[v]

    ass :d, d, v, k

    d = \
    d.map {
      |o|

      nex k, o
    }

    if r.any?
      unless d.include?(r.last)
        err :v, v, d, r.last, k
      end

      d -= r

    else
      d -= [l]

    end

#    err :k, k, v, d

#    r = r.dup
    r << k

#    deb :x, k, v, d, l: true

    d.each {
      |x|

      z = \
      rcs a, x, k, r, &b

      return z if z
    }

    return
  end

  class O
    attr_reader :h
  
    def initialize(h, b)
      @h = h
      @b = b
    end

    def <=> other
      o = other.h

      @h.each_with_index {
        |v, i|

        v = V[ v ]
        w = V[ o[i] ]

        ass :vw, v, w

        r = v <=> w

        next if r == 0

#        deb :cmp, @h, o, r, l: true
        return r
      }

      err :idk, o, @h, l: true
    end

    def to_i
      @b
    end
  end

#  def sea b, k
#
#    f = \
#    are(b, k, n: true) {
#      |x, v|
#
#      err :v, x, v, l: true
#
#      next unless v
#
#      deb :v, x, v, l: true
#
#      v
#    }
#
#    err :f, f
#
#    f.map! {
#      |v|
#
#      v.sort!
#
#      v.inject('') {
#        |s, w|
#
#        s + w[1].to_s
#
#      }.to_i      
#    }
#
#    deb :sea, k, f
#
#    f[0] * f[1]
#  end
end

res
