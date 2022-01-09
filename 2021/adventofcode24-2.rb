#!/usr/bin/ruby -W0

require 'colorize'
require 'ap'

alias :p :pp

class RL
  D = false

  # export RUBY_THREAD_VM_STACK_SIZE=15000000
  # ulimit -s 2097024

  S = 45000
  E = 99998888

  def initialize a, i
    @i = i
    i = nil

    @m = Hash.new() {
      |h, v|
      #d :h, h, v
      #h[v] = v #.to_i
      v
    }
    @m[:w] = 0
    @m[:x] = 0
    @m[:y] = 0
    @m[:z] = 0

    @z = 0

    @a = \
    a .readlines
      .map {
        |o|
        l = o.chomp.split

        next if l.empty?

        l .each_with_index.map {
            |v, i|

            #next if ['', '#', '.']. include? v

            s = v.to_sym
            v = v.to_i

            if i <= 0 || @m.keys.include?(s)
              s

            else
              v

            end
          }

      } - [nil]

    @b = dc @a
    @q = E

#        *#######
#        01234567890123
#        19911695311364
    @r = 19911675311164

    s = @r.to_s
          .split('')
          .map(&:to_i)

    as :s, s.size, s.size == 14

    @q = @i # unless D
    @i = D ? 1 : 9**2

    @f = true
    @f = false


    @l = 1

    @w = [8, 26, 44, 80, 116, 134, 152]

    @q = 224
    @p = 242

    a = [4, 5, 11, 12]

    @i = 1 if @l > 0

    lop a, s

    fin
  end

#  D = true

  def rnn g, i, j, k, l, m, n, w, x, y, z

#    d :rnn, g, i

    run {
      |o|

      # 16, 27, 38, 49
      o[4]  = y
      o[5]  = z

      # 9, 8, 7
      o[6]  = x

      # 9, 8, 7, 6, 5
      o[7]  = w

      # 9 .. 3
      o[8]  = n

      # 7 .. 1
      o[9]  = m

      # 5 .. 1
      o[10] = l

      # 3
      #o[11] =

      # 6
      #o[12] =

      # 9 .. 4
      o[13] = j

      # Random
      o[g]  = i unless i == 0
    }
  end

  def lop a, s
    k = 3

    0.upto(13) do
      |g|
      next unless a.include? g

      0.upto(9) do |i|

        d :g, [g, i], @z, o: true

          1.upto(4) { |y|
          1.upto(6) { |z|

          1.upto(9) { |x|
          1.upto(9) { |w|
          1.upto(9) { |n|

          1.upto(9) { |m|
          1.upto(9) { |l|
          1.upto(9) { |j|

            @g = dc s

            r = \
            rnn g, i, j, k, l, m, n, w, x, y, z

            break unless r

          }
          }
          }

          }
          }
          }

          }
          }

      end
    end
  end

  def run
    # Next
    yield @g
    @z = @g.join.to_i

    # Reset
    @a = dc @b

    @m[:w] = 0
    @m[:x] = 0
    @m[:y] = 0
    @m[:z] = 0

    return unless @z < @r

    #q = 0
    #s = 0
    while @a.any? # && q < @q
      #q += 1

      c = alu @a.shift

#        d :c, q, c, @m, @z if @m[:z] <= 0 && q >= @p
#        if c == [:eql, :x, 0] && !@w.include?(q)
#          break if @m[:x] != 0
#          s = q
#        end
    end

    if @m[:z] == 0 && @a.empty? # s > @q #&& q == @q

      if @z < @r
        @r = @z
        d :f, @r, o: true

      end

#      elsif s > @q #|| (D && s >= @q)
#        d :q, s, q, @z, o: true

#      elsif s < @q # && !D
#        e :n, s, q, @z #, o: true

    end

    true
  end

  def alu i
    (c, a, b) = i

    # d :r, c, a, b, @m

    case c
#     inp a - Read an input value and write it to variable a.
      when :inp
        @m[a] = @g.shift

#     add a b - Add the value of a to the value of b, then store the result in variable a.
      when :add
        @m[a] += @m[b]

#     mul a b - Multiply the value of a by the value of b, then store the result in variable a.
      when :mul
        @m[a] *= @m[b]

#     div a b - Divide the value of a by the value of b, truncate the result to an integer, then store the result in variable a. (Here, "truncate" means to round the value toward zero.)
      when :div
        @m[a] /= @m[b]

#     mod a b - Divide the value of a by the value of b, then store the remainder in variable a. (This is also called the modulo operation.)
      when :mod
        @m[a] %= @m[b]

#     eql a b - If the value of a and b are equal, then store the value 1 in variable a. Otherwise, store the value 0 in variable a.
      when :eql
        @m[a] = @m[a] == @m[b] ? 1 : 0

      else
        e :fail

    end

    [c, a, b]
  end

  def fin b = nil, a = @m
    d :z, @r, o: true

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

  def sw a, f, s
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

  def pa a = @s, o: false
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
