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
#    g = false
#    t = false

    a = []
    l = nil

    a = \
    inp(n, s, g, t) {
      |x, i|

#      err :inp, x[0]

        #eval x
#        x.to_i
#        to_sym(x)
#        x

      z = N.include?(x[0]) && x.to_i || x.to_sym

#        dss :inp, z, isi?(z) || i == 0

      z

#        x.split('').map {
#          |w|
#
#          N.include?(w) && w.to_i || w
#
#        } #.map(&:to_i)
#
#      x.shift(2)
#
#      xs = x.map { |z| z.to_s }
#      xi = x.map { |z| z.to_i }
#
#      xs.shift
#
#      b = []        
#      bb = {}
#
#      xs.each_with_index {
#        |w, ii|
#
#        next if ii % 2 == 1
#
#        w = w.split('')
#        v = w.pop
#        e = v == ';'
#        w << v unless e || v == ','
#        w = w.join.to_sym
#
#        bb[w] = xi[ii]
#
#        if e
#          b << bb
#          bb = {}
#        end
#
#      }
#
#      b << bb

#      err :inp, z

#      case s
#        when :Game
#          next
#
#        when :Each
#
##            c = 0
#
#          #a[ x[1] ] = [ x[4].split(?=)[1].to_i, x[9..] ]
#
#        else
##            err :inp, i, x, @s
#
#      end
#

#        t = xs[1+c]
#
#        a[n][t] ||= []
#        a[n][t] += [
#            [ xs[5+c], xi[4+c] ],
#            [ xs[8+c], xi[7+c] ]
#          ]
#
#        a[n][t] -= [[nil,nil]]
     
    }

    ben {
      @run = run a
    }
  end

  Q = {
    
  }

  def run a
#    err :a, a

    b = a.pop
    a = a[0]

    s = 1

    a.each_with_index {
      |t, i|

      next if i == 0

      d = b[i]

      s *= \
      (1...t).map {
        |w|

        r = t - w

        e = r * w

        dss :w, t, w, r, e

        e > d ? 1 : 0

      }.sum

#      err :s, s

    }

    s

    #def b.[](i)
    #  err :oor, i if isi?(i) && i < 0
    #  super(i) || 0
    #end

#    s = 0
#
#    m = Hash.new(1)

#    b.each_with_index {
#      |(k, j), i|
#
#      i += 1
#      n = 0
#      err :kj, k, j
#
#      k.each {
#        |w|
#
#        n += 1 if j.include?(w)
#      }
#
#      if n > 0
#
#        (i+1..i+n).each {
#          |w|
#
#          m[w] += m[i]
#        }

#        err :m, i, m[i] if m[i] > 0       

#      end
#
#
##      err :m, m
#
#      s += m[i]
#
#    }

#    s.min
  end

  def stl s, t, m
    s.map! {
      |g|

      t.each {
        |v, r|

        if r.include? g

          g = g - r.first + v

          break

        end
      }

      g
    }
  end

  def sea b, k

    f = \
    are(b, k, n: true) {
      |x, v|

      err :v, x, v, l: true

      next unless v

      deb :v, x, v, l: true

      v
    }

    err :f, f

    f.map! {
      |v|

      v.sort!

      v.inject('') {
        |s, w|

        s + w[1].to_s

      }.to_i      
    }

    deb :sea, k, f

    f[0] * f[1]
  end

  def rcs a, k, s = [], c = A, &b

    v = a[k]

    return s unless v

    deb :rcs, k, v, s
  
    v = yield k, v, s

    return s unless v

    a.delete(k)

    c.each {
      |o|

      x = nex k, o

      rcs a, x, s, c, &b
    }

    s
  end
end

res
