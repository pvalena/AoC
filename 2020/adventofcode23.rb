#!/usr/bin/env ruby -W0

require_relative 'class'

class R
  def initialize
    # data
    a = \
      inp(true) {
        |x, i|

        x.split('').map { |z| z. to_i }

      } - ['']

    @c = a.first
  end

  def run c = @c
    # init

    # loop
    100.times do
      nex c

      fin c
    end

    fin c
  end

  def nex c
    q = c.shift
    g = c.shift(3)

    d = q
    until c.include? d
      d = d - 1
      d = c.max if d < 0
    end

    i = c.index(d) + 1

    deb :nex, q, c, g, d, i

    c.insert(i, g)
    c.flatten!

    c << q
  end

  def fin c
    c = dcl c

    #deb :fin, c
    
    i = c.index(1)

    c.rotate!(i)
    c.shift

    c.join
  end

end

#DEB = false

res R.new.run
