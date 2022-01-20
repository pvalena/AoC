#!/usr/bin/env -S ruby

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
            sym q

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

      w = w.first if w.size == 1

      h[i] = w
    }

    a.map! {
      |q|

      ass :qs2, q, q.size, q.size == 1

      q = q.first
    }

    run a, h
  end

  def run a = @a, q = @h

    # init
    s = 0

    i = 0
    h = []

    q.each {
      |k, v|

      h[k] = v
    }

    #err :a, a, h

    # loop
    a.each_with_index {
      |v, i|
      #deb :run, v

      v = sym v
      r = dcl h

      q = val r, v, r[0]

      s += 1 if q

      #err :run, s, q, v.join
    }

    # end
    @r = s
  end

  def to_s
    @r.to_s
  end

  def val h, v, r

    while r.any? && v.any?

      a = h[r.shift]

      if iss? a
        return false unless a == v.first

        v.shift

      elsif isi? a
        r.unshift(a)

      else
        ass :case, a, a.size, v.join, r, isa?(a), a.class

        case a.size
          when 1
          when 2
            return val h, v, a + r

          when 3
            ass :t3, a[1] == nil

            t1 = a.first
            t2 = a.last

            ass :t3, t1, t2

            bv = dcl v
            
            return true if val h, v, [t1] + r

            return val h, bv, [t2] + r
          
          when 5
            ass :t5, a[2] == nil

            t1 = a.first(2) - [nil]
            ass :t51, t1.size == 2

            t2 = a.last(2) - [nil]
            ass :t52, t2.size == 2

            #err :t5, t1, t2


            bv = dcl v
            
            return true if val h, v, t1 + r

            return val h, bv, t2 + r

          else
            err :else, a

        end
      end
    end

    #deb :ret, v, r

    r.empty? && v.empty?
  end
end

#DEB = false

res R.new
