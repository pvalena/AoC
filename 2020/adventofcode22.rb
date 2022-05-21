#!/usr/bin/env ruby -W0

require_relative 'class'

class R
  def initialize
    # data
    a = \
      inp {
        |x, i|

        case x
          when 'Player'
          when ''
          else
            x.gsub(/[(),:]/, '')
        end

      } - ['']

    c = { }
    q = nil

    a.each do
      |z|

      if z.kind_of? Array
        err :z, z unless z.first == nil

        q = z[1].to_i
        next
      end

      c[q] ||= []
      c[q] << z.to_i
    end

    @c = c
  end

  def run a = @a, c = @c
    # init

    # loop
    while true
      q = nex c

      break unless q
    end

    fin c
  end

  def nex c

    o = car c, 1
    t = car c, 2

    unless o && t
      o ||= t
      t ||= o
      c[2].unshift(t) if c[1].empty?
      c[1].unshift(t) if c[2].empty?
      return
    end

    if o > t
      c[1] += [o, t]  

    else
      c[2] += [t, o]  

    end

    return true
  end

  def car c, x
    c[x].shift
  end

  def fin c

    l = c.detect {
      |x, y|

      y.any?
    }

    l = l[1].reverse

    deb :fin, l

    l.each_with_index.sum {
      |v, i|

      v * (i+1)
    }
  end

end

#DEB = false

res R.new.run
