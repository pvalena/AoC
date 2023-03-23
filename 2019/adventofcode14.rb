#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

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

    ii = 0

    a = \
    inp(n, s, g, t) {
      |x, i|

      #err :inp, x

      if true        
        #eval x
        #x.to_i
        #to_sym(x)

        #x.split('=')[1].to_i

        #err :xi, x, i 
        (ii += 1 ; next) if x == '=>'

        v = x.split('')[0]

        if ('A'..'Z').include?(v)

          x.to_sym

        else

          x.to_i

        end

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
  
    #a = a.first

    def a.[](i)
      err :oor, i if isi?(i) && i < 0
      super(i) || 0
    end

    c = {}

    a.each {
      |z|

      z = dcl z

      e = z.pop(2)

      q = z.pop

      err :c, q if !q.nil? or e.include?(nil)

      w = []

      while z.any?
        w << z.pop(2)
      end

      #err :w, w, ''

      err :ce, e[1] if c[ e[1] ]

      c[ e[1] ] = [ e[0], w ]
    }

    c[O] = [1, []]

    play(c, 1, :FUEL)
  end

  O = :ORE

  def play c, n, r, v = Hash.new(0)
    deb :play, n, r, l: true # unless O == r

    #err :cr, c[r]

    g = c[r][0]
    o = 0

    until v[r] >= n 
      c[r][1].each {
        |(m, h)|

        #err :mh, m, h

        o += play c, m, h, v      

        v[h] -= m

        ass :vh, h, v[h], v[h] >= 0
      }

      v[r] += g
      o += g if r == O
    end

    o
  end
end

res
