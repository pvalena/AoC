#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

class R

  def initialize

    #@s = arg

    a = \
    inp() {
      |x, i|

      x = eval x

      #err :ix, i, x

      #x = x.gsub(/[,:]/,' ').split

      #x = to_sym x
    }

    b = \
    Benchmark.measure {
      run a
    }

    deb :b, b.real, o: true
  end

  def run a

    #err :a, a

    x = 0
    i = 1

    while a.any? do
      dss :run, i

      v = a.shift(2)

      r = rux( *v )

      deb r

      x += i unless r == false

      i += 1
    end

    @r = x
  end

  def rux x, y
    #eut a, x

    dss :rux, x, y #, v

    while x.any? && y.any?
      l = x.shift
      r = y.shift

      z = play l, r

      next if z.nil?
      return z
    end

    return nil if x.empty? && y.empty? 

    x.empty?
  end

  def play l, r

    li, ri = isi?(l), isi?(r)
    la, ra = isa?(l), isa?(r)

    #deb :play, l, r unless li && ri

    if li && ri

      return nil if l == r

      l < r

    elsif la && ra

      rux l, r

    elsif li && ra

      rux [l], r

    elsif ri && la

      rux l, [r]

    else
      err :play, l, r, li, ri, la, ra

    end
  end

end

res R.new
