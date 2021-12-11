#!/usr/bin/ruby

require 'colorize'
require 'ap'
alias :p :pp

DEB = true

def d *i
  if DEB
    p (i.size == 1 ? i[0] : i)
    puts
  end
end

def e
  exit
end

# Data Load
dat = ARGF.readlines
  .map {
    |l|
    l.chomp.split('')
      .map { |z| z.to_i }
  }

puts

S = 2000
V = 10

class RL
  def initialize q
    @v = 0
    @a = q
    q = nil

    1.upto(S) do
      |s|

      #d :step, s if s % V == 0

      @a.map! {
        |x|

        x.map! {
          |y|

          y += 1
        }
      }

      @a.each_with_index {
        |x, i|

        x.each_with_index {
          |_, j|

          next unless @a[i][j] > 9

          #d 's', i, j, @a[i][j]

          f = [[i, j]]

          loop do
            n = []

            f.each {
              |(g, h)|

              ass g, h, g.kind_of?(Numeric), h.kind_of?(Numeric), \
                  @a[g][h], @a[g][h] > 9, @a[g][h] != 0

              # Flash
              @v += 1
              @a[g][h] = 0
              #d 'f', g, h, @a[g][h]

              #[ pa, e ] if @v > 32

              (-1).upto(1).each {
                |a|

                (-1).upto(1).each {
                  |b|

                  # skip self
                  next if a == 0 && b == 0

                  z = a + g
                  w = b + h

                  # boundaries
                  next if z < 0 || w < 0 || @a[z].nil? || @a[z][w].nil?

                  # already flashed
                  next if [0, 10].include? @a[z][w]

                  # Affected by flash
                  @a[z][w] += 1
                  #d 'a', z, w, @a[z][w]

                  n << [z, w] if @a[z][w] > 9
                }
              }
            }

            f = n
            n = []

            break if f.empty?
          end
        }
      }

      [ pa(s), e ] if \
      @a.all? {
        |z|
        z.all? {
          |x|
          x == 0
        }
      }

      pa s if s % V == 0
    end
  end

  def d *i
    if DEB
      p (i.size == 1 ? i[0] : i)
      puts
    end
  end

  def ass(*a)
    a.each {
      |z|
      abort "Abort: #{a.inspect}" unless z
    }
  end

  def to_s
    @v.to_s
  end

  def to_i
    @v #self.to_s.to_i
  end

  def pa s
    return unless DEB

    d :step, s

    print "  "
    @a[0].each_with_index {
      |_, i|

      print "  #{i}"
    }
    puts

    print "  "
    @a[0].each_with_index {
      |_, i|

      print "  ─"
    }
    puts

    @a.each_with_index {
      |x, i|

      print "#{i}│"

      x.each {
        |z|
        y = z.to_s

        print ' ' * (3 - y.size)
        print (
            if z == 0
              y.red

            elsif z > 9
              y.green

            else
              y
            end
          )
      }
      puts
    }
    puts
  end

  def pac
    return unless DEB
    @a.each {
      |x|

      print ' '

      x.each {
        |y|

        print (
            y == 0 ? (

              y.to_s.red

            ) : (

              y.to_s

            )
          )

      }
      puts
    }
    puts
  end
end

#d dat

#  d '========================================================='
#  system 'clear'

puts RL.new(dat)
