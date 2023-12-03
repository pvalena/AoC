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

  Q = {
    start: :'@',
    wall: :'#',
    pass: :'.',
  }

  A = {
    :red => 1,
    :green => 1,
    :blue => 1
  }

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

    r = (-1..1)

    c = []

    r.each {
      |x|

      r.each {
        |y|

        c << [x, y] unless x == 0 && 0 == y

      }

    }
    
#    err :c, c

    o = cop b

    b.each {
      |k, v|

#      deb :kv, k, v

      next if isi?(v)

#      b.delete(k)

      des b, k, c
    }

#    err :b, b

    b.keys.each {
      |k|

      o.delete(k)
    }

#    err :o, o

    o.keys.inject(0) {
      |s, k|

      v = num o, k

      deb :v, k, v

      s + v
    }
  end

  def des b, k, c = [[0, -1], [0, 1]]
    c.each {
      |o|

      x = nex k, o

      v = b[x]

      next unless v && isi?(v)

      b.delete(x)

      des b, x
    }
  end

  def num b, k, s = ''

    v = b[k]

    unless v
      return s.empty? ? 0 : s.to_i
    end

#    deb :num, k, v

    s += v.to_s

    b.delete(k)

    x = nex k, [0, 1]

    num b, x, s
  end
end

res
