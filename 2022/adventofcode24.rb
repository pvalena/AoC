#!/usr/bin/env -S ruby

DEB = false

require_relative 'class'

class R

  def initialize

#    @s = arg.to_i

    a = {}
    n = nil
    s = !false
    g = false
    t = !false

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

    #err :a, a

    w = {}
    z = {}

    a.each_with_index {
      |b, i|

      b.each_with_index {
        |v, j|

        r = [i, j]

        #err :v, v, i, j

        w[r] = v == :'#'

        q = \
        case v
          when :'>'
            :R

          when :'<'
            :L

          when :'^'
            :U

          when :'v'
            :D

        end

        z[r] = [dir(q)] if q
      }
    }

    m = \
    w.keys.detect {
      |x|

      next unless x[0] == 0

      #err :x, x, c[x]

      not w[x]
    }

    e = max w.keys
    e = \
    w.keys.detect {
      |x|

      next unless x[0] == e

      not w[x]
    }

    dss :me, m, e

    w.keys.each {
      |x|

      w.delete(x) unless w[x]
    }

    out w, z, m

    move w, 1, z

    c = [m]
    i = 0

    (1..).each {
      |g|

      s = 10 + g

      @i = s

      c.uniq!
      c.shuffle!

      deb :run, i, s, c.size, o: true

      n = []

      c.each {
        |m|

        v = play w, m, e, i

        n += v if v
      }

      break if @i < s

      i = s - 1
      c = n
    }

    @i
  end

  DZ = [[0, 1], [1, 0], [0, 0], [-1, 0], [0, -1]]

  def play w, m, e, i = 0

    deb :play, i, m, l: true
  
    i += 1
    return [m.dup] if i >= @i

    z = move w, i

    k = []

    DZ.each {
      |x|

      err :mx, m, x unless isa(x) && isa(m)

      n = nex m, x

      if z[n] || w[n] || n[0] < 0
        deb :n, m, n, x, z[n], w[n], l: true

        err :w, n, w if w[n] && m == n
        next
      end

      if n == e
        deb :i, i, o: true, l: true

        @i = i if i < @i

        return
      end

      out w, z, n

      v = play(w, n, e, i)

      k += v if v
    }

    k
  end

  def move w, i, z = nil

    if @move.nil?

      ass :move, w, i, z

      @move = {}

      @move[0] = z
    end

    if @move[i]
      b = @move[i]

    else
      b = {}
      
      move(w, i-1).each do
        |k, v|

        v.each {
          |x|

          n = nex k, x

          if w[n]
            n = wal w, n, x
          end

          b[n] ||= []
          b[n] << x
        }
      end

      @move[i] ||= b #if i % 5 == 0
    end

    b
  end

  def wal w, n, x
    j = x.find_index 0
  
    n = \
    w.keys.detect {
      |y|

      n[j] == y[j] && n != y
    }

    nex n, x
  end

  def out c, z, m, **k

    return unless DEB

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
