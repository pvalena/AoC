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

      if true        
        #eval x
        #x.to_i
        #to_sym(x)

        #err :inp, x, @a

        x.split('').map(&:to_i)

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

    a = a.first

    #err :a, a, a.size
  
    #def a.[](i)
    #  err :oor, i if isi?(i) && i < 0
    #  super(i) || 0
    #end

    n = @a || 100

    n.times {
      a = play a
    }

    a.join
  end

  S = [0, 1, 0, -1]
  V = []

  def gsq i, n

    v = []

    until v.size >= n+1

      S.each {
        |s|

        i.times {
          v << s
        }
      }
 
    end

    v.shift
    v = v[0..n]
  
    #deb :seq, i, v, v.size, l: true

    v
  end

  def seq i, n

    V[i] ||= gsq(i, n)

  end 

  def play a

    deb :play, a, l: true #unless O == r

    c = []

    a.size.times do
      |i|

      v = 0
    
      s = seq(i+1, a.size)

      a.each_with_index {
        |z, j|

        v += z * s[j]
      }      

      v = v.abs % 10

      #deb :v, v, l: true

      c << v
    end

    deb :c, c, l: true

    c
  end
end

res
