#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

class R

  def initialize

#    @s = arg.to_i

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
      x.to_i
      #to_sym(x)
      #x.split('-').map(&:to_i)
    }

    ben {
      @r = run a #.freeze
    }
  end

  def run a

    a = a.first

    r = nil
    i = 0

    loop {
      (r, i) = play(a, i)
      break if r
    }

    r
  end

  def play c, i
    #err :a, a

    s, r1, r2, w = c[i], c[i+1], c[i+2], c[i+3]

    deb :play, i, s, l: true

    m = s / 100
    m = m.to_s.split('').map { |v| v == '1' }.reverse

    m << false until m.size >= 3
    
    s = s % 100

    e = nil

    case s
      when 1
        a = san c, m, r1, r2, w

        dss :add, a[0], a[1], w, w > 0

        c[w] = a[0] + a[1]

        i += 2
        
      when 2
        a = san c, m, r1, r2, w

        dss :mul, a[0], a[1], w, w > 0

        c[w] = a[0] * a[1]
        
        i += 2

      when 3
        a = san c, m, r1

        deb :input, r1, o: true

        c[r1] = 1
        
      when 4
        a = san c, m, r1

        ass :output, r1, r1 >= 0

        deb :output, a[0], o: true

      when 99
        e = true
        deb :exit, o: true

      else
        err :s, s
        return
    end

    i += 2

    [e, i]
  end

  def san c, m, *n

    deb :san, m, n, l: true

    n = \
    n.each_with_index.map {
      |v, i|

      ass :v, v, i, !m[i].nil?

      m[i] ? v : c[v]
    }
  
    err :san, m, n if n.include?(nil)

    n
  end

  def fin r, l = @l

    deb :fin, r.first(2)

    return r.last.first if l

    n, v = r

    100 * n + v
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
