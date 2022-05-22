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

      nex c, z
    end

    @c = c
  end

  def nex c, z
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

    deb :xy, xy, c[xy]
  end

  def to_s c = @c
    c = dcl c

#    err :f, c

    r = \
    c.map {
      |k, v|

      v ? 1 : 0

    }.sum

    deb :fin, Time.now, r

    r.to_s
  end
end

#DEB = false

res R.new
