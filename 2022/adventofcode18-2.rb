#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

class R

  def initialize

#    @s = arg.to_i

    a = \
    inp(s: false) {
      |x, i|

      #next if x == '->'

      #err :inp, x

      unless true
        x = x.gsub(/[,:;]/,' ').split.each_with_index.map {
          |z, i|

          if i == 4
            z
          else
            z.to_sym
          end
        }

        case x[0]
          when :Valve
          
            #dss :x, x

            a[ x[1] ] = [ x[4].split(?=)[1].to_i, x[9..] ]

          else
            err :ix, i, x, @s
        end
      end

      #x = eval x
      #x = to_sym x
      x = (to_i x.split(?,))
    }

    ben {
      @r = run a
    }
  end

  def run a
    dss :run, a.size

    s = []
    t = \
    a.inject(0) {
      |k, x|

      k + play(x, s)
    }

    dss :tot, t

    r = [
        [min(a), max(a)],
        [min2(a), max2(a)],
        [min3(a), max3(a)]
      ]

    r.each {
      |q|
      return t unless q[1] - q[0] > 1
    }

    f = poc a, r

    s = []
    f = \
    f.inject(0) {
      |k, x|

      k + play(x, s)
    }

    dss :fre, f

    t - f
  end

  def surf r
    f = []

    ran(*r[0]) {
      |x|
      ran(*r[1]) {
        |y|
        ran(*r[2]) {
          |z|

          f << [x, y, z] if \
               r[0].include?(x) \
            || r[1].include?(y) \
            || r[2].include?(z)

        }
      }
    }

    f
  end

  def play q, s
    a, b, c = q

    s << q

    D3.inject(0) {
      |k, (x, y, z)|

      t = [ a+x, b+y, c+z ]

      r = s.include?( t )

      unless r
        k + 1
      else
        k - 1
      end
    }
  end

  def poc a, r

    f = surf(r)
    f -= a

    r.each {
      |q|
      q[0] += 1
      q[1] -= 1
    }

    u = []
  
    ran(*r[0]) {
      |g|
      ran(*r[1]) {
        |h|
        ran(*r[2]) {
          |i|

          x = [g, h, i]

          next if a.include?(x) 

          if near(f, x)
            f << x
          else
            u << x
          end
        }
      }
    }

    b = 0

    while u.any? && u.size != b
      b = u.size

      u.reject! {
        |x|
        
        f << x if near(f, x)
      }
    end

    u
  end

  def near f, w
    a, b, c = w
  
    D3.any? {
      |(x, y, z)|

      t = [ a+x, b+y, c+z ]

      f.include?( t )
    }
  end

  def out(w, s = [], wc: '#'.colorize(:cyan), sc: '-'.colorize(:green), o: false)

    return unless DEB || o

    w = dcl w
    s = dcl s

    # flip

    w.map! {
      |(x, y)|

      [-x, y]
    }

    s.map! {
      |(x, y)|

      [-x, y]
    }

    m = [0, 0]
    n = [E, E]
    d = 2

    #deb :w, w

    # store
    w += s

    w.each {
      |l|

      [0, 1].each {
        |i|
        m[i] = l[i] if l[i] > m[i]
        n[i] = l[i] if l[i] < n[i]
      }
    }

    r, c = n
    c -= d
    
    w.map! {
      |l|

      [ l[0] - r, l[1] - c ]
    }

    # load
    s = w.last(s.size)

    x, y = m[0] - r + d, m[1] - c + d

    a = [ [ wc ] * y ] * x
    a = dcl a

    #err :w, w.size, s.size

    s.each {
      |g|
      set(a, g, sc)
    }

    super(a, w, b: false, h: false, o: true)
  end
end

res R.new
