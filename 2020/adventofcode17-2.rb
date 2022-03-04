#!/usr/bin/ruby -W0

require_relative 'class'

class R
  def initialize
    # data
    a = \
      inp {
        |x, i|

        x.split('')
      }

    c = cor
    k = []

    a.each_with_index {
      |x, i|

      #c[0][i] = {}

      x.each_with_index {
        |y, j|

        set(c, k, true, [0, 0, i, j]) if y == '#'

#        c[0][i][j] = y == '#'

    }}
    k.uniq!

    @c = c
    @k = k
  end

  def cor
    c = \
      Hash.new {
        |h, v|

        h[v] = \
          Hash.new {
            |a, b|

            a[b] = \
              Hash.new {
                |d, e|

                d[e] = \
                  Hash.new( false )
              }
          }
      }
  end

  def set h, k, v, *i
    i = i[0] if i.one?

    a, b, c, d = i
    err :set, a, b, c, d, i unless i.size == 4

    h[a][b]    ||= {}
    h[a][b][c] ||= {}

    h[a][b][c][d] = v
    k << [a, b, c, d] if v

    #err :deb, h[0].keys, v, [a, b, c], h[a][b][c]
  end

  def get h, *i
    i = i[0] if i.one?

    a, b, c, d = i
    err :get, a, b, c, d unless i.size == 4

    h[a][b][c][d]
  end

  def run c = @c, k = @k
    # init
    prc c, k

    # loop
    6.times {
      |i|
      (c, k) = nex(c, k)

      deb :run, i+1
      prc c, k if i <= 2 && DEB

      #err :fst, c[-1]
    }

    prc c, k
  end

  def prc q, k, n = [], t = 0
    o = [0] * 4

    k.each {
      |i|

      v = get(q, i)
      next unless v

      4.times {
        |x|
        o[x] = i[x] if i[x] < o[x]
        #m[x] = i[x] if i[x] > m[x]
      }
    }

    k.each {
      |i|

      v = get(q, i)
      next unless v

      a, b, c, d = i

      oa, ob, oc, od = o

      n[a - oa]                         ||= []
      n[a - oa][b - ob]                 ||= []
      n[a - oa][b - ob][c - oc]         ||= []
      n[a - oa][b - ob][c - oc][d - od]   = v

      t += 1 if v
    }

    #deb :a, q, n

    pr4(n) {
      |x, y|

      y = x ? '#'.red : ' '

      [?_, y]

    }

    t
  end

  def ara a, w, n = 0

    -1.upto(1) { |g|
    -1.upto(1) { |x|
    -1.upto(1) { |y|
    -1.upto(1) { |z|

      next if [0,0,0,0] == [g, x, y, z]

      begin
        c = add [g, x, y, z], w

      rescue
        err :c, [g, x, y, z], w

      end

      #deb :w, c, get(a, c)

      n += 1 if get(a, c)

    }}}}

    ass :ara, w, n
    n
  end

  def act n, s
    if s
      n == 3 || n == 2
    else
      n == 3
    end
  end

  def nex c, k, l = []

    k.each {
      |v|

      next unless get c, v

      -1.upto(1) { |g|
      -1.upto(1) { |x|
      -1.upto(1) { |y|
      -1.upto(1) { |z|

        l << add([g, x, y, z], v)

      }}}}

    }
    l.uniq!


    a = cor
    k = []

    l.each {
      |w|

      n = ara c, w
      s = get c, w

      if act n, s
        #deb :act, w, n, s
        set(a, k, true, w)

      end

    }
    k.uniq!

    [a, k]
  end
end

DEB = false

res R.new.run
