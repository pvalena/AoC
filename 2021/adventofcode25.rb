#!/usr/bin/ruby -W0

require 'colorize'
require 'ap'

alias :p :pp

class RL
  D = false

  # export RUBY_THREAD_VM_STACK_SIZE=15000000
  # ulimit -s 2097024

  S = 45000
  E = 99999999

  def initialize a, i
    @i = i
    i = nil

    @m = Hash.new() {
      |h, v|
      #d :h, h, v
      #h[v] = v #.to_i
      v
    }

    @z = 0

    @a = \
    a .readlines
      .map {
        |o|
        l = o.chomp.split('')

        next if l.empty?

        l .each_with_index.map {
            |v, i|

            v.to_sym unless v == '.'
          }

      } - [nil]

    @b = dc @a

    @q = E
    @r = 0

    @r = run

    fin
  end

  #D = true

  def run s = @a
    q = 0

    @i.times {
      |g|
      g += 1
      @u = false

      lop {
        |x, y|

        rig x, y
      }

      lop {
        |x, y|

        dow x, y
      }

      if g % 10 == 0
        d :s, g
        pa
      end

      return g unless @u
    }
  end

  def rig x, y, s = @a, b = @b
    l = s[x]

    return unless l[y] == :>

    t = y + 1
    t = 0 if t >= l.size

    return if l[t]

    l = b[x]

    l[y] = nil
    l[t] = :>

    @u = true

    #d :rig, x, y, t
  end

  def dow x, y, s = @a, b = @b
    l = s[x]

    return unless l[y] == :v

    t = x + 1
    t = 0 unless s[t]

    return if s[t][y]

    b[x][y] = nil
    b[t][y] = :v

    @u = true

    #d :dow, x, y
  end

  def lop s = @a
    @b = dc @a

    s.each_with_index do
      |m, x|

      m.size.times do
        |y|

        #d :yield, x, y
        yield x, y

      end
    end

    @a = @b
  end

  def fin b = nil, a = @m
    d :z, @r, o: true
    pa

  end









  def sb b = @s
    c = true

    b.size.times {
      |j|

      if c
        b[j] -= 1
        c = false

      end

      break if b[j] > 0

      c = true
      b[j] = 9

    }
  end

  def bm b = @s, c = 0
    #c = true

    b[c] += 1

    c = nil

    b.each_with_index {
      |_, j|

      if c
        b[j] += 1
        c = false

      end

      return if b[j] <= 9

      c = true
      b[j] = 1
    }
  end

  def sm s = @s
    s.map {
      |a|
      a.values.reduce(:+)
    }
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

  def sw f, s, a = @a
    (a[f], a[s]) = [a[s], a[f]]

  end

  def to_s
    @r.to_s
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

  def pa a = @a, o: false
    return unless D or o

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
          when :>
            '>'.red

          when :v
            'v'.blue

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
    return unless D or o

    while i.respond_to?(:size) && i.size == 1 && i != i[0]
      i = i[0]
    end

    p i
    #puts unless o
  end

  def irb *a
    require 'irb'
    begin
      binding.irb
    rescue
    end
  end

  def ds *a
    as *a
    d *a
  end

  def as *a
    a.each {
      |z|
      begin
        r = \
        if a.first.is_a?(Symbol)
          a.shift
        else
          :as
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

  def tl s = @s
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
