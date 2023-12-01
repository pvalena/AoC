#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

class R
  def initialize

    puts
    @a = arg

    n, s, g, t = nil
    #n = false
#    s = false
    g = false
    #t = false

    m = ('0'..'9').to_a

    ii = 0
    j = nil
    a = {}
    a = \
    inp(n, s, g, t) {
      |x, i|

      if true        
        #eval x
#        x.to_i
#        to_sym(x)
#        x

        #err :inp, x, @a

        x.split('').select {
          |w|

          m.include?(w)

        }.map(&:to_i)

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

            next unless xs[1+c]

          when :Each

            c = 0

            #a[ x[1] ] = [ x[4].split(?=)[1].to_i, x[9..] ]

          else
            err :inp, i, x, @s

        end

#        t = xs[1+c]
#
#        a[n][t] ||= []
#        a[n][t] += [
#            [ xs[5+c], xi[4+c] ],
#            [ xs[8+c], xi[7+c] ]
#          ]
#
#        a[n][t] -= [[nil,nil]]

      

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

  A = [
    12684,     # 0 - depth limit
    1_000,     # 1 - size limit
    8,         # 2 - divider
    0,         # 3 - depth-first steps
  ]

  def run a
#    err :a, a

    a = \
    a.each_with_index.map {
      |g, i|

      [g.first, g.last]
    }

    #def a.[](i)
    #  err :oor, i if isi?(i) && i < 0
    #  super(i) || 0
    #end

    @@c = 0

    a.each_with_index {
      |g, i|

      deb g.first, g.last

      @@c += g.first * 10 + g.last
    }

    deb :run, @@c, o: true

    @@c
  end
end

res
