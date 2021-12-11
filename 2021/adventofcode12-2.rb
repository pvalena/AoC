#!/usr/bin/ruby

require 'colorize'
require 'ap'
alias :p :pp

DEB = false

# Data Load
dat = ARGF.readlines
  .map {
    |l|
    l .chomp
      .split(?-)
      .map { |z| z.to_sym }
  }

puts

class RL
  def t e, s, v = [], w = true
    #d 't', v, s

    v << s

    if s == e
      @r << v
      return
    end

    @j[s].each {
      |z|
      # Big cave or not visited
      c = ( b[z] or !v.include?(z) )

#      d v, z if w and !c

      if c or w
        n = c ? w : false

        t(e, z, v.dup, n)
      end
    }
  end

  def i z, x
    return if x == :start or z == :end
    @j[z] ||= []
    @j[z] << x
  end

  def b
    return @b if @b

    @b = Hash.new {
      |h, v|
      v = v.to_s
      v == v.upcase
    }
  end

  def initialize q
    @v = 0
    @a = q
    q = nil

    @j = {}

    @a.each {
      |(z, x)|

      i z, x
      i x, z

      #d 'zx', z, x, b[z], b[x]
    }

    d @j

    @r = []
    t :end, :start

    d 'r', @r

    @v = @r.size
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
