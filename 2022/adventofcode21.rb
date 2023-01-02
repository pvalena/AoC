#!/usr/bin/env -S ruby

#DEB = false

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

      #err :inp, x

      xs = x.map { |z| z.to_sym }
      xi = x.map { |z| z.to_i }

      k = xs.shift

      v = xs.size == 1 ? xi[1] : xs

      a[ k ] = v

      #err :a, a, k, xs

      unless true
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
      end

      #eval x
      #to_sym x
      #(to_i x.split(?,))
      #x.to_i
    }

    ben {
      @r = run a.freeze
    }
  end

  def run a

    a = a.dup

    b = \
      hsh {
        |h, i|

        ass :hsh, i, a[i]

        f, o, s = a[i]

        g = [ h[f], h[s] ]

        g.reduce o
      }

    a.reject! {
      |k, v|

      unless v.respond_to? :each

        b[k] = v

      end
    }

    b[:root]

    #err :a, a

    #dss :run, a.size, b.size, a.size == b.size

    #inloop a, b
  end

  T = [1000, 2000, 3000]

  def inloop a, b

    c = []
    i = 0
    as = a.size
  
    loop {
      x = i % as
      r = play a[x], b, as

      #c << val(b, as) if T.include?( i )

      i += 1

      break if i >= as
    }

    val b, as
  end

  def val a, as
    z = a.find_index 0

    c = []

    T.each {
      |t| 
      #z = nex z, t, as

      i = t + z

      c << a[i % as]
    }

    deb :val, c, o: true

    c.reduce :+
  end

  def inparallel a
    t = 4 unless Process.respond_to?(:fork)

    Parallel.map(a, in_threads: t) {
      |(b, v)|

      r = play v, b

      [b, r]

    }.reduce {
      |k, (b, g)|

      k * g
    }
  end

  def play f, a, as

    return if f == 0

    q = \
    a.find_index {
      |z|

      z === f
    }

    unless true
      n = nex a[q], q, as

      a.insert n, f

      q += 1 if n <= q

      v = a.delete_at q

    else
      r = (f > 0) ? 1 : -1

      f.abs.times {
        n = q + r

        n += as while n < 0
        n %= as

        swp a, q, n

        q = n
      }
    end

    #ass :fv, f == v, f, v

    deb :play, f, a, l: true

    nil
  end

  def nex v, q, as
    c = (q + v)

    c += 1 if v > 0

    c += as while c < 0

    c %= as

    #c -= 1 if c > q  
    c
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
