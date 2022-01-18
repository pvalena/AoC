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

        next if x == :'0'

        err x, i unless [:'1', :X].include? x

        g << [2 ** i, x != :X]
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
    #deb :r, m
    m.values.sum # % 2**36
  end

  def nex c, g, m

    j, v = c

    #err :i, c, j, v, g

    g.reject! {
      |(w, x)|

      if x
        #deb :t, w, j, w | v
        j |= w

        x
      end
    }

    if g.any?
      a = adr g, j
      a.uniq!

      ass :nex, c, j, a.size, g.size, a.size == 2 ** g.size, \
            v > 0

      a.each {
        |i|

        ass :x, i > 0, i < 2**36

        m[i] = v
      }

    else
      m[j] = v

    end

  end

  def adr g, j
    g = dcl(g)
    w = g.shift.first

    #return [] unless w

    #err w, j, g

    v = j | w
    a = \
      j == v ? [j - w, j] : [j, v]

    #deb :adr, w, v, j, a, g

    if g.any?
      r = []

      a.each {
        |x|

        r += adr g, x
      }

      a += r
    end

    a
  end
end

# DEB = false

res R.new.run
