#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

class R
  def initialize

    puts
    @a = arg

    n, s, g, t = nil
#    n = false
#    s = false
    g = false
#    t = false

#    a = {}
    a = \
    inp(n, s, g, t) {
      |x, i|

      if s.nil?
        #eval x
#        x.to_i
#        to_sym(x)
#        x

        x.split('').map {
          |w|

          N.include?(w) && w.to_i || w

        } #.map(&:to_i)

      else
        x.shift(2)

        xs = x.map { |z| z.to_s }
        xi = x.map { |z| z.to_i }

        xs.shift

        b = []        
        bb = {}

        xs.each_with_index {
          |w, ii|

          next if ii % 2 == 1

          w = w.split('')
          v = w.pop
          e = v == ';'
          w << v unless e || v == ','
          w = w.join.to_sym

          bb[w] = xi[ii]

          if e
            b << bb
            bb = {}
          end

        }

        b << bb

#        err :inp, b

#        case s
#          when :Game
#            next
#
#          when :Each
#
##            c = 0
#
#            #a[ x[1] ] = [ x[4].split(?=)[1].to_i, x[9..] ]
#
#          else
##            err :inp, i, x, @s
#
#        end


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

  def run a
#    err :a, a

    b = {}

    a.each_with_index.map {
      |l, i|

      l.each_with_index.map {
        |v, j|

        r = [i, j]

#        err :br, v, r

        b[r] = v unless v == ?.
      }

    }

#    err :b, b

    #def a.[](i)
    #  err :oor, i if isi?(i) && i < 0
    #  super(i) || 0
    #end

    s = 0

    b.keys.map {
      |k|

      v = b[k]

      next unless v == ?*

      w = gea b, k

#      dss :w, w, isi?(w), w > 0

      s += w
    }

    s
  end

  def gea b, k, c = A

    b = cop b

    f = []

    c.each {
      |o|

      x = nex k, o

      v = num b, x

      next unless v.any?

      deb :v, x, v, l: true

      f << v

      break if f.size > 2
    }

    unless f.size == 2

      dss :size, k, f.size, f.size < 2, f, l: true
      
      return 0
    end

    f.map! {
      |v|

      v.sort!

      v.inject('') {
        |s, w|

        s + w[1].to_s

      }.to_i      
    }

    deb :gea, k, f

    f[0] * f[1]
  end

  def num b, k, s = [], c = [[0, -1], [0, 1]]

    v = b[k]

    return s unless v && isi?(v)

#    deb :num, k[1], v

    s << [k[1], v]

    b.delete(k)

    c.each {
      |o|

      x = nex k, o

      num b, x, s
    }

    s
  end
end

res
