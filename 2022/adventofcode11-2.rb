#!/usr/bin/env -S ruby --yjit

#DEB = false

require_relative 'class'

class R

  def initialize
    # data
    a = []
    n = 0
    t = (:A..:Z).to_a
    j = -1

    inp(true, false) {
      |x, i|

      x = x.gsub(/[,:]/,' ').split

      next if x.empty?

      x = \
      case x[0].to_sym
        when :Monkey
          n = x[1].to_i
          next

        when :Starting
          l = :i
          to_i(x[2..]).map {
            |z|
            j += 1
            [ t[j], z ] 
          }

        when :Operation
          l = :o
          [ x[4].to_sym, x[5].to_i ]

        when :Test
          l = :t
          x[3].to_i

        when :If
          l = x[1] == 'true'
          x[5].to_i

        else 
          err :inp, x, i
      end

      a[n] ||= { s: 0 }
      a[n][l] = x

      nil
    }

    b = \
    Benchmark.measure {
      run a
    }

    deb :b, b.real, o: true
  end

  def run a

    r = [0] * 4

    z = a.inject(1) {
      |w, q|

      #err :q, q[:t]

      w *= q[:t]

    } * 1000

    10_000.times {
      |i|
      i += 1
      
      a.each_with_index {
        |q, qi|

        play a, q, z
      }

      #dss :run, a.each_with_index.map { |z, g| [g, z[:i].sort] }

      next unless !DEB || i % 1000 == 0 || i == 1 || i == 20
      #next unless i % 3 == 0

      n = fin(a)

      deb(i, n)
    }

    @r = mul( fin(a).max(2) )
  end

  def play a, m, z

    #dss :play, n, m[:i]

    m[:i].each {
      |(l, i)|

      ins a, i, l, m, z
    }
    m[:i] = []

  end

  def ins a, i, l, m, z
    o, v = m[:o]

    m[:s] += 1

    case o
      when :*
        v = i if v == 0
        err :*, v unless v > 0

        i *= v

      when :+
        err :+, v unless v > 0

        i += v

      else
        err :ins, o, v
    end

    #i /= 3

    t = (i % m[:t]) == 0

    #i = i / m[:t] if t

    i = i % z

    n = m[t]

    #ass :ins, i, n

    a[n][:i] << [l, i]
  end

  def fin a
    a.map {
      |x|
      x[:s]
    }
  end

  def out v
    g = []

    0.upto(W-1) {
      |i|

      g[i] = v[i] ? '#' : ' '

    }
    puts g.join
  end

  def to_s
    @r.to_s
  end   
end

res R.new
