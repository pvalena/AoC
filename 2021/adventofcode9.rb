#!/usr/bin/ruby

require 'ap'
alias :p :pp

DEB = false

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
    l = l.chomp.split('')
      .map {
        |x|
        x.to_i
        #.map { |z| z }
      }
  }

puts

class RL
  def initialize a
    @v = a

    @l = \
    a.each_with_index.map {
      |x, i|

      x.each_with_index.map {
        |y, j|

        f = \
        (-1).upto(1).map {
          |a|
          (-1).upto(1).map {
            |b|
            next if (a == b && b == 0)
            # up or down only
            next unless a == 0 or b == 0

            z = a+i
            w = b+j

            next if z < 0 || w < 0 || @v[z].nil? || @v[z][w].nil?

            #d 'l', z, w, @v[z][w], y, (@v[z][w] > y) if i == 0 && j == 1

            @v[z][w] # > y) ? @v[z][w] : 9
          }

        }.flatten - [nil]

        #p ['l', i,j, f]

        f.min
      }
    }

    @v = 0
    a.each_with_index {
      |x, i|

      print "#{i}: " if DEB

      x = \
      x.each_with_index {
        |y, j|

        v = @l[i][j]
        #print @l[i][j].to_s + " "

        ass i, j, y, v

        print (v > y ? y.to_s : ' ')

        @v += 1 + y if v > y
      }
      puts
    }
    puts
  end

  def d *i
    if DEB
      p (i.size == 1 ? i[0] : i)
      puts
    end
  end

  def nm
    return @nm if @nm

    @nm = {
        a: @e.dup,
        b: @e.dup,
        c: @e.dup,
        d: @e.dup,
        e: @e.dup,
        f: @e.dup,
        g: @e.dup
      }

    def @nm.r
      return @r if @r

      @r = []
    end

    def @nm.q v
      v.split('')
        .map! {
          |w|
          w.to_sym
        }
        .sort
    end

    def @nm.i x, v, n
      v = q v if v.kind_of?(String)
      v.sort!

      ass 'nm.i:xv', x, v, n, x.size == v.size

      r[n] = v unless r[n]

      (r[8] - x).each do
        |z|
        self[z] -= v
      end

      x.each do
        |z|
        self[z] = \
        self[z].select {
          |m|
          v.include? m
        }
      end
      n
    end

    def @nm.u
      return @u if @u

      @u = {}
    end

    def @nm.e x, v
      v = q v

      u[v.size] ||= []
      u[v.size] << v unless u[v.size].include? v

      v
    end

    def @nm.ass(*a)
      a.each {
        |z|
        abort "Abort: #{a.inspect}" unless z

      } if DEB
    end

    def @nm.df a,b
      ((a - b) + (b - a))
    end

    def @nm.s x, a, b
      return false unless a && b

      v = df(a, b)

      ass 'nm.s:v', a, b, v, v.size == 1
      v = v[0]

      ass 'nm.n:x', x, x.kind_of?(Symbol)
      ass 'nm.n:v', v, v.kind_of?(Symbol)

      self[x] = [v]
    end

    def @nm.c
      unless @c
        @c = Hash.new {
          |h, (l, v)|

          self.keys.each {
            |i|
            unless i == l
              self[i] -= v if self[i].include? v[0]

              ass 'nm.c:r', i, v, l, !self[i].empty?

            else
              ass 'nm.c:c', i, self[i], v, self[i].one?, self[i] == v

            end
          }
        }
      end

      keys.each {
        |x|

        @c[[x, self[x]]] if self[x].one?
      }
    end

    @nm
  end

  def ass(*a)
    a.each {
      |z|
      abort "Abort: #{a.inspect}" if z.nil?
    } if DEB
  end

  def to_s
    @v.to_s
  end

  def to_i
    @v #self.to_s.to_i
  end
end

d dat


#  d '========================================================='
#  system 'clear'

r = RL.new(dat)

puts r
