#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

class R

  def initialize

    a = \
    inp {
      |x, i|

      #x = x.gsub(/[,:]/,' ').split

      x = to_sym x
    }

    b = \
    Benchmark.measure {
      run a
    }

    deb :b, b.real, o: true
  end

  def run a

    x = nil

    a.each_with_index.detect {
      |r, i|

      r.each_with_index.detect {
        |v, j|

        x = [i, j] if v == :S
      }
    }

    set(a, x, :a)

    @m = 700
    @w = val(:E)
    @c = 0
    @o = []
    @d = {}

    (100 * 60 * 12).times {
      |i|
      #deb :play, i if i % 10 == 0 

      #break if \
      play a, x, r: 3
    }

    @r = @m
  end

  def set a, l, z
    i, j = l

    a[i][j] = z
  end

  def get a, l
    i, j = l

    val(a[i][j])
  end

  def val d
    S.find_index d
  end

  S = (:a..:z).to_a + [:E]

  D = [0, -1, 1].inject([]) {
        |k, i|

        if i == 0
          [-1, 1].each {
            |j|
            k << [0, j]
          }
        else
          k << [i, 0]
        end

        k
      }

  def play a, x, h = val(:a), v = [], r: 1

    #ass :play, x, h #, v

    if h == @w
      @m = v.size
      @o = dcl v

      deb :o, pri(@o)

      out a, v

      deb :E, @m

      return true
    end

    return unless v.size + 1 < @m

    v = dcl v
    v << x

    return unless !@d.keys.include?(x) || v.size < @d[x].size

    @d[x] = v

    #out a, v if v.size > 1 && @c % 100_000 == 0
    #@c += 1

    s = []

    D.map {
      |d|

      n = [ d[0] + x[0],  d[1] + x[1] ]

      next unless bor(a, *n)

      z = get(a, n)

      next unless z <= h+1 && !v.include?(n)

      #dss :z, z, n
      
      s << [z, n]
    }

    #b = dcl s

    #dss :b, b

    if rand(r).eql?(0)
      s.sort!
      s.reverse!

    else
      s.shuffle!

    end

    #err :s, s if s != b

    s.each {
      |(z, n)|
      f = play a, n, z, v

      #return f if f
    }

    nil
  end

  def out a, v

    a = \
    a.each_with_index.map {
      |r, i|

      r.each_with_index.map {
        |g, j|

        g if v.include? [i, j]
      }
    }

    pra(a, 0) {
      |x|
      x ? x : ' '
    }
  end

  def to_s
    @r.to_s
  end   
end

res R.new
