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

  N = 10_000

  def run a

    a = a.first

    o = a.first(7).join.to_i

    a *= N

    deb :a, a.first(32).join, a[32..64].join, o, a.size, l: true
  
    #def a.[](i)
    #  err :oor, i if isi?(i) && i < 0
    #  super(i) || 0
    #end

    n = @a || 100

    n.times {
      a = play a

      break
    }

    a = a[o..]

    a.first(8).join
  end

  S = [0, 1, 0, -1]
  V = []
  
  def play a

    #deb :play, a, l: true #unless O == r

    c = []
    as = a.size

    as.times do
      |i|
      i += 1

      v = 0
      j = 0
      f = true

      while j < as
        S.each {
          |s|

          unless s == 0

            i.times {

              if f
                f = false
                next
              end

              #ass :j, j, a[j], j >= 0, j < as

              v += s * a[j]

              j += 1

              #err :j, j, as, v if j >= as
              break 2 if j >= as

            }
          else

            j += i

            if f
              j -= 1
              f = false
            end

          end

          break if j >= as
        }
      end
   
      v = v.abs % 10

#      sam(i, v, q: N)

      c << v
    end

    deb c.join

    c
  end
end

res
