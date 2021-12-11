#!/usr/bin/ruby

require 'colorize'
require 'ap'

alias :p :pp

class RL
  #DEB = false
  DEB = true

  def initialize a
    @v = 0

    @i = ARGV.pop.to_i

    # d ata Load
    @t = sym(ARGF.first.chomp)
    ARGF.first
# d @t

    @c = Hash.new

    a .readlines
      .each {
        |l|
         l = l.chomp.split

         w = sym(l[0])
         v = sym(l[2])

         ass 'w', w, @c[w].nil?

         #d w, v

         @c[w] = v
      }.sort.uniq

# d @c

# d '=============================================='

    1.times {
      |i|
      run
      r = res
      #puts ">> #{i+1}: #{r}"
    }
  end

  def run
    l = nil

    @a = Hash.new 0

    @t.each {
      |r|

      v = nil

      if l
# d 'root', l
        @a[l] += 1

        @a = hp @a, fl(l, r)
      end

      l = r.dup
    }

# d 'last', l
    @a[l] += 1
  end

  def fl l, r, n = @i
    @z ||= \
      Hash.new {
        |h, (l, r, n)|

        m = n - 1

        a = Hash.new 0

        v = @c[[l, r]]
        a[v] += 1

        unless m < 1
          a = hp a, h[[l, v, m]]
          a = hp a, h[[v, r, m]]
        end

        h[[l, r, n]] = a
      }

    @z[[l, r, n]]
  end

  def hp a, b
    b.keys.each {
      |k|
      a[k] += b[k]
    }

    a
  end

  def res
    a = @a.values
    @v = a.max - a.min

# d @a
    @v
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
    puts
  end

  def d *i
    if DEB
      while i.respond_to?(:size) && i.size == 1 && i != i[0]
        i = i[0]
      end

      p i
      puts
    end
  end

  def irb
    require 'irb'
    binding.irb
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

puts "\nResult: " + RL.new(ARGF).to_s
