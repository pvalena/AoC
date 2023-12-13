#!/usr/bin/env -S ruby

DEB = false

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
#      w = to_sym(x)
#      else
#        x.to_sym
#      end


#      f = false

      if i % 2 == 0
        to_sym(x).map(&:to_s)

      else
        x.split(',').map(&:to_i)

      end
#        .map {
#          |w|
#
#          N.include?(w) && w.to_i || w.to_sym
#
#        } #.map(&:to_i)


#      w.map {
#        |x|
#
#        if x[0] == ?.
#          x[0]
#        else
#          N.include?(x[0]) && x[0].to_i || x.to_sym
#        end
#      }

#        dss :inp, z, isi?(z) || i == 0
#
#      case i
#        when 0
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
    }

    ben {
      @run = run a
    }
  end

  # cons
  Q = {
  }

  def run a
    a = ini a

    # main loop
    s = 0
    a.each_with_index.map {
      |b, i|

      n = rcs(*b)

      deb :n, i, n

      s += n

#      break if i >= 8
    }

    # postprocess

#    out b, w
#    err :deb, :w, w.size

    # result
    s

    #def b.[](i)
    #  err :oor, i if isi?(i) && i < 0
    #  super(i) || 0
    #end
  end

  def ini a = Q
    a.each {
      |b|

      b.first.map! {
        |q|

        case q
          when ?.
            false

          when ?#
            true

          when ??
            nil

        else
          err :q, q

        end
      }
    }
  end

  def eva b, n = [], c = 0, l = nil

    b.each {
      |v|

#     TODO: partial result
#      return n if v.nil?
      return if v.nil?

      if v
        c += 1

      elsif c > 0
        n << c
        c = 0

      end
    }

    n << c if c > 0
    n
  end

  def rcs b, n, r = 0

    v = eva b

    if v == n
      if DEB
        $stderr.puts "  : " \
          + b.map { |w| w ? '#' : '.' }.join('')
      end
      return 1
    end

#
#    v.each_with_index {
#      |w, i|
#
#      j = n[j]
#
#      return if 
#    }

    b.each_with_index {
      |x, i|

      next unless x.nil?

      b[i] = true
      r += rcs b, n

      b[i] = false
      r += rcs b, n

      b[i] = nil

      break
    }

    return r
  end

  def blb a = Q
    a.map! {
      |b|

      b, n = b

      c = 0
      l = nil

      d = []

      b.each {
        |q|

        if q != l && l
          ent d, l, c

          c = 0
        end

        c += 1

        l = q
      }

      ent d, l, c

      [d, n]
    }
  end

  def ent d, l, c
    return unless c > 0 && l != ?.

    l = l == ??

    d << [l, c]
  end

  def out a, s = [], t = [], **h

#    t = [t]

    f = a.keys

    t = \
    a.keys.select {
      |g|

      a[g] != true
    }
    
    t -= s
#    s -= f

#    s = s.keys
#    t = t.keys if ish?(t)

    fc = '.'.colorize :green
    sc = 'x'.colorize :red
    tc = '#'.colorize :cyan

    @outc = nil

    super(f, s, t, fc: fc, sc: sc, tc: tc, d: 1, h: false, **h) {
      |g, h|

      a[[g, h]].to_s.colorize :cyan
    }
  end

#
#  class O
#    attr_reader :h
#  
#    def initialize(h, b)
#      @h = h
#      @b = b
#    end
#
#    def <=> other
#      o = other.h
#
#      @h.each_with_index {
#        |v, i|
#
#        v = V[ v ]
#        w = V[ o[i] ]
#
#        ass :vw, v, w
#
#        r = v <=> w
#
#        next if r == 0
#
##        deb :cmp, @h, o, r, l: true
#        return r
#      }
#
#      err :idk, o, @h, l: true
#    end
#
#    def to_i
#      @b
#    end
#  end

#  def sea b, k
#
#    f = \
#    are(b, k, n: true) {
#      |x, v|
#
#      err :v, x, v, l: true
#
#      next unless v
#
#      deb :v, x, v, l: true
#
#      v
#    }
#
#    err :f, f
#
#    f.map! {
#      |v|
#
#      v.sort!
#
#      v.inject('') {
#        |s, w|
#
#        s + w[1].to_s
#
#      }.to_i      
#    }
#
#    deb :sea, k, f
#
#    f[0] * f[1]
#  end
end

res
