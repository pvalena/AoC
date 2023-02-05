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
      #(to_i x.split(?,))
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

    e = []

    q = \
    a.each_with_index.map.sum {
      |b, i|

      r = sfu b

      #deb :r, b.reverse.join, r

      e << [r, b] 

      r
    }

    if DEB
      e.sort.each {
        |r, b|

        deb :tst, r, b

        v = sna r
        w = sfu v

        err :v, [b, r], [v, w] unless r == w || b == v
      }
    end

    q
  end

  def sfu b
    to_sym(b) 
      .reverse
      .each_with_index.map.sum {
        |v, j|

        z = 5**j

        q = \
        case v
          when :'='
            -2

          when :'-'
            -1

          else
            v.to_s.to_i

        end

        #dss :v, v, j, z, q, z*q

        z *= q
    }
  end

  def sna r

    o = ''

    i = \
    (0..).detect {
      |j|

      x = 5**(j-1)  *2
      y = 5**j      *2
      z = 5**(j+1)  *2

      z > r && r - y < x
    }

    r = -r

    i.downto(0).map {
      |j|

      x = top(j-1)
      y = 5**j

      n = 2

      o = r > 0 ? -1 : 1

#      dss :ib, [r, o, n, y], x, j

      n -= 1 until (z = (r + o * n * y)).abs <= x || n <= 0

      r = z

      if j < 1 && r > 0
        dss :ia, [r, o, n, y], x, j, z
        err :r, r
      end

      case n*o
        when -2
          '='

        when -1
          '-'

        else
          n.to_s

      end

    }.join 
  end

  def opr r, o, n, y
    r + o * n * y
  end

  def top v
    if @top.nil?
      @top ||= hsh {
        |h, i|

        (5**i * 2) + h[i-1]
      }

      @top[0] = 2
      @top[-1] = 0
    end

    @top[v]
  end

  def to_s
    @r = sna @r
    super
  end
end

res
