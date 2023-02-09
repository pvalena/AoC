#!/usr/bin/env -S ruby

DEB = false

require_relative 'class'

class R

  def initialize

    @a = ARGV.pop.split(?,).map(&:to_i) if ARGV.size > 1

    a = {}
    j = nil

    n, s, g, t = nil

    #n = false
    #s = false
    #g = false
    #t = false

    a = \
    inp(n: n, s: s, g: g, t: t) {
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

    mn,  ma  = min(ck),  max(ck)
    mn2, ma2 = min2(ck), max2(ck)

    l = 10
    r = dfr [
          ran(mn - ma * l, ma  + ma * l), \
          ran(mn2 - ma2 * l, ma2 + ma2 * l)
        ]

    m = 0
    l = nil

    unless @a
      ck.each {
        |x|

        q = c.dup
        q.delete(x)
        @z = []

        #deb :x, x

        s = play q, x, r

        #deb :s, s

        if s > m
          m = s
          l = x
        end
      }

    else
      l = @a.reverse

    end

    deb :run, [m, l], o: true

    d = dcl(D)

    swp d, 1, 2

    d.rotate!

    dfr d

    zap c, l, r, d
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

        #deb :d, g, d

        o = g.dup

        ray c, g, d, r

        @z << [o, g]

        #err :c, c.size, g unless [[4, -1], [5, 1]].include?(g)

      }
    }

    n += play c, x, r, m+1 if c.any?
    n
  end

  T = 200

  def zap c, x, r, d, n = 0

    q = c.dup
    q.delete(x)
    @z = []

    play q, x, r

    z = @z

    err :skip, z.size \
      unless z.size >= T

    d.each_with_index {
      |w, i|

      n, z, v = qua w, i, d, z, x, r, n

      return v if n >= T

      #err :qd, n, z.size, v
    }

    err :zap, n, z.size
  end

  def qua w, i, d, z, x, r, n

    j = w.find_index(0)
    k = (j + 1) % 2

    l = d[(i + 1) % d.size][j]

    deb :qua, w, l, l > 0, w[k] > 0, o: true, l: true

    y = \
    z.select {
      |v, _|

      if l > 0
        v[j] >= x[j]

      else
        v[j] <= x[j]

      end \
      \
      &&
      \
      if w[k] > 0
        v[k] >= x[k]

      else
        v[k] <= x[k]

      end
    }

    z -= y

    unless n+y.size >= T

      n += y.size
    
      return [n, z]
    end

    y.sort_by! {
      |(g, v)|

      vj = r[j].include?(v[j])
      vk = r[k].include?(v[k])

      deb :v, g, v, vj, vk, l: true

      err :v_f, v if vj && vk

      if true
        if vj

          h = true

          deb :top

        elsif vk

          h = false

          deb :rig

        else

          h = (r[k].min - v[k]) \
            < (v[j] - r[j].max)

          err :tie, h
          
        end

        o = \
        if h
          vj = v[j]
          vj = -vj unless l > 0 

          [0, vj, g[k]]

        else
          gj = g[j]
          gj = -gj unless l > 0 

          [1, v[k], gj]

        end

        unless w[k] <= 0
          err :fq, o, (l > 0), (w[k] > 0)
        end

        o

      else
        if l > 0
          v[j] <= o[j]

        else
          v[j] <= o[j]

        end \
        \
        &&
        \
        if w[k] > 0
          v[k] >= o[k]

        else
          v[k] <= o[k]

        end      
      end      
    }

    #deb :y, y.first(3), l: true
    #err

    y.each {
      |v, _|
       
      n += 1

      deb :n, n, v if n < 4 || n % 10 == 0

      return [n, z, v] if n >= T
    }

    [n, z]
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
        #deb :g, g unless f
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

  def to_s
    @r = @r[1]*100 + @r[0]
    super
  end
end

res
