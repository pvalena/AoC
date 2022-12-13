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

    ben {
      @r = run a
    }
  end

  def run a
    #err :a, a

    k = [ [[2]], [[6]] ]
    a += k

    i = 0
    b = []

    while b != a
      b = dcl a

      a = sra a

      z = [ a.shift, a.pop ]

      a = sra a

      a = [z.first] + a + [z.last]
      
      i += 1 
    end

    deb :a, i, a

    x = 1
    a.each_with_index {
      |v, i|

      x *= (i+1) if k.include?(v)
    }

    x
  end

  def sra a
    b = []

    while a.any?
      # dss :run, i

      v = a.shift(2)

      r = rux( *v )

      #deb r

      v.reverse! if r == false

      b += v
    end

    b
  end

  def rux x, y
    #eut a, x

    x, y = dcl(x), dcl(y)

    #dss :rux, x, y #, v

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
