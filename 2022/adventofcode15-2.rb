#!/usr/bin/env -S ruby

DEB = false

require_relative 'class'

class R

  def initialize

    @s = arg.to_i
    
    @s == 0 && @s = 4000000

    @d = (0..@s)

    a = \
    inp(s: false) {
      |x, i|

      #next if x == '->'

      #(to_i x.split(?,)).reverse!

      x = x.gsub(/[,:]/,' ').split

      case x[0]
        when 'Sensor'
          (x[2..3] + x.last(2)).map { |z| z.split(?=)[1].to_i }
        else
          err :ix, i, x, @s
      end

      #x = eval x


      #x = to_sym x
    }

    ben {
      @r = run a
    }
  end

  def run a, l = @s

    deb :a, a.size, l, o: true

    a = \
    a.map {
      |x|

      s = [x[1], x[0]]
      b = [x[3], x[2]]

      [s, b]
    }
    a.uniq!

    #err :a, a

    b = \
    a.map {
      |z|
      bec(*z)

    }.uniq

    w = \
    a.map {
      |z|
      bec(*z, 1)

    }.uniq

#    deb :b, b
#    deb :w, w

    x, y = nil, nil

    w.reverse.any? {
      |z|
      x, y = play(b, z, l)
    }

    if DEB && false
      sb = a.inject([]) {
        |k, v|

        k + v
      }

      err :Sb, sb

      out
    end 

    dss :xy, x, y

    4000000 * y + x
  end

  def bec f, y, c = 0

    d = man(f, y) + c

    #deb :bec, f, y, d, o: true

    D.map {
      |r|

      [ r[0]*d + f[0], r[1]*d + f[1] ]
    }
  end

  def play w, x, u

    deb :play, x, o: true

    r = [0, u]

    x.each {
      |a|

      x.each {
        |b|

        next unless a[1] <= b[1] && a[0] != b[0] && a[1] != b[1]

        i = -1

        ran(a[0], b[0]) {
          |l|

          i += 1

          next if l < 0 || l > u

          #err :ab, a, b, l

          #if a[1] > u
          #if b[1] > u

          if a[0] <= b[0] && a[1] <= b[1]

            j = a[1] + i


          elsif a[0] >= b[0] && a[1] <= b[1]

            j = b[1] - i

          else
            err :ab, a, b, l

          end

          next unless j && j >= 0 && j <= u

          z = [l, j]
          return z unless inr?(w, z)
        }

      }

    }

    nil
  end

  def inr? w, x

    dss :inw, x

    w.any? {
      |z|

      ina?(z, *x)
    }
  end

  def ina? z, x, y

    j = []

    z.each {
      |a|

      z.each {
        |b|

        next unless a[1] <= b[1] && a[1] != b[1]

        r = (a[0]..b[0])
        g = (b[0]..a[0])

        #dss :ina, r, g

        if a[0] == b[0] && x == a[0]

          return ran(a[1], b[1]).include?(y)

        elsif r.include?(x) || g.include?(x)

          if a[0] <= b[0]

            j << b[1] - (b[0] - x)

          elsif a[0] >= b[0]

            j << a[1] + (a[0] - x)

            #err :ab2, j, a, b

          else
            err :ab, a, b, l

          end

        end

      }
    }

    unless j.empty?
      j.uniq!

      #dss :z, j, z

      ass :j, j, [1, 2].include?(j.size)

      unless block_given?

        return y == j[0] if j.one?

        return ran(*j).include?(y)

      end

      return [x, j[0]] if j.one?

      ran(*j) {
        |v|
        yield v 
      }
    end
  end

  def out(w, s = [], wc: '#'.colorize(:cyan), sc: 'X'.colorize(:green))

    return unless DEB

    w = dcl w
    s = dcl s

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

    super(a, w, b: false, h: false)
  end
end

res R.new
