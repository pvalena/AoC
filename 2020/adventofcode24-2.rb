#!/usr/bin/env -S ruby

require_relative 'class'

class R

  Dirs = {
    e:  [+0, +2],
    se: [-1, +1],
    sw: [-1, -1],
    w:  [+0, -2],
    nw: [+1, -1],
    ne: [+1, +1]
  }

  def initialize
    # data
    a = \
      inp {
        |x, i|

        sym x

        #x.split('')
        #.map { |z| z. to_i }

      } - ['']


    Dirs.map {
      |(k, v)|
      
      q = sym(k.to_s)

      [q, v] unless k == q

    }.each {
      |(k, v)|

      next if k.nil?
      
#      deb :d, k, v

      Dirs[k] = v
    }

    b = \
    Benchmark.measure {
      run a
    }

    deb :b, b.real
  end

  def run a
    # init
    c = Hash.new(false)

    a.each do
      |z|

      int c, z
    end

    Dirs.select! {
      |d, v|

      iss? d
    }

    100.times do
      |z|

      c = nex c, z

      #f = fin(c)
      #err :z, z+1, f if z == 0 && f != 15
    end

    @c = c
  end

  def int c, z
    xy = [0, 0]

    r = nil

    z.each {
      |d|

      d = [r, d] if r

      (r = d; next) unless Dirs.include?(d)
      r = nil

      xy = add(xy, Dirs[d])

      ass :nex, d, Dirs[d], xy
    }

    c[xy] = !c[xy]

    #deb :xy, xy, c[xy]
  end

  def nex c, z
    n = Hash.new(false)

    c.each {
      |(k, v)|

      next unless v

      if inv c, n, k, true
        n[k] = true
      end
    }

    n
  end

  def inv c, n, k, l = false
    x, y = k

    s = 0

    Dirs.map {
      |d, v|

      t = add(k.dup, v)

      if c[t]
        s += 1

      elsif l
        if inv c, n, t
          n[t] = true
        end
      end
    }

    if c[k]
      !( s.zero? || s > 2 )

    else
      s == 2

    end
  end

  def fin c
    c = dcl c

#    err :f, c

    r = \
    c.map {
      |k, v|

      v ? 1 : 0

    }.sum

    deb :fin, Time.now, r

    r
  end

  def to_s
    r = fin @c
    r.to_s
  end   
end

#DEB = false

res R.new
