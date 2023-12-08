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
#      to_sym(x)
#        x

#      N.include?(x[0]) && x || x.to_sym

#        dss :inp, z, isi?(z) || i == 0

      case i
        when 0
          x.split('').map {
            |w|

            N.include?(w) && w.to_i || w.to_sym

          } #.map(&:to_i)

        when 1

          x.to_i

      else

        err :inp, x

      end
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

  Q = %w{
    A K Q T 9 8 7 6 5 4 3 2 J
  }.reverse#.freeze

  V = {}

  class C
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

  def run a

    Q.each_with_index {
      |w, i|

      v = N.include?(w) && w.to_i || w.to_sym

#      err :w, w, v, i

      V[v] = i
    }

#    binding.irb
#    err :a, a.size, V

    s = []

    a.each {
      |h, b|

      t = typ(h)

      s[t] ||= []
      s[t] << C.new(h, b)

#      deb :h, h, t, l: true

#      err :s, s
    }

    s -= [nil]

    s.each {
      |t|

      t.sort!

      t.map!(&:to_i)
    }

    s.flatten!


    r = 0

    s.each_with_index {
      |v, i|

      r += v * (i+1)
    }

    r

#    err :s, s

    #def b.[](i)
    #  err :oor, i if isi?(i) && i < 0
    #  super(i) || 0
    #end

  end

  def typ h

#    h = h.sort
    t = h.tally
    i = t.invert
    v = t.values.tally

    j = t[:J] || 0

    r = \
    case

      when t.size == 1
        6

      when t.size == 2
        i[4] ?
          5
        :
          4

      when i[3]
        3

      when v[2] == 2
        2

      when v[2] == 1
        1

      when v[1] == 5
        0

    else
      err :typ, h, t, i, v

    end

    if j && j >= 1
      j.times {
        r = \
        case r
          when 0
            1

          when 1
            3

          when 2
            4

          when 3
            5

          when 4 # FH
            5

          else
            6
        end
      }

      r = 3 if r > 3 && v[1] && v[1] == 3
      r = 5 if r > 5 && v[1] && v[1] == 2
    end

    if j >= 2
      case
        when r == 5 && j == 2 && v[2] == 2
        when r == 3 && j == 2 && v[1] == 3
        when r == 6 && j == 2 && v[3] == 1
        when r == 6 && j == 3 && v[2] == 1
        when r == 5 && j == 3 && v[1] == 2
        when r == 6 && j >= 4

      else
        deb :J, h, t, i, v, r

      end
    end

    r
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
