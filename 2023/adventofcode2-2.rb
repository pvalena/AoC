#!/usr/bin/env -S ruby

DEB = false

require_relative 'class'

class R
  def initialize

    puts
    @a = arg

    n, s, g, t = nil
    #n = false
    s = false
    g = false
    #t = false

    j = nil
#    a = {}
    a = \
    inp(n, s, g, t) {
      |x, i|

      if s.nil?
        #eval x
#        x.to_i
#        to_sym(x)
#        x

#        x.split('').map {
#          |w|
#
#          m.include?(w) && w.to_i || w
#
#        } #.map(&:to_i)

      else
        x.shift(2)

        xs = x.map { |z| z.to_s }
        xi = x.map { |z| z.to_i }

        xs.shift

        b = []        
        bb = {}

        xs.each_with_index {
          |w, ii|

          next if ii % 2 == 1

          w = w.split('')
          v = w.pop
          e = v == ';'
          w << v unless e || v == ','
          w = w.join.to_sym

          bb[w] = xi[ii]

          if e
            b << bb
            bb = {}
          end

        }

        b << bb

#        err :inp, b

#        case s
#          when :Game
#            next
#
#          when :Each
#
##            c = 0
#
#            #a[ x[1] ] = [ x[4].split(?=)[1].to_i, x[9..] ]
#
#          else
##            err :inp, i, x, @s
#
#        end


#        t = xs[1+c]
#
#        a[n][t] ||= []
#        a[n][t] += [
#            [ xs[5+c], xi[4+c] ],
#            [ xs[8+c], xi[7+c] ]
#          ]
#
#        a[n][t] -= [[nil,nil]]

      

      end
    }

    ben {
      @run = run a
    }
  end

  Q = {
    start: :'@',
    wall: :'#',
    pass: :'.',
  }

  A = {
    :red => 1,
    :green => 1,
    :blue => 1
  }

  def run a
#    err :a, a

    a = \
    a.each_with_index.map {
      |g, i|

      g = \
      g.inject(Hash.new(0)) {
        |b, j|

        deb :bj, b, j

        j.each {
          |c, k|

          dss :k, k, b[c]

          b[c] = max [ k, b[c] ]
        }

        b
      }

      g.values.reduce(:'*')
    }

#    err :a, a

    #def a.[](i)
    #  err :oor, i if isi?(i) && i < 0
    #  super(i) || 0
    #end

    @@c = a.sum

#    a.each_with_index {
#      |g, i|
#
#    }

    deb :run, @@c, o: true

    @@c
  end
end

res
