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
  }

puts

E = {
  '[' => ']',
  '<' => '>',
  '(' => ')',
  '{' => '}'
}

V = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4,
}


class RL
  def c x
    s = []

    x.each {
      |y|

      if E[y]
        s << y

      else
        ass y, E.key(y)

        o = s.pop

        unless E.key(y) == o

          #d y, :from, s
          return
        end
      end
    }

    s
  end

  def initialize a
    @v = a

    a.map! {
      |x|

      c x
    }

    a -= [nil]

    #d 'w', a

    a.map! {
      |x|
      x.reverse.map {
        |z|
        ass z, E[z]
        E[z]
      }
    }

    #d 'o', a

    puts a.map { |z| z.join }, "\n"

    @v = \
    a.map {
      |b|
      b.inject(0) {
        |t, v|
        t * 5 + V[v]
      }
    }.sort[a.size / 2]
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


#d dat

#  d '========================================================='
#  system 'clear'

r = RL.new(dat)

puts r
