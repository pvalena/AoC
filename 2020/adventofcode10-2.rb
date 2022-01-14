#!/usr/bin/ruby -W0

require_relative 'class'

class R
  def initialize
    @z = inp {
      |x, i|

      x.to_i

    }.sort

    @r = 3

    @d = {}
  end

  def val x, v
    x && (x - v) <= 3

  end

  def h z = @z
    @h ||= \
      Hash.new {
        |h, s|

        v = z[s]

        a = z.size - 1 <= s ? 1 : 0

        1.upto(3) {
          |c|
          i = s + c
          w = z[i]

          #deb v, s, w, i

          break unless val w, v

          a += h[i]
        }

        h[s] = a
      }
  end

  def run z = @z, d = @d, r = @r

    z.unshift 0
    z << z.max + 3

    h[0]
  end
end

res R.new.run
