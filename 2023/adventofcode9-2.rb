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
    f = true

    a = \
    inp(n, s, g, t) {
      |x, i|

#      err :inp, x

        #eval x
      x.to_i
#      if f
#        f = false
#        to_sym(x)
#      else
#        x.to_sym
#      end

#      N.include?(x[0]) && x || x.to_sym

#        dss :inp, z, isi?(z) || i == 0
#
#      case i
#        when 0
#          x.split('').map {
#            |w|
#
#            N.include?(w) && w.to_i || w.to_sym
#
#          } #.map(&:to_i)
#
#        when 1
#
#          x.to_i
#
#      else
#
#        err :inp, x
#
#      end
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
#         else
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

  def run a
#
#    Q.each_with_index {
#      |w, i|
#
#      v = N.include?(w) && w.to_i || w.to_sym
#
##      err :w, w, v, i
#
#      V[v] = i
#    }

#    binding.irb
#    err :a, a, a.size

    a.map! {
      |w|

      b = [w]
      e = false

      until false
        w = dif(w)

        b << w

        break if w.all? { |v| v == 0 }
      end

      l = 0

      b.reverse!

      b.each_with_index {
        |z, i|

        l = z.first - l

        b[i] << l
      }

#      err :b, b

      l
    }

#    err :e, a

    a.sum

    #def b.[](i)
    #  err :oor, i if isi?(i) && i < 0
    #  super(i) || 0
    #end

  end

  def dif w

    b = []
    r = nil

    w.each {
      |v|

      if r
        b << v - r
      end

      r = v
    }

    b
  end

  class O
    attr_reader :h
  
    def initialize(h, b)
      @h = h
      @b = b
    end

    def <=> other
      o = other.h

      @h.each_with_index {
        |v, i|

        v = V[ v ]
        w = V[ o[i] ]

        ass :vw, v, w

        r = v <=> w

        next if r == 0

#        deb :cmp, @h, o, r, l: true
        return r
      }

      err :idk, o, @h, l: true
    end

    def to_i
      @b
    end
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
