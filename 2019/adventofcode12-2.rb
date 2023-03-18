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

    c = []

    a.each {
      |z|

      z = dcl z

      c << [z, [0,0,0]]
    }

    #err :c, c

    i = 0

    loop {

      amp c
      i += 1

      #deb :c, c, o: true

      #unless c.size == a.size
      #  deb c, o: true
      #  err :amp, c.size, a.size
      #end

      break if fin c, a

      sam(i, c) {
        evf 'sleep.rb'
      }
    }

    #out c, o: true

    i
  end

  def fin c, a

    c.each {
      |(_, v)|

      v.each {
        |g|

        return false unless g == 0
      }
    }

    deb :fin, c, o: true

    c.each_with_index {
      |(k, _), j|

      return false unless k == a[j]
    }

    #err :c, c, a
    true
  end

  def amp a

    a.each_with_index {
      |(w, v), i|

      play(a, w, v, i)

    }.each {
      |w, v|

      add w, v

      #deb :q, q, v, l: true

      #break if o.size >= 2

      #return if a[1].nil?
    }

    #err

    #ass :amp, o.size, o.size == 2
  end

  def play c, w, v, t

    #deb :play, w, v, l: true

    w.each_with_index {
      |x, i|

      c.each_with_index {
        |(b, _), j|

        next if j == t || x == b[i]

        v[i] += x > b[i] ? -1 : 1
      }

      #deb :vi, v[i]

    }

    #err :v, v

    v
  end
end

res
