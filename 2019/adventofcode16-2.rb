#!/usr/bin/env -S ruby

DEB = false

require_relative 'class'

class R

  def initialize

    puts

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

  N = [10_000]

  def pat a
    def a.[](q, *k, **g)
      if k.empty? and g.empty? and q.kind_of?(Integer)

        z = q % N[1]

        #err :super, z, q

        return super(z) #or k == 1
      end

      super(q, *k, **g)
    end
  end

  def run a

    a = a.first
    l = a.size

    N[1] = l
    N.freeze

    as = N[0] * l
    o = a.first(7).join.to_i
    n = @a || 100

    b = [a]
    c = []

    af = [ a.first(l) ]

    pat a

    af << \
    (l...(l*2)).inject([]) {
      |b, w|

      b << a[w]
    }

    af.map!(&:join)

    #err :af, af[1], l: true    

    deb :run, n, o, l, as, l: true, o: true
    ass :a, af[0] == af[1], af
  
    8.times do
      |i|

      c << play(b, as, n, o+i)

      deb :c, c, b.size, (b[1] || []).size, l: true, o: true
    end

    c.join
  end

  S = [nil, true, nil, false]
  V = []
  
  def play a, as, n, i

    n -= 1
    i += 1

    w = a[n]

    unless w
      w = {}

      a[n] = w
    end

    v = 0
    j = 0
    f = true

    sam(i, q: N[0]) {
      
      [ :play, n, w.size ]

    }

    while j < as

      S.each {
        |s|

        unless s.nil?

          i.times {

            if f
              f = false
              next
            end

            ass :ja, j, j >= 0, j < as if DEB

            z = w[j]

            #err :z, z, f, j, l: true

            unless z
              z = play a, as, n, j

              w[j] = z
            end

            z = -z if s

            v += z

            j += 1

            #err :j, j, as, v if j >= as
            break 2 if j >= as

          }
        else

          deb :j, j, i, l: true

          j += i

          if f
            j -= 1
            f = false
          end
        end

        #err :jas, j, as

        break if j >= as
      }

    end
 
    v.abs % 10
  end
end

res
