#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

class R

  def initialize

    @a = arg

    a = {}
    j = nil

    n, s, g, t = nil

    #dcl([nil] * 4)

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
        #x.to_i
        #to_sym(x)
        x.split('=')[1].to_i

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

      c[z] = dcl [0,0,0]
    }

    #err :c, c

    @a ||= T

    # run
    @a.times {
      r = amp c

      #err :amp, r

      break unless r

      c = r
    }

    #deb :c, c

    #out c, o: true

    c
  end

  T = 100

  def to_s
    r = @r

    @r = \
    r.keys.map {
      |w|

      v = r[w]

      w.map!(&:abs)
      v.map!(&:abs)

      #deb :w, w, v, l: true

      w.sum * v.sum

    }.reduce(:+)

    super
  end

  def amp a

    c = {}

    a.keys.each {
      |w|
      
      v = a[w]

      play(a, w, v)

      q = nex3 w, v

      #deb :q, q, v, l: true

      c[q] = v

      #break if o.size >= 2

      #return if a[1].nil?
    }

    #err

    #ass :amp, o.size, o.size == 2

    c
  end

  def play c, w, v

    #deb :play, w, v, l: true

    w.each_with_index {
      |x, i|

      c.keys.each {
        |b|

        next if b == w

        g = b[i]

        #err :b, x, g

        next if x == g

        v[i] += x > g ? -1 : 1
      }

      #deb :vi, v[i]

    }

    #err :v, v

    v
  end

  def out c, z = {}, m = nil, **k

    w, g = [], []

    c.keys.each {
      |x|

      v = c[x]

      if v

        w

      else

        g

      end << x
    }

    q = z.keys
    q << m if m

    super(w, [], q, **k)
    
    [].each {
      |x|

      v = z[x]

      if v

        v = \
        if v.size == 1

          rrt v[0]

        else

          v.size

        end

        v.to_s.colorize(:green)
  
      else

        '@'.colorize(:red)

      end
    }
  end
end

res
