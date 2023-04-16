#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'
require_relative 'icc'

class R
  def initialize

    puts
    @a = arg

    n, s, g, t = nil
    #n = false
    #s = false
    #g = false
    #t = false

    ii = 0
    j = nil
    a = {}
    a = \
    inp(n, s, g, t) {
      |x, i|

      if true        
        #eval x
        x.to_i
        #to_sym(x)

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

  def run a
    a = a.first

    i = Icc.new a, 1

    #def a.[](i)
    #  err :oor, i if isi?(i) && i < 0
    #  super(i) || 0
    #end

    c = {}
    @@c = [0,0]

    play i, c

    n = 0

    t = \
    c.select {
      |k, v|

      D.all? {
        |z|

        o = nex z, k

#        err :o, o, z, k

        c[o]
      }

    }.each {
      |k, v|

      deb :k, k

      n += k[0] * k[1]
    }

    out c, t, o: true

    n
  end

  def play i, c

    a = nil

    loop do
      a = i.run

      break unless a && a.size == 1

      a = a[0]

      if a == 10
        @@c[0] = 0
        @@c[1] += 1

        next
      end

      v = a.chr

      unless v == '.'
        r = dcl @@c

        ass :a, a, v, r, v.class, ist?(v), isi?(a) # unless a == 35

        c[r] = v
      end

      @@c[0] += 1
    end

    #ass :play, a, a.empty?
  end

  def out c, s, **h
    w = c.keys
    tc = nil
    sc = 'X'.colorize :green

    t = \
    c.select {
      |k, v|

      #ass :k, k, :v, v, (0..4).include?(v)

      next if v == '#'

      tc = v.colorize :red

#      err :kv, k, v, sc
    }
 
#    err :w, w.first(3)

    super(w, s.keys, t.keys, sc: sc, tc: tc, **h)
  end
end

res
