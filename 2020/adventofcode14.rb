#!/usr/bin/ruby -W0

require_relative 'class'

class R
  def initialize
    # data
    a = \
      inp {
        |x, i|

        x.split(/[\]\[= ]/) #.map(&:to_i)  - [0]
        #x.split(?,).map(&:to_i)
      }

    @a = \
      a.map {
        |x|
        case x[0][0]
          when 'mask'
            [ true ] + msk(x[2][0])

          when 'mem'
            i = x[0][1].to_i
            v = x[2][0].to_i

            [ false, i, v ]

          else
            err x

        end
      }
  end

  def msk s
    g = []
    sym(s)
      .reverse
      .each_with_index {
        |x, i|

        next if x == :X

        g << [2 ** i, x == :'1']
      }
    g
  end

  def run a = @a

    # init
    m = {}
    g = []

    # loop
    a.each {
      |x|

      if x.shift
        g = x

      else
        nex x, g, m

      end
    }

    # end
    deb :r, m
    m.values.sum
  end

  def nex c, g, m

    j, v = c

    #deb :i, j, v, g

    g.each {
      |(w, x)|

      if x
        #deb :t, w, v, w | v
        v |= w

      else
        #deb :f, w, v, (w | v)
        v -= w if v == w | v

      end
    }

    #deb :nex, c, v

    m[j] = v
  end
end

DEB = false

res R.new.run
