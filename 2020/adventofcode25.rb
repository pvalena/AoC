#!/usr/bin/env -S ruby

require_relative 'class'

class R

  S = 7
  R = 20201227

  def initialize
    # data
    a = \
      inp {
        |x, i|

        x.to_i

      } - ['']

    b = \
    Benchmark.measure {
      run a
    }

    deb :b, b.real
  end

  def run a
    # init

#    err :a, a

    s = dec a

    #e = ver a, s

    e = enc a, s

    @r = e
  end

  def enc a, s

    unless s[0] < s[1]
      a.rotate!
      s.rotate!
    end

    l = s[0]
    k = a[1]

    deb :enc, l, k

    n = 1

    l.times {
      n = (n * k) % R
    }

    n
  end

  def dec a

    c, d = \
      a.map do
        |n|

        (0..).detect {
          |s|
          tra(s) == n
        }
      end

    deb :dec, c, d

    [c, d]
  end

  def ver a, s

    c, d = s

    x, y = tra(d, a[0]), tra(c, a[1])

    err :f, x, y unless x == y

    return x
    
    ####

    i = 1

    loop do
      n = 0
      i *= 10

      deb :i, i 

      10.times {
        m = n
        n = m + i

        r = (m...n)

        r.each {
          |x|

          x += c

          e = tra x

          r.each {
            |y|

            y += d

            #err :xy, x, y, e, tra(y)

            return e if e == tra(y)
          }
        }
      }
    end
  end

  def tra n, s = S
    @t ||= []

    unless @t[s]
      @t[s] = hsh {
        |h, v|

        (h[v-1] * s) % R
      }
      @t[s][0] = 1
    end

    @t[s][n]
  end

  def fin r

    r
  end

  def to_s
    r = fin @r
    r.to_s
  end   
end

#DEB = false

res R.new
