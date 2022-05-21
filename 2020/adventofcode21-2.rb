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
    int(c, l, a)

    # loop
    while true
      q = nex c, l, q

			#deb :run, c, l, q

      break unless q

      cln c, l, q
    end

    fin l
  end

  def int c, l, a
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
  end

  def nex c, l, q
    c.each {
      |x, y|

      next unless y.one?

			q = y.first

			err :cln, q, x if l[q] || !q

      l[q] = x

			return q
    }

    return false
  end

  def cln c, l, q
    c.each {
      |x, y|

      next if y.empty?

      #deb :cln, y, q
      y.delete q
    }
  end

  def fin l

		r = \
		l.keys.sort.map {
			|z|

			#deb :f, z, l[z]

			l[z]
		}

		deb :fin, r

		r.join(',')
  end

end

#DEB = false

res R.new.run
