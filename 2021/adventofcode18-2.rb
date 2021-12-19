#!/usr/bin/ruby -W0

require 'colorize'
require 'ap'

alias :p :pp

class RL
  DEB = false
  #DEB = true

  # export RUBY_THREAD_VM_STACK_SIZE=15000000
  # ulimit -s 2097024

  S = 45000
  E = 9999

  def initialize a, i
    @v = []
    @i = 0

    #@t = sym(ARGF.first.chomp)
    #a.first

    a = \
    a .readlines
      .map {
        |o|
        l = eval o.chomp
      }

    @z = 0
    a.each_with_index {
      |n, i|

      a.each_with_index {
        |v, j|
        @z = [run(n, v), @z].max unless i == j
      }
    }
  end

  def run n, v
    @v = [dp(n), dp(v)]

    #d :a, @v

    @a = true
    while @a

      [false, true].each {
        |s|
        @s = s

        @a = nil
        @r = nil
        @c = nil
        rex
        break if @a

        #dss :x, @v
      }
    end

    d :v, pr(n), pr(v), pr(@v), mag(@v)

    mag @v
  end

  def pr n
    n.inspect.to_s.split(' ').join
  end

  def rex a = @v, h = 0
    return if @a && @c.nil?

    (x, y) = a
    h += 1

    #dss a, h

    if ia x
      a[0] = 0 if rex x, h

    elsif @c
      a[0] += @c
      @c = nil
      return

    elsif h <= 4
      rsp 0, a

    end

    if ia y
      @r = a if ii x
      a[1] = 0 if rex y, h

    elsif @c
      a[1] += @c
      @c = nil
      return

    end

    if ex x, y, h
      return true

    else
      rsp 1, a

    end

    @r = a if ii y

    nil
  end

  def ex x, y, h
    if !@s && ii(x) && ii(y) && h > 4 && !@a
      @a = true

      #d :ex, [x, y]

      ass @r.nil? || @r.any? { |z| ii z }

      [1, 0].any? {
        |z|
        @r[z] += x if ii @r[z]

      } if @r

      @c = y
      return true
    end
  end

  def rsp c, a
    z = a[c]

    return unless @s && !@a && ii(z)

    #ass :rsp, z

    if z > 9
      @a = true

      l = z / 2
      r = l + z % 2

      #dss :sl, [l, r]

      a[c] = [l, r]
    end
  end

  def ii a
    a.kind_of?(Integer)
  end

  def ia a
    a.kind_of?(Array)
  end


  def mag a = @v
    (x, y) = a

    l = ia(x) ? mag(x) : x

    r = ia(y) ? mag(y) : y

    #dss l, r

    3*l + 2*r
  end

  def to_s
    @z.to_s
  end








  def cw
    @w = []
    @a.size.times {
      |i|

      @w[i] ||= []

      @a[i].size.times {
        |j|

        @w[i][j] = E
      }
    }
    @w[0][0] = 0
  end

  def gn
    n = []
    e = [@a.size, @a[0].size]

    5.times {
      |x|
      5.times {
        |y|
        a = x * e[0]
        b = y * e[1]

        m = x + y

        @a.each_with_index {
          |v, z|

          z += a

          v.each_with_index {
            |t, w|

            w += b
            q = t+m

            n[z] ||= []
            n[z][w] = q % 10 + (q > 9 ? 1 : 0)
          }
        }
      }
    }
    @a = n
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

  def fl r = [], f = {}
    s = []
    r += [[-1, 0],[0, -1]]

    z = \
      Hash.new {
        |h, c|
        (x, y) = c

        s[x] ||= []

        unless s[x][y]
          s[x][y] = true
          @i += 1


          v = (f[c] ? f[c] - @a[x][y] : nil)

          unless @i > S
            r.shuffle.each {
              |(a, b)|

              a += x
              b += y

              s[a] ||= []
              next unless a >= 0 && b >= 0 && @a[a] && @a[a][b]

              z = h[[a, b]]

              if z and (v.nil? or z < v)
                v = z

              end
            }
          end

          v += @a[x][y]

          @i -= 1

          h[c] = v
        end
      }

    z[[0, 0]] = 0
    z
  end

  def pa f = [], o: false, a: @a
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

        if false
          if @c.include?([x,y])
            '#'.red
          elsif [[:x, x], [:y, y]].include? f
            '-'.blue
          else
            ' '
          end
        end

        if z == E
          sp
          ass 'bad', z, nil, x
        else
          print y
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

  def dp a
    b = []

    a.each_with_index {
      |v, k|

      b[k] = \
        if v.respond_to?(:each)
          dp v

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
end

#d dat

#  d '========================================================='
#  system 'clear'

puts
puts "\n=> " + RL.new(ARGF, ARGV.pop.to_i).to_s
