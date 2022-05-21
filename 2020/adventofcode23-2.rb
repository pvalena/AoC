#!/usr/bin/env -S ruby

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

    b = \
    Benchmark.measure {
      run
    }

    deb :b, b.real
  end

  TST = false
  NEX3 = false

  def run c = @c
    # init
    m = 1000_000

    unless NEX3
      i = 0

    else
      i = 1

      h = Hash.new {
        |h,v|

        v = hi(v, m)
        h[ v ] = v
      }

      c.each_with_index {
        |x, i|
        h[i+1] = x
      }
    end

    x = c.max + 1
    c += (x..m).to_a

    c1 = dcl c if TST

    # loop
    t = 10_000_000
    t = 10_000 if TST

    t.times do
      |z|

      i = \
      unless NEX3
        i = nex c, i, z
        c[i] ? i : 0

      else
        nex3 h, i, m, z

      end

      if TST
        nex1 c1, z

        err :t, c, c1 unless fin1(c) == fin1(c1)
      end
    end

    deb :f, fin1(c) if TST

    @c = c
  end

  def nex c, i, m
    deb :c, c if TST

    q = c[i]
    g = c.slice!(i+1, 3)

    while g.size < 3
      g << c.shift
    end

    d = q - 1
    while g.include?(d) || d <= 0
      d = d - 1
      d = c.max if d <= 0
    end

    j = c.index(d) + 1

    #deb :nex2, m+1, c.rotate(j), q, g, d, j

    c.insert(j, *g)

    i = c.index(q) + 1
  end

  def nex1 c, m
    q = c.shift
    g = c.shift(3)

    d = q
    until c.include? d
      d = d - 1
      d = c.max if d < 0
    end

    i = c.index(d) + 1

    deb :nex1, m+1, ([q] + c).rotate(i+1), q, g, d, i

    c.insert(i, g)
    c.flatten!

    c << q
  end

  def nex3 h, i, m, z
    deb :h, h #if TST

    q = h[ hi(i, m) ]
    g = [ h[ hi(i+1, m) ], h[ hi(i+2, m) ], h[ hi(i+3, m) ] ]
    h[ hi(i+1, m) ], h[ hi(i+2, m) ], h[ hi(i+3, m) ]  = nil, nil, nil

    d = q - 1
    while g.include?(d) || d <= 0
      d = d - 1
      d = m if d <= 0
    end

    j = h.key(d) + 1

    err :g, g, h, d, j

    #deb :nex2, z+1, c.rotate(j), q, g, d, j

    c.insert(j, *g)

    i = c.index(q) + 1
    #i += 1 + (j < i ? 3 : 0)
  end

  def hi v, m
    v % m
  end

  def to_s c = @c
    c = dcl c

    #deb :fin, c
    
    i = c.index(1)

    c.rotate!(i)
    c.shift

    r = c[0] * c[1]

    deb :fin, Time.now, c[0], c[1], r

    r.to_s
  end

  def fin1 c
    c = dcl c

    #deb :fin, c
    
    i = c.index(1)

    c.rotate!(i)
    c.shift

    c.join
  end
end

#DEB = false

res R.new
