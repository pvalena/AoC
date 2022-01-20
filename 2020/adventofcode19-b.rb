#!/usr/bin/ruby -W0

require_relative 'class'

class R
  def initialize
    # data
    a = \
      inp(false) {
        |x, i|

        x = x.split(/[:\-, "]/)
      }

    r = []

    r << a.shift until a.first.empty?

    ass :sp, a.first.empty?, r, a

    a.shift

    r.map! {
      |w|

      w.map {
        |q|

        q.shift if q.size == 2 && q.first == ""

        ass :qs, q, q.size, q.size == 1

        q = q.first

        case q
          when "|"
          when ''
          when "a".."z"
            q

          when "0".."999"
            q.to_i

          else
            err :q, q

        end
      }
    }

    h = {}

    r.each {
      |w|
      i = w.shift

      ass :ws, i, w, w.size, [1, 2, 3, 5].include?(w.size) \
        unless i == 0

      w = w.first if w.size == 1 && w.first.kind_of?(String)

      h[i] = w
    }

    a.map! {
      |q|

      ass :qs2, q, q.size, q.size == 1

      q = q.first
    }

    @a = a
    @h = h
  end

  def run a = @a, h = @h

    # init
    s = 0

    # loop
    a.each_with_index {
      |v, i|
      #deb :run, v

      v = v.split('')
      r = dcl h[0]

      q, v = val h, v, r
      s += 1 if q && v.empty?

      deb :r, i, s, q, v.join, r, o: true
    }

    # end
    s
  end

  def val h, v, r, i = 0

    #ass :h, v, r, h[r.first]

    a = h[r.shift].dup

    dss :v, i, v.join, a, r
    i += 1

    w = dcl v

    if a.kind_of?(String)
      t = v.shift
#        deb :a, a, t, a==t

      ass :s, t, a, t.kind_of?(String), a.size == 1

      return [false, w] unless a == t
    else
      ass :s2, a, a.kind_of?(Array), a.class

      case a.size
        when 1
        when 2
          q, v = val h, v, a, i

          return [false, w] unless q

        when 3
          t = [a.shift]

          t2 = a.shift
          ass :t3, [t2], t2 == nil

          q, v = val h, v, t, i

          unless q

            t = [a.shift]

            v = dcl w

            deb :b, i, v.join, t

            q, v = val h, v, t, i

            return [false, w] unless q
          end

        when 5
          t = a.shift(2)
          ass :t, t.size == 2

          t2 = a.shift
          ass :t3, [t2], t2 == nil

          q, v = val h, v, t, i

          unless q
            t = a.shift(2)
            ass :t2, t.size == 2

            v = dcl w

            #deb :b, i, v.join, t

            q, v = val h, v, t, i

            return [false, w] unless q
          end

        else
          err :a, a, a.size, a.class

      end
    end

    unless r.empty? || v.empty?
#      deb :con, v, r
      q, v = val h, v, r, i

      return [false, w] unless q
    end

    return [false, w] unless r.empty?

    [true, v]
  end
end

#DEB = false

res R.new.run
