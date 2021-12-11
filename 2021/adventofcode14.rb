#!/usr/bin/ruby

require 'colorize'
require 'ap'
alias :p :pp


 I = 40

class RL
  DEB = true

  def initialize a
    @v = 0

    # Data Load
    @t = sym(ARGF.first.chomp)
    ARGF.first
    d @t

    @c = a.readlines
      .map {
        |l|
         l = l.chomp.split
         [sym(l[0]), sym(l[2])]

      }.sort.uniq

    d @c

    I.times {
      |i|
      run
      puts ">> #{i}: " + @t.size.to_s
      res
    }
  end

  def res
    t = @t.tally
    v = @t.tally.values

#    d v.max, v.min

    @v = v.max - v.min

    d @v, v.max, v.min, t
  end

  def sym x
    x = \
    x.split('')
     .map! {
      |z|
      z.to_sym
    }

    if x.size == 1
      x[0]
    else
      x
    end
  end

  def run
    pa

    t = []
    @c.each {
      |w, v|

      @a[w].each {
        |i|
        t << [i, v]
      }
    }

    t .sort
      .reverse
      .each {
        |(i,v)|
        #d 'e', i, v
        @t.insert i, v
      }

#    d 't', @t
  end

  def pa
    r = nil

    if false

      @a = \
      @t.map do
        |y|
        [r, y] if r
      ensure
        r = y
      end - [nil]

    else

      @a = Hash.new([])

      @t.each_with_index do
        |y, i|
        @a[[r, y]] += [i] if r
        r = y
      end

    end
  end

  def da z, n = 5
    i = 0
    print "\n", '['
    loop {
      print ' ' unless i == 0
      print z[i...i+n].map { |x| x.inspect.to_s }.join(', ')
      i += n
      break unless z[i]
      puts ", "
    }
    print ']'
  end

  def l f
    @c.map! {
      |(x,y)|

      if f[0] == :y && y > f[1]

        v = y - f[1]
        #d [x, y], '->', [x, y - v*2]
        [x, y - v*2]

      elsif f[0] == :x && x > f[1]

        v = x - f[1]
        #d [x, y], '->', [x, y - v*2]
        [x - v*2, y]

      else

        [x, y]

      end
    }

    @c.uniq!
  end

  def d *i
    if DEB
      while i.respond_to?(:size) && i.size == 1
        i = i[0]
      end

      p i
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

  def e *z
    d z unless z.nil? || z.empty?
    exit
  end

  def to_i
    @v #self.to_s.to_i
  end

  def sp n = 1
    print ' ' * n
  end
end

#d dat

#  d '========================================================='
#  system 'clear'

puts
puts RL.new(ARGF)
