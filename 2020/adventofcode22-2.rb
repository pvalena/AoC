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

  def run c = @c, s = false
    # init
    b = []

    # loop
    while true
      q = nex c, b

      break unless q.eql? 0
    end

    return q if s

    #err :fin, q, c, s

    fin c
  end

  def nex c, b
    o = dec c, 1
    t = dec c, 2

    if b.include? [o, t]
      #deb :pl1, c

      return 1
    end
    b << [o, t]

    #

    o = car c, 1
    t = car c, 2

    unless o && t
      o ||= t
      t ||= o
      c[2].unshift(t) if c[1].empty?
      c[1].unshift(t) if c[2].empty?
      return (c[1].empty? ? 2 : 1)
    end

    z = \
    if c[1].size >= o && c[2].size >= t
      r = gam c, o, t

      r == 1
    else
      o > t

    end

    if z 
      c[1] += [o, t]  

    else
      c[2] += [t, o]  

    end

    return 2 if c[1].empty?
    return 1 if c[2].empty?

    return 0
  end

  def gam c, o, t
    n = {}

    sel c, n, 1, o
    sel c, n, 2, t

    run n, true
  end

  def sel c, n, x, m
    n[x] = c[x].first(m)
  end

  def dec c, x
    c[x].join(?,)
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
