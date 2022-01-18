#!/usr/bin/ruby -W0

require_relative 'class'

class R
  def initialize
    # data
    a = \
      inp(false) {
        |x, i|

        x.split(/[:\-, ]/)
        #.map(&:to_i)
      }

    t = 0
    g = [{}]

    a.each_with_index {
      |x, i|

      if x.empty?
        t += 1
        g[t] = []
        next
      end

      case t
        when 0
          x.reverse!
          g[t][x[3..].join(' ').to_sym] = to_i [x[2], x[0]]

        else
          g[t] << to_i(x)

      end
    }

    g[2].shift
    g[1].shift

    @h = g[0]
    @t = g[1][0]
    @n = g[2]
  end

  def run h = @h, n = @n, t = @t

    # init
    e = []
    r = []

    dss :run, h, t

    # loop
    n.map! {
      |v|

      nex h, v, r

    }
    n -= [nil]

    r.map!(&:uniq)

    n.each {
      |v|

      ass :fit, n, h, v, r

      fit h, v, r
    }

    r = to_s r.map(&:uniq)

    v = []
    while r != v
      v = dcl r

      cln r
    end

    # end
    r = \
    r.each_with_index.map {
      |x, j|
      x = x[0]

      if x =~ /departure/
        deb x, j, t[j]
        t[j]
      end

    } - [nil]

    mul r
  end

  def cln r
    r.each_with_index {
      |y, i|

      next unless y.size == 1

      r.each_with_index {
        |x, j|

        next if i == j

        r[j] -= y

      }
    }
  end

  def fit h, a, r

    a.each_with_index {
      |w, i|

      h.each_with_index {
        |(k, v)|

        next unless r[i].include? k

        y = \
          v.any? {
            |(f, t)|

            #deb :f, w, :>, k, [f, t], r[i]

            w >= f && w <= t
          }

        r[i] -= [k] unless y

      }

    }
  end

  def nex h, a, r
    return unless \
      a.all? {
        |w|

        val h, w
      }

    a.each_with_index {
      |w, i|

      h.each_with_index {
        |(k, v)|

        v.each_with_index {
          |(f, t), j|

          #deb :h, w, :>, [k, j], [f, t]

          if w >= f && w <= t

            r[i] ||= []
            r[i] << k

          end
        }

      }

    }

    a
  end

  def val h, w
    h.any? {
      |k, v|

      v.any? {
        |(f, t)|

        w >= f && w <= t
      }
    }
  end
end

#DEB = false

res R.new.run
