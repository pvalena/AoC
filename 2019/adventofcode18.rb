#!/usr/bin/env -S ruby

DEB = false

require_relative 'class'

class R
  def initialize

    puts
    @a = arg

    n, s, g, t = nil
    #n = false
    #s = false
    g = false
    #t = false

    ii = 0
    j = nil
    a = {}
    a = \
    inp(n, s, g, t) {
      |x, i|

      if true        
        #eval x
        #x.to_i
        to_sym(x)

        #err :inp, x, @a

        #x.split('').map(&:to_i)

      else
        xs = x.map { |z| z.to_sym }
        xi = x.map { |z| z.to_i }

        k = xs.shift

        v = xs.size == 1 ? xi[1] : xs

        a[ k ] = v

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

      end
    }

    ben {
      @run = run a
    }
  end

  Q = {
    start: :'@',
    wall: :'#',
    pass: :'.',    
  }

  def run a
#    err :a, a
  
    b = {}
    z = nil
    n = 0

    a.each_with_index {
      |g, i|

      ass :g, g, isa?(g)

      g.each_with_index {
        |q, j|

        ass :q, q, g, iss?(q)

        r = [i, j]

        next if q == Q[:wall]

        if q == Q[:pass]

          b[r] = true
          next

        end

        if q == Q[:start]

          b[r] = q
          z = r
          next

        end

        b[r] = q
        n += 1 if q == q.downcase
      }
    }

#    err :b, z, n

    #def a.[](i)
    #  err :oor, i if isi?(i) && i < 0
    #  super(i) || 0
    #end

    @@c = @a || 2942

    deb :run, @@c, o: true

    cln b, z

    out b, z

    t = tp b

    h = cpat b

    b[z] = true

    w = play b, z, n, h, t

#    err :w, w.size

    while w.any?

      n = []

      x = \
      w.map {
        |o|

        o[2]

      }.min + 1

      m = \
      w.map {
        |o|

        o[2] == x ? o[5] : E

      }.min + 1

      z = \
      if w.size <= 100_000
        w.map {
          |o|

          o[5]

        }.min
      end

      y = []

      while y.none?

        y = \
        w.select {
          |o|

          ( z && o[5] <= z ) || ( o[2] <= x && o[5] <= m )
        }

        m += 1
      end

      w -= y

      deb :x, x, m, y.size, w.size, o: true

      y.each {
        |o|

        l = play( *o )
        n += l - [nil] if l
      }

      w += n
    end

    @@c
  end

  L = 300_000

  def tp b, t = {}

    g = []
  
    b.each {
      |k, v|

      next unless v == true

      star b, k, t
    }

    t

  end

  def star b, k, t, q = []

    ass :star, k, t, q, isa?(k), ish?(t), isa?(q)

    return if t[k]

    r = pat(b, k) - q

    n = []

    r.select! {
      |o|

      if b[o] == true

        n << o
        false

      else

        true

      end
    }

    if n.one? && r.size <= 1

      v = wlk b, k, r

      t[k] = v if v

      return
    end

    if (r + n).size > 2

      n.each {
        |o|

        v = wlk b, o, [k]

        t[o] = v if v
      }

    end
  end

  def wlk b, k, q, c = 0

    while b[k] == true

      r = pat(b, k) - q

      break unless r.one?

      q = [k]
      k = r[0]
      c += 1
    end

    return unless c > 1

    [k, c, q]
  end

  # b - board
  # z - position
  # n - remaining
  # h - cache
  # t - teleport
  # c - steps
  # q - rectently visited
  # k - keys
  # r - visited crossroads
  def play b, z, n, h, t, c = 0, q = [], k = [], r = []

    b = b.dup
    k = k.dup

    # no-fork
    while c < @@c

      x = t[z]

      if x
        z  = x[0]
        c += x[1]
        q  = x[2]
      end

      bz = b[z]
      return unless bz

      unless bz == true

        if key? bz

          k << bz
          n -= 1
          q = []
          r = []

          if n <= 0
            @@c = c

            deb :c, c, k, o: true
            return
          end

        else

          ass :door, bz, door?(bz)
          return unless open?(bz, k)

        end

        b[z] = true

        cln b, z
 
      end

      dss :play, c, z, n, l: true
      out b, z

  #    err :b, b

      # Resolve path
      w = ( h[ z ] - q ) - r
      
      w.select! {
        |o|

        bo = b[o]

        bo == true || key?(bo) || open?(bo, k)
      }

      case w.size

        when 1
          q = [z]
          z = w[0]
          c += 1
          next

        when 0
          return

      end

      w.map! {
        |v|

        g = (q + w + [z]).uniq

        [ b, v, n, h, t, c + 1, g, k, r + [z] ]
      }

      return w
    end

    nil
  end

  def pat b, z

    D.map {
      |g|

      o = nex g, z

      next unless b[o]

      o

    } - [nil]

  end

  def cpat b
    hsh {
      |_, i|

      pat(b, i)
    }
  end

  def cln b, z, h = nil

    f = true

    while f
      f = false

      b.each {
        |k, v|

        next unless v == true

        next if k == z

        r = nil

        if h

          r = h[ z ]

        else

          r = pat(b, k)

        end

        next unless r.one?

        f = true
        b.delete k
      }

    end

  end

  def key? k

    k && k != true \
      && k == k.downcase

  end

  def door? k

    k && k != true \
      && k == k.upcase

  end

  def open? k, a

    door?(k) \
      && \
    ( a.nil? || a.include?(k.downcase) )

  end

  def out f, t, **h

    @outc = nil
    t = { t => nil }

    fc = '.'.colorize :lightblue
    sc = 'x'.colorize :green
    tc = '@'.colorize :red

    s = \
    f.select {
      |k, v|

#      err :kv, k, v, sc

      v != true
    }

    f = f.keys
    s = s.keys
    t = t.keys

    super(f, s, t, fc: fc, sc: sc, tc: tc, d: 1, h: true)
  end
end

res
