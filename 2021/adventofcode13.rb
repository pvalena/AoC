#!/usr/bin/ruby

require 'colorize'
require 'ap'
alias :p :pp

class RL
  DEB = false

  def initialize a
    @v = 0

    # Data Load
    @f = []
    @c = a.readlines
      .map {
        |l|
         l.chomp
          .split(?,)
          .map {
            |z|
            x = z.split
            if x[0] == 'fold'
              @f << x[2].split(?=)
              break
            elsif !z.empty?
              z.to_i
            end
          }

      }.select {
        |x|
        x.size == 2 if x.respond_to?(:size)

      }.sort

    @f.map! {
      |z|
      [ z[0].to_sym, z[1].to_i ]
    }

    run
  end

  def run
    @f.each {
      |f|
      d f
      pa f

      l f
    }

    @v = @c.size
    pa(o: true)
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

  def pa f = [], o: false
    return unless DEB or o

    unless @a
      @a = []

      @m = @c.inject(0) {
        |i, x|
        x[0] > i ? x[0] : i
      }

      @n = @c.inject(0) {
        |i, x|
        x[1] > i ? x[1] : i
      }
    end

    @v = 0

    0.upto(@n) {
      |y|
      @a[y] = []

      0.upto(@m) {
        |x|
        @a[y] << \
        if @c.include?([x,y])
          @v += 1
          '#'.red
        elsif [[:x, x], [:y, y]].include? f
          '-'.blue
        else
          ' '
        end
      }
    }

    s = 2

    sp s+1
    @a[0].each_with_index {
      |_, i|

      sp (s-1)
      print i.to_s
    }
    puts

    sp s+1
    @a[0].each_with_index {
      |_, i|

      sp s-1
      print "─"
    }
    puts

    @a.each_with_index {
      |x, i|

      sp if i <= 9
      print "#{i}│"

      x.each {
        |z|
        y = z.to_s

        sp (y.to_i > 9 ? 2 : 1)
        print y
      }
      puts
    }
    puts

    d @v
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
