#!/usr/bin/env -S ruby

require_relative 'class'

class R

  def initialize

    err :arg if ARGV.size < 2
    c = arg

    # data
    a = \
      inp {
        |x, i|

        x = to_i x.split(?,)

      } - ['']

    @l = (c == 1)

    b = \
    Benchmark.measure {
      @r = run a, c
    }

    deb :b, b.real
  end

  def run a, b = 0
    # init
    #err :x, a

    if b == 1
      l = 4138658

    elsif b == 2
      l = 19690720

    else
      err :b, b, "ARG: 1 = part 1", "ARG: 2 = part 2"

    end

    a = a.first

    r = (0..99)
    r.each {
      |n|
      r.each {
        |v|

        m = dcl a

        m[1] = n
        m[2] = v

        m = nex(m)

        #err :m, m if m && m.first
        return [n, v, m] if m && m.first == l
      }
    }

    err :nf
  end

  def nex c, i = 0

    loop {
      r1, r2, w = c[i+1], c[i+2], c[i+3]

      #deb :nex, i, [c[i], r1, r2, w], c

      case c[i]
        when 1
          return unless san c[w], c[r1], c[r2]
          c[w] = c[r1] + c[r2]
          
        when 2
          return unless san c[w], c[r1], c[r2]
          c[w] = c[r1] * c[r2]
          
        when 99
          return c

        else
          #deb :else, c[i]
          return
      end

      i += 4
    }
  end

  def san *n
    !n.include?(nil)
  end

  def fin r, l = @l

    deb :fin, r.first(2)

    return r.last.first if l

    n, v = r

    100 * n + v
  end

  def to_s
    r = fin @r
    r.to_s
  end   
end

#DEB = false

res R.new
