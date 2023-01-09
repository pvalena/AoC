#!/usr/bin/env -S ruby

DEB = false

require_relative 'class'

class R

  def initialize

#    @s = arg.to_i

    a = {}
    n = nil
    s = !false
    g = false
    t = !false

    a = \
    inp(s: s, g: g, t: t) {
      |x, i|

      unless true
        err :inp, x

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
      #(to_i x.split(?,))
      #x.to_i
      to_sym(x)
    }

    ben {
      @r = run a #.freeze
    }
  end

  def run a

    #err :a, a

    c = {}

    a.each_with_index {
      |b, i|

      b.each_with_index {
        |v, j|

        r = [i, j]

        #err :v, v, i, j

        case v
          when :'.'

          when :'#'
            c[r] = true

          else
            err :idk, v, r

        end
      }
    }

    # N S W E
    D.rotate!(2)

    out c, true

    (0..).each {
      |i|

      b = play c

      return i if b == c

      c = b
    }
  end

  def out c, i = false, **k
    if i
      ck = c.keys
      w = [ ['#'] * (max2(ck) + 1) ] * (max(ck) + 1)
      bout w, c.keys
    else
      super([], [], c.keys, tc: '#'.colorize(:cyan), **k)
    end
  end

  def eut c, **k
    super(c.keys, **k)
  end

  def play c, i = nil

    deb :play, i, l: true
  
    b = move c, i

    ass :bs, b.size == c.size

    D.rotate!

    out b

    b
  end

  def move c, i

    #err :q, Q
  
    b = {}

    c.keys.each do
      |x|

      #deb :x, x

      f = nil
      a = nil

      D.each {
        |z|

        #deb :z, z

        i = z.find_index 0

        y = nex z, x

        e = \
        (-1..1).none? {
          |q|

          g = dcl y

          g[i] += q

          #deb :g, g

          c[g]
        }

        if e
          f ||= z     
        else
          a ||= true
        end

        break if f && a
      }

      n = x

      if f && a
        n = nex n, f

        #err :f, x, n
      end

      unless b[n]
        b[n] = x

      else
        b[x] = true

        v = b[n]

        ass :v, x, n, v, isa?(v)
        
        b[v] = true

        b.delete n
      end
    end

    #err :b, b 

    b

  end
end

res
