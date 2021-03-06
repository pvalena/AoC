#!/usr/bin/ruby -W0

require_relative 'class'

class R
  def initialize
    # arg
    @l = arg

    # data
    a = \
      inp {
        |x, i|

        x.split(?,).map(&:to_i)
      }[0]

    h = {}
    n = nil

    a.each_with_index {
      |x, i|

      n = h[x] || 0
      h[x] = i+1
    }

    @n = n #a.last
    @h = h
  end

  def run h = @h, n = @n, l = @l

    # init
    t = h.size + 1

    dss :run, t, h, h.size, n, l

    # loop
    while t < l
      n = nex t, h, n

      t += 1
    end

    # end
    n
  end

  def nex t, h, c

    #m = h.key h.values.min

    v = h[c]
    h[c] = t

    n = v ? t - v : 0

    #deb :nex, t+1, c, v, '->', n, h

    n
  end
end

DEB = false

res R.new.run
