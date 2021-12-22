#!/usr/bin/ruby -W0

require 'colorize'
require 'ap'

alias :p :pp

class RL
  #DEB = false
  DEB = true

  # export RUBY_THREAD_VM_STACK_SIZE=15000000
  # ulimit -s 2097024

  S = 45000
  E = 9999

  def initialize a, i
    @i = i

    @a = 0
    @n = 0

    @s = []

    @r = []

    a .readlines
      .each {
        |o|
        l = o.chomp.split

        next if l.empty?

        #dss l[1].to_i, l[4].to_i

        @s << l[4].to_i

        @r << 0
      }

    nil while ! run

    fin
  end

  def run
    @s = \
    @s.each_with_index.map {
      |x, i|

      c = 0

      3.times {
        c += die
      }

      m = x + c
      m -= 10 while m > 10

      @r[i] += m

      dss :r, i, x, c, m, @r[i]

      return true if @r.max >= 1000

      m
    }

    nil
  end

  def die
    @n += 1
    @a += 1
    @a -= 100 if @a > 100
    @a
  end

  def fin
    @z = @r.min * @n

    dss @a, @n, @r.min, @z
  end












  def bo i, j
    r = \
      i > 0 && j > 0                \
        && i < (@s.size-1)          \
        && j < (@s[i].size-1)

    #d :b, [i, j], r
    r
  end

  def sd s = @s, n = 3
    r = \
    (s.first(n) + s.last(n)).any? {
      |x|

      (x.first(n) + x.last(n)).any? {
        |y|

        #d :y, y

        y == 1
      }
    }

    #d :s, (@s.first(2) + @s.last(2)), r
    r
  end

  def dt s = @l
    @d = []

    s.each_with_index {
      |a, i|

      s[(i+1)..].each {
        |b|

        @d << \
        (0..2).inject(0) {
          |x, k|
          x + (a[k] - b[k]).abs
        }
      }
    }

    @d
  end

  def tr s = @s, n = 80
    s.shift n
    s.pop n

    s.each{
      |l|
      l.shift n
      l.pop n
      l
    }
  end

  def br s = @s
    top = s.first(2).any? {
      |y|
      y.any? {
        |x|
        x == 1
      }
    }

    bottom = s.last(2).any? {
      |y|
      y.any? {
        |x|
        x == 1
      }
    }

    left = \
    @s.any? {
      |y|
      y.first == 1 or y[1] == 1
    }

    right = \
    @s.any? {
      |y|
      y.last == 1 or y[-2] == 1
    }

   @s.map!{
      |l|
      l = [0] + l if left
      l = l + [0] if right
      l
    }

    l = [0] * @s[0].size

    @s.unshift(l) if top
    @s << l if bottom
  end

  def sw a, f, s
    (a[f], a[s]) = [a[s], a[f]]
  end

  def to_s
    @z.to_s
  end

  def ii a
    a.kind_of?(Integer)
  end

  def ia a
    a.kind_of?(Array)
  end

  def pr n
    n.inspect.to_s.split(' ').join
  end

  def cw w = [], s = @s
    s.size.times {
      |i|

      w[i] ||= []

      @a[i].size.times {
        |j|

        w[i][j] = E
      }
    }
    w[0][0] = 0
  end

  def gn s = @s
    n = []
    r = [s.size, s[0].size]

    3.times {
      |x|

      q = x * r[0]

      3.times {
        |y|

        #y *= r[1]

        s.each_with_index {
          |v, z|

          i = q+z
          n[i] ||= []

          v.each_with_index {
            |t, w|

            n[i] << \
              if y == 1 && x == 1
                t
              else
                0
              end

          }

        }

      }

    }

    @s = n
  end

  def opt f
    n = {}
    @m = false

    @a.size.times {
      |i|

      @a[0].size.times {
        |j|

        v = f[[i,j]]
        n[[i,j]] = v

        sw v, i, j
      }
    }

    unless @m
      puts "> No change"
      exit
    end
    n
  end

  def pa a = @s, o: false
    return unless DEB or o

    s = 2

    sp s+1
    a[0].size.times {
      |i|

      sp (s-1)
      print i.to_s
    }
    puts

    sp s+1
    a[0].size.times {
      |i|

      sp s-1
      print "─"
    }
    puts

    a.each_with_index {
      |x, i|

      sp if i <= 9
      print "#{i}│"

      x.each {
        |z|
        y = z.to_s

        sp (y.to_i > 9 ? 2 : 1)

        print \
        case z
          when 1
            '#'.red

          when 0
            '.'.blue

          else
            ' '
        end
      }
      puts
    }
    puts
  end

  def hp a, b
    b.each_with_index {
      |_, k|
      a[k] += b[k]
    }

    a
  end

  def dc a
    b = []

    a.each_with_index {
      |v, k|

      b[k] = \
        if v.respond_to?(:each)
          dc v

        else
          v.dup

        end
    }

    b
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

  def d *i, o: false
    return unless DEB or o

    while i.respond_to?(:size) && i.size == 1 && i != i[0]
      i = i[0]
    end

    p i
    puts
  end

  def irb *a
    require 'irb'
    begin
      binding.irb
    rescue
    end
  end

  def dss *a
    ass *a
    d *a
  end

  def ass *a
    a.each {
      |z|
      begin
        r = \
        if a.first.is_a?(Symbol)
          a.shift
        else
          :ass
        end

        e a, l: r, x: false
        irb *a

      ensure
        abort

      end unless z
    }
  end

  def e *z, l: :'e', x: true
    unless z.nil? || z.empty?

      while z.respond_to?(:size) && z.size == 1 && z != z[0]
        z = z[0]
      end

      z.unshift l if z.respond_to? :unshift
      d *z, o: true
    end

    exit if x
  end

  def sp n = 1
    print ' ' * n
  end

  def tal s = @s
    @t = \
    s.map {
      |v|
      v.size

    }.tally

    d :t, @t, o: true
  end
end

#d dat

#  d '========================================================='
#  system 'clear'

puts
puts "\n=> " + RL.new(ARGF, ARGV.pop.to_i).to_s
