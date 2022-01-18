#!/usr/bin/ruby -W0

require_relative 'class'

class R
  def initialize
    # data
    a = \
      inp(false) {
        |x, i|

        x.split(/[:\-, ]/)
        #.map(&:to_i)
      }

    t = 0
    g = [{}]

    a.each_with_index {
      |x, i|

      if x.empty?
        t += 1
        g[t] = []
        next
      end

      case t
        when 0
          x.reverse!
          g[t][x[3..].join(' ').to_sym] = to_i [x[2], x[0]]

        else
          g[t] << to_i(x)

      end
    }

    g[2].shift
    g[1].shift

    @h = g[0]
    @t = g[1]
    @n = g[2]
  end

  def run h = @h, n = @n, t = @t

    # init
    e = []

    dss :run, h, t

    # loop
    n.each {
      |v|

      e += nex h, v
    }

    # end
    e.sum
  end

  def nex h, v
    v.reject {
      |w|

      val h, w
    }
  end

  def val h, w
    h.any? {
      |k, v|

      v.any? {
        |(f, t)|

        w >= f && w <= t
      }
    }
  end
end

#DEB = false

res R.new.run
