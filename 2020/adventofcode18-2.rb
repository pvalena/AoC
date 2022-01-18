#!/usr/bin/ruby -W0

require_relative 'class'

class R
  def initialize
    # data
    a = \
      inp {
        |x, i|

        sym(x) {
          |y|

          if ('0'..'9').to_a.include? y
            y.to_i

          elsif ['(',')'].include? y
            y

          end
        }
      }

    @a = a
  end

  def run a = @a

    # init
    s = 0

    # loop
    a.each_with_index {
      |v, i|
      deb :run, s, i
      s += nex v.flatten
    }

    # end
    s
  end

  def nex a, r = 0, o = nil
    return r if a.empty?

    c = a.shift

    deb :nex, r, o, c, a.join(' ')

    case c
      when :+
        err c unless o.nil?
        nex a, r, c

      when :*
        err c unless o.nil?
        r * nex(a)

      when '('
        f, s = cls a
        v = nex f

        if o
          deb :o, r, o, v
          v = roc r, o, v

        else
          err :q, r unless r == 0

        end

        nex s, v

      when ')'
        err :w, c, a

      else
        v = roc r, o, c

        nex a, v

    end
  end

  def roc r, o, c

    case o
      when :+
        r + c

      when :*
        r * c

      when nil
        err :roc, r, o, c unless r == 0
        c

      else
        err :roc, r, o, c

    end
  end

  def cls a, j = 0, i = 0
    i = a[j..].index(')') || (a.size - j - 1)
    s = a[j..(i+j)].index '('

    #deb :cls, j, [(s ? s+j : s), j+i]

    return cls a, i+j+1 unless s.nil?

    b = a[j+i+1..]
    a = a[..i+j]

    ass :eb, a.last == ')'
    a.pop

    pra [a], 3
    pra [b], 3

    [a, b]
  end
end

DEB = false

res R.new.run
