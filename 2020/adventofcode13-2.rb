#!/usr/bin/ruby -W0

require_relative 'class'

class R
  def initialize
    # data
    a = \
      inp {
        |x, i|

        x.split(?,).map(&:to_i)

      }[1]

    g = []
    a.each_with_index {
      |x, i|

      g << i unless x == 0
    }
    a -= [0]
    @a = a

    h = \
      hsh {
        |i|
        g[i+1] ? g[i+1] - g[i] : 0
      }
    @h = h
  end

  def dif y, t = 0,  a = @a, h = @h
    d = 0

    if t < y
      a[t..].each_with_index {
        |x, i|
        i += t

        break unless i < y
        d -= h[i]
      }

    else
      a[y..].each_with_index {
        |x, i|
        i += y

        break unless i < t
        d += h[i]
      }

    end

    d
  end

  def mul t, f, s, d

    z, v, n = nil, nil, nil

    until v && n && z
      v = n

      t += d
      t += d until (t + f) % s == 0
      n = t / d

      z = n - v if v
    end

    z
  end

  def run a = @a, h = @h

    # init
    d = a.max
    y = a.index d
    t = dif y

    c = dcl a
    c[y] = 0
    #s = c.max
    #f = dif a.index(s)
#    z = mul t, f, s, d
 #   t += d until (t + f) % s == 0

    m = -1
    l = a.size - 1


    # loop

    o = -1
    n, v = nil, nil, nil
    z = 1

    deb :run, d, t, z
    while true

      t += d * z
      m = nex a, h, t, m

      break unless m < l

      if m >= o
        if v && m == o
          n = t / d
          z = n - v

          deb :z, o, z
          n, v = nil, nil
          o += 1

        else
          v = t / d

          deb :o, m, o, v
          o = m
          m -= 1

        end
      end

    end

    # end
    t
  end

  def nex a, h, q, m

    a.each_with_index {
      |x, i|

      return m unless q % x == 0

      m = i if i > m

      q += h[i]
    }

    m
  end
end

#DEB = false

res R.new.run
