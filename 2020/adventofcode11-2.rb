#!/usr/bin/ruby -W0

require_relative 'class'

class R
  def initialize
    @z = inp {
      |x, i|

      sym x

    }
  end

  def pr z = @z
    pra(z){
      |a, b|

      b = \
      case a
        when :L
          b.blue

        when :'#'
          b.red

        else
          ' '
      end

      [a, b]
    }
  end

  def rox i, j, z = @z
    c = 0

    -1.upto(1).each {
      |a|
      xd = i + a

      -1.upto(1).each {
        |b|
        y = j + b
        x = xd

        loop {
          break unless [a, b] != [0, 0] \
              && bor(z, x, y)

          case z[x][y]

            when :'#'
              c += 1
              break

            when :L
              break

          end

          x += a
          y += b
        }

      } if z[xd]

    }

    c
  end

  def nex z = @z
    n = false

    @z = \
    z.each_with_index.map {
      |x, i|

      x.each_with_index.map {
        |y, j|

        next if y.nil? || y == :'.'

        c = rox(i, j) {
          |v|
        }

        if y == :L && c == 0
          y = :'#'
          n = true

        elsif y == :'#' && c >= 5
          y = :L
          n = true

        end

        y
      }
    }

    n
  end

  def run z = @z

    x = 0

    while nex
      deb :r, (x+=1)
      pr
    end

    @z.flatten.tally[:'#']
  end
end

DEB = false

res R.new.run
