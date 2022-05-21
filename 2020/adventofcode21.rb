#!/usr/bin/env ruby -W0

require_relative 'class'

class R
  def initialize
    # data
    a = \
      inp {
        |x, i|

        case x
          when '(contains'
          when ''
          else
            x.gsub(/[(),]/, '')
        end

      } - ['']

    c = { }
    b = { }

    a.each do
      |z|

      l = []
      while z.any?
        if z[0].nil? 
          z.shift

          break
        end

        l << z.shift
      end

      b[l] = z

      l.each {
        |q|

        c[q] ||= []
        c[q] += dcl z
        c[q].uniq!
      }
    end

    @a = b
    @c = c
  end

  def run a = @a, c = @c
    # init
    l = { }
    deb a

    # loop
    while true
      q = nex(c, l, a)

			break unless q

			err :run, c, l, q

      if q
        cln c, l, q
        next
      end

      deb :run, c, l

      err :fin
    end

    sel c, l, a
  end

  def nex c, l, a

    deb :nex, c, l

    c.each {
      |x, y|

      next if y.empty?

      y.select! {
        |z|

        next if l[z]

        a.none? do
          |w, v|

          r = (v.include?(z) and !w.include?(x))

		      #deb :r, [x,z] if r

		      r
        end  
      }

#      l[q] = x

      #return q
    }

    false
  end

  def cln c, l, q
    c.each {
      |x, y|

      next if y.empty? or y.one?

      #deb :cln, y, q
      y.delete q
    }
  end

  def sel c, l, a

		q = \
    c.map {
      |x, y|

      x if y.empty?

    } - [nil]

		q = \
		a.map {
			|x, y|

			r = (q&x).size

			deb :sel, x, r

			r
		}

		q.sum
  end

end

#DEB = false

res R.new.run
