#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'
require_relative 'icc'

class R

  def initialize

    @a = arg

    a = {}
    j = nil

    n, s, g, t = nil

    #n = false
    #s = false
    #g = false
    #t = false

    a = \
    inp(n, s, g, t) {
      |x, i|

      #err :inp, x

      if true        
        #eval x
        x.to_i
        #to_sym(x)
        #x.split('=')[1].to_i

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
      @r = run a
    }
  end

  def run a
    #err :a, a

    a = a.first

    a[0] = 2
  
    i = Icc.new a, 3

    #def a.[](i)
    #  err :oor, i if isi?(i) && i < 0
    #  super(i) || 0
    #end

    c = {}

    play i, c

    out c, o: true

    c.select {
      |k, v|

      v == 2

    }.size
  end

  def play i, c

    a = nil

    loop do
      a = i.run

      break unless a && a.size == 3

      z = a.shift 2
      v = a.shift

      ass :z, z, v, z.size == 2, (0..4).include?(v)
    
      c[z] = v
    end

    #ass :play, a, a.empty?
  end

  def out c, **h
    w = []

    c.each {
      |k, v|

      ass :k, k, :v, v, (0..4).include?(v)

      w[v] ||= []
      w[v] << k
    }

    deb :q, w

    w.map! {
      |g|

      #err :g, g

      g ? g : []
    }

#    err :w, w.first(3)

    super(*w.first(3), **h)
  end
end

res
