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
      case a
        when :L
          b.blue

        when :'#'
          b.red

        else
          ' '
      end
    }
  end

  def nex z = @z
    n = false

    @z = \
    z.each_with_index.map {
      |x, i|

      x.each_with_index.map {
        |y, j|

        next if y.nil? || y == :'.'

        c = rou(z, i, j) {
          |v|
          v == :'#'
        }

        if y == :L && c == 0
          y = :'#'
          n = true

        elsif y == :'#' && c >= 4
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
