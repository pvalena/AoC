#!/usr/bin/env -S ruby

require_relative 'class'

class R
  def initialize
    # data
    a = \
      inp {
        |x, i|

        case x
          when 'Tile'
          when ''
          else
            x.gsub!(':', '')

            x.split('')
        end

      } - ['']

    c = cor
    k = []
    q = 0
    o = 0
    s = nil

    while o < a.size
      a[o..].each_with_index {
        |x, i|
        o += 1

        if x.first.nil? && x.size == 2
          q = x[1].join.to_i
          break
        end

        ass :q, q > 0

        s = x.size - 1

        x.each_with_index {
          |y, j|

          set(c, k, true, [q, i, j]) if y == '#'
        }
      }
    end

    k.uniq!

    @c = c
    @k = k
    @s = s
  end

  def cor
    c = \
#      Hash.new {
#        |h, v|

#        h[v] = \
          Hash.new {
            |a, b|

            a[b] = \
              Hash.new {
                |d, e|

                d[e] = \
                  Hash.new( false )
              }
          }
#      }
  end

  def set h, k, v, *i
    i = i[0] if i.one?

    a, b, c = i
    err :set, a, b, c, i unless i.size == 3

    h[a][b]    ||= {}
 #   h[a][b][c] ||= {}

    h[a][b][c] = v
    k << [a, b, c] if v

    #err :deb, h[0].keys, v, [a, b, c], h[a][b][c]
  end

  def get h, *i
    i = i[0] if i.one?

    a, b, c = i
    err :get, a, b, c unless i.size == 3

    h[a][b] #[c][d]
  end

  def prc q, k, l, n = [], t = 0, z = 3

    l = l.keys

    k.each {
      |i|

      v = get(q, i)

      next unless v && l.include?(i[0])

      a, b, c = i

      n[a]        ||= []
      n[a][b]     ||= []
      n[a][b][c]    = v

      t += 1 if v
    }

    pr3(n) {
      |x, y|

      y = x ? '#'.red : ' '

      [?_, y]
    }

    t
  end

  def run c = @c, k = @k, s = @s
    # init
    l = { c.keys.first => [0, 0] }

    # loop
    while true
      (q, v) = nex(c, l, s)

      if q
        l[q] = v
        next
      end

      prc c, k, l
      deb :run, l

      err :fin
    end

#    prc c, k, l
  end

  def nex c, l, s

    l.each {
      |w, (x, y)|

      o = [[x, y-1], [x, y+1], [x-1, y], [x+1, y]]

      o.each {
        |(g, h)|

        next if l.value?([g, h])

        c.each {
          |q, _|

          next if l.key?(q)

          r = cmp c, l, g, h, w, q, s

          #err :nex, r, [g,h], q if r
          return [q, [g, h]] if r

        }
      }
    }

    return [false, l]
  end

  def cmp c, l, x, y, w, q, s
    r = \
    case
      when l[w][0] < x
        :u
      when l[w][0] > x
        :d
      when l[w][1] > y
        :r
      when l[w][1] < y
        :l
      else
        err :r, l[w], [x,y]

    end

    cw = c[w]
    cq = c[q]

    z = \
    if [:d, :u].include? r

      wx, qx = s, 0
      wx, qx = qx, wx if r == :u

      ass :sx, cw[wx], cq[qx]

      z = \
      (0..s).all? {
        |i|

        ass :wx, i, cw[wx], cq[qx]

        cw[wx][i] == cq[qx][i]
      }

      err :sx, cw[wx], cq[qx], r if (cw[wx] == cq[qx]) != z

    else
      wy, qy = s, 0
      wy, qy = qy, wy if r == :l

      ass :sy, cw[0], cq[0]

      (0..s).all? {
        |i|

        ass :wy, i, cw[i], cq[i]

        cw[i][wy] == cq[i][qy]
      }

    end

    deb :cmp, q, [x, y] if z
    z
  end
end

#DEB = false

res R.new.run
