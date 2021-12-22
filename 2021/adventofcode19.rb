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
    @i = 0

    #@t = sym(ARGF.first.chomp)
    #a.first

    s = -1
    @s = []

    a .readlines
      .each {
        |o|
        l = o.chomp.split /[, \n]/

        #d :l, l

        if l[1] == 'scanner'
          #s = l[2].to_i
          s += 1

          @s[s] = [[]]
          next
        end

        next if l.empty?

        @s[s][0] << l.map { |z| z.to_i }
      }

    @l = []

    @b = dc @s #.shuffle

    #@b.size.times {
    1.times {
      |r|

      @s = dc @b
      @s.rotate!(r)

      #@s.each_with_index {
      @s[1..].each_with_index {
        |s, i|
        prm s
        #dst i
      }

#      @s.shuffle!

      d :r, r, @s.size

      break if run
    }
  end

  def sw a, f, s
    (a[f], a[s]) = [a[s], a[f]]
  end

  def prm s
    o = s[0]

    [1,-1].each {
      |x|

      [1,-1].each {
        |y|

        [1,-1].each {
          |z|

          3.times {
            |r|

            s << \
            o.map {
              |v|
              a = [ x*v[0] , y*v[1] , z*v[2] ].rotate(r)

              sw a, 1, 2 if x < 0 #&& y > 0 && z > 0
              sw a, 2, 1 if y < 0 #&& x > 0 && z > 0
              sw a, 0, 1 if z < 0 #&& y > 0 && x > 0

    #          sw a, 0, 1 if z < 0 && y < 0 && x < 0

              a
            } unless [x, y, z, r] == [1, 1, 1, 0]

          }
        }
      }
    }

    s.each {
      |z|
      z.uniq!
#      z.sort!

    } #if false

    t = s.map { |a| a[0] }.uniq

    ass :prm, t, t.size == 24, s.size == 24
  end

  def run
    @f = true
    @v = []

    while @f
      @f = false

      @s.each_with_index {
        |a, i|

        next if a.size != 1 or @v.include? i

        @v << i

        #d :i, i

        @s.each_with_index {
          |b, j|
          next if j == i || b.size == 1

          #d :j, j

          c = com a, b

          if c
            @f = true

            ass :c1, c, c.size == 1
            c = c.first

            r = c[1]
            c = c.first

            ass :c2, c, c.size == 1
            (z, c) = c.first

            sin j, r, z

            @l << z

            ass :com, @s[j].size == 1 # @s[j][0], false
          end
        }
      }

      tal
    end

    fin
  end

  def com a, b
    c = []

    a.each {
      |i|

      b.each_with_index {
        |j, k|

        r = mat i, j

        c << [r, k] if r
      }
    }

    c if c.any?
  end

  def mat a, b
    q = []

    a.each {
      |v|

      b.each {
        |w|

        f = [v[0] - w[0], v[1] - w[1], v[2] - w[2]]

        q << f

      }
    }

    unless true
      # Optimize maybe?

      c.each {
        |x|

        na = x[0][0]
        nb = x[1][0]

        sa = @s[na][r[0]]
        sb = @s[nb][r[1]]

        [1, 2].each {
          |j|
          v = sa[x[0][j]]
          w = sb[x[1][j]]

          a << v unless a.include? v
          b << w unless b.include? w

          [1, 2].each {
            |k|
            w = sb[x[1][k]]

            f = [v[0] - w[0], v[1] - w[1], v[2] - w[2]]

            q << f
          }
        }
      }

    end

    q.uniq!

    m = []

    q.each {
      |z|
      #d :q, z

      f = adc a, b, z

      m << [z, f] if f.size >= 12
    }

    m if m.any?
  end

  def sin j, r, z
    d :s, j, r, z, o: true

    v = @s[j][r]

    v.map! {
      |w|

      [w[0] + z[0], w[1] + z[1], w[2] + z[2]]
    }

    @s[j] = [v]
  end

  def adc a, b, z
    b.map {
      |v|

      c = [v[0] + z[0], v[1] + z[1], v[2] + z[2]]

      #dss :adc, c

      c if a.include? c
    } - [nil]
  end

  def dst s = @l
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

  def fin
    unless @t.keys.size == 1
      #ass :fin, @t[24] == 1

      (r, l) = mar

      d :a, r.size, l.size

      l.map! {
        |k|

        q = com [r], k

        if q
          dss :x, r, false

          sin i, r ### anyhow
          (l, r) = mar

        else
          dss :f, r.size, l, k.size, false

          puts \
          r .sort
            .map {
              |z|
              pr(z).split(/[\[\]]/)[1]
            }

          return

        end
      }
    end

    (r, l) = mar

    d :z, r.size, l.nil?, o: true

    dst
    d :d, @d.size, @d.max, o: true

    @z = @d.max
  end

  def mar a = @s
    l = []

    r = \
    a.inject([]) {
      |s, v|

      if v.size == 1
        s |= v[0]
      else
        l << v
      end

      s
    }

    [r, l]
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
# ass 'bad', z, nil, x
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
