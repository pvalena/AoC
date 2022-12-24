#!/usr/bin/env -S ruby

DEB = false

require_relative 'class'

class R

  def initialize

#    @s = arg.to_i

    a = {}
    n = nil
    s = false

    #a = \
    inp(s: s) {
      |x, i|

      xs = x.map { |z| z.to_sym }
      xi = x.map { |z| z.to_i }

      case s ? x : xs[0]
        when :Blueprint
          n = xi[1]
          a[n] = {}

          c = 2

          #err :xs, xs

          next unless xs[1+c]

        when :Each

          c = 0

          #a[ x[1] ] = [ x[4].split(?=)[1].to_i, x[9..] ]

        else
          err :inp, i, x, @s

      end

      t = xs[1+c]

      a[n][t] ||= []
      a[n][t] += [
          [ xs[5+c], xi[4+c] ],
          [ xs[8+c], xi[7+c] ]
        ]

      a[n][t] -= [[nil,nil]]

      #dss :an, a[n]

      #eval x
      #to_sym x
      #(to_i x.split(?,))

    }

    ben {
      @r = run a.freeze
    }
  end

  def run a
    dss :run, a.size

    #err :a, a #, l: false

    t = 4 unless Process.respond_to?(:fork)

    na = a.dup

    a.keys.each {
      |k|

      na[k] = dec a[k] #, s, r
    }

    a = na

    Parallel.map(a, in_threads: t) {
      |(b, v)|

      r = play v, b

      [b, r]

    }.inject(0) {
      |k, (b, g)|

      k + b * g
    }
  end

  G = :geode
  T = 24
  S = :ore

  def play v, i
    #err :bv, b, v

    r = Hash.new(0)
    r[S] = 1

    s = Hash.new(0)

    @m = 0

    deb :play, i, v.size, o: true

    m = best(i, r, s, v)

    deb :best, i, m, @m, o: true

    m
  end

  def cop h

    h = h.clone

    h.keys.each {
      |k|

      h[k] = h[k].clone
    }

    h
  end

  def best i, r, s, v, t = T, m = 0, b = nil, h = T / 4

    #v = dcl w
    r = cop r
    s = cop s

    if b
      v[b].each {
        |x, n|

        #err :tn, t, n

        s[x] -= n
      }

      #        dss :t, t

      r[b] += 1
    end

    c = bld r, s, v

    mine r, s

    #dss :round, s, r, t

    t -= 1

    if t <= 0
      n = s[G]

      if DEB && @m < n
        @m = n

        deb :m, i, @m
      end

      return n
    end

    if t == h && (n = s[G]) > 0

      return 0 if n < m

      #deb :h, i, n, m

      if m < n
        dss :n, i, m, n, t, o: true

        m = n
      end
    end

    #dss :c, c, s, t

    n = []

    c.each {
      |b|

      n << best(i, r, s, v, t, m, b)
    }

    n << best(i, r, s, v, t, m)

    n.max
  end

  def dec w #, s, r
    t = G
    v = { }

    while w.any? && t
      z = \
      w.keys.detect {
        |k|

        #t.include?(k)
        t == k
      }

      ass :wz, z, w, w[z], v

      v[z] = w[z]

      w = w.except z
      t = nil

      l = dcl v[z]

      while t.nil? && l.any?

        q = max2 l

        x = \
        l.detect {
          |(_, x)|

          x == q
        }

        t = l.delete(x)
        t = nil unless w[ t[0] ]

        #if false && t
        #  k, q = t
        #  ass :kq, k, q, s, s[k]
        #  t = nil if s[k] >= q
        #end

        #err :t, t, q
      end

      #deb :v, v

      #ass :w, z, t, v.size, w.size

      t = t[0] if t
    end

    v
  end

  def bld r, s, w

    v = \
    w.map {
      |k, v|

      r = \
      v.all? {
        |t, n|

        #dss :tn, t, n, iss(t), isi(n), ish(s), s

        s[t] >= n
      }

      if r
        # deb :bld, k, v, s
        k
      end
    }

    #err :v, v

    v - [nil]
  end

  def mine r, s
    r.each {
      |(t, n)|

      #ass :mine, [t, n], s

      s[t] += n
    }
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
