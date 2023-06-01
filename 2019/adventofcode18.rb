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

          b[r] = true
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

    @@c = 4258

    deb :run, @@c, o: true

    play b, z, n

    @@c
  end

  def play b, z, n, c = 0, q = [], k = [], r = []

    b = b.dup
    k = k.dup

    # no-fork
    loop do

      return if @@c <= c

      dss :play, c, z, n, k, q
      out b, z

      bz = b[z]

      unless bz == true

        if key? bz

          k << bz
          n -= 1
          q = []
          r = []

          if n <= 0
            @@c = c

            deb :c, c, o: true
            return
          end
        end

        b[z] = true
      end

  #    err :b, b

      w = \
      D.map {
        |g|

        o = nex g, z

        bo = b[o]

        next unless bo == true || key?(bo) || open?(bo, k)

        o

      } - [nil] - q - r

      case w.size
        when 1

          q = [z]
          z = w[0]
          c += 1
          next

        when 0
          return

      end

      w.shuffle.each {
        |v|

        g = (q + w + [z]).uniq

        play b, v, n, c + 1, g, k, r + [z]
      }

      return
    end
  end

  def key? k

    k && k != true \
      && k == k.downcase

  end

  def open? k, a

    k && k != true \
      && k == k.upcase \
      && a.include?(k.downcase)

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
 
    super(f, s, t, fc: fc, sc: sc, tc: tc, **h, d: 1, h: true)
  end
end

res
