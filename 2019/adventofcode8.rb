#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

class R

  def initialize

    @a = arg.to_i if ARGV.size > 1
    @a ||= 5

    a = {}
    n = nil
    s = !false
    g = !false
    t = !false

    a = \
    inp(s: s, g: g, t: t) {
      |x, i|

      #err :inp, x

      unless true

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
      #x.to_i
      #to_sym(x)
      x.split('').map(&:to_i)
    }

    ben {
      @r = run a #.freeze
    }
  end

  def inloop c, g, i = 0

    loop {
      i = play(a, i, g)

      break unless i
    }

    @o
  end

  W = 25
  H = 6

  def run a

    a = a.first

    #err :run, a

    c = dcl( [ [[]] * W ] * H )

    #err :c, c, c.size, c.first.size

    while a.any?
      c.each {
        |v|

        v.each {
          |w|

          ass :w, c, w, a.any?

          w << a.shift
        }
      }
    end

    x = [E, nil]

    tt = \
    c.first.first.each_with_index.map {
      |_, i|

      t = play c, i

      x = [ t[0], i ] if t[0] < x[0]

      t[1] * t[2]
    }

    tt[ x[1] ]
  end

  def play c, i

    c = dcl c

    c.each {
      |b|

      b.map! {
        |g|

        #err :g, g[i]

        g[i]
      }
    }
  
    c.flatten.tally
  end

  def out c, z, m, **k

    return unless DEB || k[:o]

    w, g = [], []

    c.keys.each {
      |x|

      v = c[x]

      if v

        w

      else

        g

      end << x
    }

    q = z.keys + [m]

    super(w, g, q, **k) {
      |x|

      v = z[x]

      if v

        v = \
        if v.size == 1

          rrt v[0]

        else

          v.size

        end

        v.to_s.colorize(:green)
  
      else

        '@'.colorize(:red)

      end
    }
  end
end

res
