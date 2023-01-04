#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

class R

  def initialize

#    @s = arg.to_i

    a = {}
    n = nil
    s = false
    g = false
    t = false

    a = \
    inp(s: s, g: g, t: t) {
      |x, i|

      unless true
        err :inp, x

        xs = x.map { |z| z.to_sym }
        xi = x.map { |z| z.to_i }

        k = xs.shift

        v = xs.size == 1 ? xi[1] : xs

        a[ k ] = v

        #err :a, a, k, xs

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
      #(to_i x.split(?,))
      #x.to_i
      to_sym(x)
    }

    ben {
      @r = run a #.freeze
    }
  end

  def run a

    d = a.pop.join

    n = d.split(/[A-Z]/) - [""]

    d = d.split(/[0-9]*/) - [""]

    d.map! {
      |v|

      [v.to_sym, n.shift.to_i]
    }

    #err :d, d

    c = {}
    f = nil

    a.each_with_index {
      |b, i|

      b.each_with_index {
        |v, j|

        r = [i, j]

        case v
          when :' '
            #err :n, v, r

          when :'.'
            f ||= r

            c[r] = false
            #err :e, v, r

          when :'#'
            c[r] = true
            #err :b, v, r

          else
            err :idk, v, r

        end
      }
    }

    r = [f, :R]

    inloop d, [c, r]
  end

  R = [:R, :D, :L, :U]

  def val x
    l, r = x[1]

    add l, [1, 1]

    i = R.find_index r
    
    s = 1000 * l[0] + 4 * l[1] + i

    dss :val, l, r

    s
  end

  def play x, a

    c, h = a

    r, n = x

    move c, h, n

    rot h, r
  end

  def rot h, r

    i = R.find_index h[1]

    i += r == :L ? -1 : 1

    i = R.size - 1 if i < 0

    i %= R.size

    #dss :rot, h[1], r, R[i]

    h[1] = R[i]

  end

  def move c, h, n

    #err :c, c.size, l, n

    l, r = h

    d = dir r

    n.times {

      t = nex l, d

      x = 0

      1.times do

        x += 1

        #dss :x1, x, t, l, d

        v = c[t]

        break 2 if v

        if v.nil?
          i = d.find_index 0

          j = d[ (i + 1) % 2 ]

          ck = c.keys.sort
          ck.reverse! if j < 0

          t = \
          ck.detect {
            |g|

            next unless l[i] == g[i]

            #err :move, l, d, g, max2(ck) if j < 0

            l[i] == g[i]
          }

          err :redo, t, l, d if x > 1

          redo

          cout c, [t, nil]
          err :n, f, d
        end

        l = t
      end

    }

    h[0] = l
  end

  def nex x, y
    [ x[0] + y[0], x[1] + y[1] ]
  end

  def dir x
    case x
      when :R
        D[1]
      when :D
        D[3]
      when :L
        D[0]
      when :U
        D[2]
      else
        err :dir, x, D
    end
  end

  def cout c, h
    return if c.size > 100
  
    f = h[0]
  
    out \
      c.keys.select { |k| c[k] }, \
      c.keys.reject { |k| c[k] }, \
      [f]
  end

  def inloop a, b

    c = []
    i = 0
    as = a.size
  
    loop {
      x = i % as
      r = play a[x], b

      cout *b

      #c << val(b, as) if T.include?( i )

      i += 1

      break if i >= as
    }

    val b
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

  def out(w, s = [], t = [], \
    wc: '#'.colorize(:cyan), \
    sc: '.'.colorize(:green), \
    tc: '@'.colorize(:red), \
    o: false, f: false)

    return unless DEB || o

    w = dcl w
    s = dcl s
    t = dcl t

    # flip
    if f
      w.map! {
        |(x, y)|

        [-x, y]
      }

      s.map! {
        |(x, y)|

        [-x, y]
      }

      t.map! {
        |(x, y)|

        [-x, y]
      }
    end

    m = [0, 0]
    n = [E, E]
    d = 2

    #deb :w, w

    # store
    w += s
    w += t

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
    s = w.last(s.size + t.size)
    t = s.pop(t.size)

    x, y = m[0] - r + d, m[1] - c + d

    a = [ [ wc ] * y ] * x
    a = dcl a

    #err :w, w.size, s.size

    s.each {
      |g|
      set(a, g, sc)
    }

    t.each {
      |g|
      set(a, g, tc)
    }

    super(a, w, b: false, h: false, o: true)
  end
end

res R.new
