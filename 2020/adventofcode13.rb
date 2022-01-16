#!/usr/bin/ruby -W0

require_relative 'class'

class R
  def initialize
    @z = inp {
      |x, i|

      x.split(?,).map(&:to_i) - [0]
    }
  end

  def run z = @z

    a, s = z
    a = a[0]

    b = \
    s.each_with_index.map {
      |x, i|

      x += s[i] while x < a
      x

    }

    d = b.min
    i = b.index d

    (d - a) * s[i]
  end
end

DEB = false

res R.new.run
