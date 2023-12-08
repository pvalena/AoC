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

#    a = {}
    a = \
    inp(n, s, g, t) {
      |x, i|

#      err :inp, x

      if s.nil?
        #eval x
#        x.to_i
#        to_sym(x)
#        x

#        z = N.include?(x) && x.to_i || x

#        dss :inp, z, isi?(z) || i == 0

        x.to_i

#        x.split('').map {
#          |w|
#
#          N.include?(w) && w.to_i || w
#
#        } #.map(&:to_i)

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

  Q = {
    start: :'@',
    wall: :'#',
    pass: :'.',
  }

  def run a
#    err :a, a

    b = {}

    a.each_with_index.map {
      |l, i|

      l.shift(2)

      r = []

      l.each.map {
        |v, j|

        break if v == 0

        r << v
      }

      l.shift(r.size+1)

#      err :rl, r, l

      b[r.sort] = l.sort

    }

#    err :b, b

    #def b.[](i)
    #  err :oor, i if isi?(i) && i < 0
    #  super(i) || 0
    #end

    s = 0

    b.each_with_index {
      |(k, j)|

      n = 0
#      err :kj, k, j

      k.each {
        |w|

        n += 1 if j.include?(w)
      }

      if n > 0
        n -= 1

        s += 2**n
      end

#      deb :s, s

    }

    s
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
