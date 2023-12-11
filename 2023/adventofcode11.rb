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

    a = []
    f = true

    a = \
    inp(n, s, g, t) {
      |x, i|

#      err :inp, x

        #eval x
#      x.to_i
#      if f
#        f = false
      w = to_sym(x)
#      else
#        x.to_sym
#      end

      w.map {
        |x|

        true if x == :'#'
          
#        else
#          N.include?(x[0]) && x[0].to_i || x.to_sym
#        end
      }

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

  Q = {
    :|  => [[-1, 0], [1,  0]],
    :-  => [[0, -1], [0,  1]],
    :L  => [[-1, 0], [0,  1]],
    :J  => [[-1, 0], [0, -1]],
     7  => [[0, -1], [1,  0]],
    :F  => [[1,  0], [0,  1]],
    '.' => [],
  }

  def run a

#    err :a, a

    o = [true] * a.first.size

    a.each_with_index {
      |w, i|

      w.each_with_index {
        |g, j|

        o[j] = nil if g

      }
    }

#    err :o, o

    b = {}
    z = [0, 0]

    a.each_with_index {
      |w, i|

      unless w.any? { |v| v }
        z[0] += 1
        next
      end

      z[1] = 0

      w.each_with_index {
        |g, j|

        if o[j]
          z[1] += 1
          next
        end

        next unless g

        r = nex [i, j], z

        b[r] = g
      }
    }

    out b

#    err :b, b.size, o

		v = []
		d = 0

		b.keys.each {
			|f|

			b.keys.each {
			 |s|

				g = [f, s].sort

				next if v.include?(g)

				v << g

#				d += (f[0] - s[0]).abs *

				d += man(*g) 

			}
		}

		d

    #def b.[](i)
    #  err :oor, i if isi?(i) && i < 0
    #  super(i) || 0
    #end

  end

  def rcs a, k, l, r = [], &b

    v = a[k]

#    err :v, v, k

    return unless v

    if v == :S
#      out a, [k], r

      r << k
    
      return r
    end

    d = Q[v]

    ass :d, d, v, k

    d = \
    d.map {
      |o|

      nex k, o
    }

    if r.any?
      unless d.include?(r.last)
        out a, d, k

        err :v, v, d, r.last, k
      end

      d -= r + [l]
    end

#    err :k, k, v, d

#    r = r.dup
    r << k

#    out a, d, r
    
#    deb :x, k, v, d, l: true

    d.each {
      |x|

      z = \
      rcs a, x, k, r, &b

      return z if z
    }

    return
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

  def out a, s = [], t = [], **h

#    t = [t]

    f = a.keys
#    s = s.keys
#    t = t.keys if ish?(t)

    fc = '#'.colorize :cyan
    sc = 'x'.colorize :red
    tc = '.'.colorize :green

    @outc = nil

    super(f, s, t, fc: fc, sc: sc, tc: tc, d: 1, h: false) {
      |g, h|

      a[[g, h]].to_s.colorize :cyan
    }
  end
end

res
