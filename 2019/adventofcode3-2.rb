#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

class R

  def initialize

#    @s = arg.to_i

    a = {}
    n = nil
    s = false
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
      x
    }

    ben {
      @r = run a #.freeze
    }
  end

  def run a

    #err :a, a

    w = {}

    a.each_with_index {
      |b, i|

      c = [0, 0]
      s = 0

      b.each_with_index {
        |v, j|

        v = v.split('')

        d = dir(v.shift)
        n = v.join.to_i

        #err :v, d, n

        n.times {
          c = nex c, d
          s += 1

          w[c] ||= []
          w[c] << [i, s]
        }
      }
    }

    m = \
    w.keys.select {
      |x|

      if w[x].size > 1
        
        w[x].map { |(z, _)| z }.uniq.size > 1
      end

    }.map {
      |x|

      err :x, w[x] if w[x].size > 2

      w[x].map { |(_, z)| z }.sum

    }.min
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
