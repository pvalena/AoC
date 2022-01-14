#!/usr/bin/ruby -W0

require_relative 'class'

class R
  def initialize
    @z = inp {
      |x, i|

      x.to_i
    }

    @t = 1930745883
  end

  def run z = @z, t = @t

    r = 0
    #t = 127

    z.each_with_index {
      |_, i|

      r -= 1 while r > 0 && z[r..i].sum < t

      #deb :m, r

      r += 1 while r < (i-1) && z[r..i].sum > t

      #deb :p, r, r < (i-1), z[r..i].sum > t

      r -= 1 if r == i
      r = 0 if r < 0

      #deb :t, z[r..i], z[r..i].sum

      if z[r..i].sum == t
        x = z[r..i]

        return x.min + x.max
      end
    }
  end
end

res R.new.run
