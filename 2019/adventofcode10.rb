#!/usr/bin/env -S ruby

DEB = false

require_relative 'class'

class R

  def initialize

    @a = arg.to_i if ARGV.size > 1
    @a ||= 5

    a = {}
    n, s, g, t = nil

    #s = false
    #g = false
    #t = false

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
      to_sym(x)
      #x.split('').map(&:to_i)
    }

    ben {
      @r = run a #.freeze
    }
  end

  def inloop c, i = 0

    loop {
      i = play(a, i)

      break unless i
    }

    @o
  end

  def run a

    #a = a.first

    c = {}

    a.each_with_index {
      |b, i|

      b.each_with_index {
        |w, j|

        ass :w, w

        v = w == :'#'

        next unless v

        r = [i, j]

        c[r] = v
      }
    }

    ck = c.keys

    dfr c
    dfr ck

    r = dfr [ ran(min(ck), max(ck)), ran(min2(ck), max2(ck)) ]

    m = 0

    ck.each {
      |x|

      q = c.dup
      q.delete(x)

      deb :x, x

      s = play q, x, r

      deb :s, s

      m = s if s > m
    }

    m
  end

  def play c, x, r, m = 1, n = 0

    y = [-m, m]

    #deb :y, y

    ran(*y) {
      |a|

      ran(*y) {
        |b|

        d = [a, b]

        next unless (d & y).any?

        g = nex d, x

        next unless c[g]

        n += 1

        deb :d, g, d

        ray c, g, d, r

        #err :c, c.size, g unless [[4, -1], [5, 1]].include?(g)

      }
    }

    n += play c, x, r, m+1 if c.any?
    n
  end

  def ray c, g, d, r

    z = nil

    m = d.map(&:abs)

    if d.include? 0

      z = m.max

    else
      m.min.downto(2) {
        |q|

        next unless d[0] % q == 0 && d[1] % q == 0

        z = q
        break
      }
    end

    if z
      #deb :z, z
    
      d.map! {
        |q|

        q / z
      }
    end

    f = true

    loop {
      if c[g]
        deb :g, g unless f
        f = false

        c.delete(g)

      else
        #deb :n, g

      end

      add g, d

      (0..1).each {
        |q|

        #deb :q, q, r[q][0], g[q], r[q][1]

        return unless r[q].include? g[q]
      }
    }
  end
end

res
