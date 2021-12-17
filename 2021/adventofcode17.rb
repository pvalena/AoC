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
    @v = 0
    @i = 0

    #@t = sym(ARGF.first.chomp)
    #a.first

    @a = \
    a .readlines
      .map {
        |o|
        l = o.split /[=. ,\n]/

        [3,5,10,8].map {
          |x|
          l[x].to_i
        }
      }

    1.times {
      |i|
      run
    }
  end

  def run
    a = @a
    a.map! {
      |x|

      d :s, x

      @a = x
      th
    }
  end

  def th z = [@a[0], 0]
    v = []
    @p = 0

    E.times {
      ass :th, z, z.min >= 0

      #d :th, z

      v << z.dup

      @c = [0, 0]
      m = si z.dup

      @v = [m, @v].max

      if @v > @p
        @p = @v
        d :v, @v, o: true
      end

      d :th, z, @c, @v, m

      if m >= 0
        d :in
        z[1] += 1

      else
        if @c[0] > @a[1]
          z[0] -= 1 unless z[0].zero?

          if v.include? z
            z[1] -= 1 unless z[1].zero?
          end

        elsif @c[0] < @a[0]
          z[0] += 1

          if v.include? z
            z[1] -= 1 unless z[1].zero?
          end

        elsif @c[1] < @a[3]
          z[0] += 1
          z[1] += 1
          z[1] -= 1 if v.include? z

        end
      end

      break if v.include? z
    }
  end

  def si v, m = 0
    #d :si, @c, v, m

    return m if il
    return -1 if al

    hp @c, v

    v[0] += \
    if v[0] > 0
      -1
    elsif v[0] < 0
      1
    else
      0
    end
    v[1] -= 1

    si v, [m, @c[1]].max
  end

  def al
    @c[0] > @a[1] || @c[1] < @a[3]
  end

  def bl
    @c[0] < @a[0] || @c[1] > @a[2]
  end

  def il
    ! (al || bl)
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
    # WRONG:
    #n= @a.dup

    e = [@a.size, @a[0].size]

    5.times {
      |x|
      5.times {
        |y|
        a = x * e[0]
        b = y * e[1]

        m = x + y

        #d x, y, m

        @a.each_with_index {
          |v, z|

          #ass v, z
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

        #d 'opt', i, j, v, f[[i,j]]

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

          #d x,y if f[c]

          #p [x, y] if i % 10000 == 0

          #ass 'h', x, y, @a[x][y]

          #unless f.empty?
          #  e f, f[c] unless f[c].kind_of?(Integer)
          #  ass c, f[c], f[c].kind_of?(Integer)
          #end

          v = (f[c] ? f[c] - @a[x][y] : nil)

          #e 'stack' if @i > S

          unless @i > S
            r.shuffle.each {
              |(a, b)|

              a += x
              b += y

              #d 't', a,b, @a[a][b] if  [[0,0],[1, 0]].include?([a, b])

              s[a] ||= []
              next unless a >= 0 && b >= 0 && @a[a] && @a[a][b]

              z = h[[a, b]]

              if z and (v.nil? or z < v)
                #p ['z', @i, c, a, b, z, f[[a, b]]] if f[c]

                v = z
              end
            }
          end

          #ass c, v, @i
          v += @a[x][y]

          #if f[c]
          #  ass c, v, f[c], (v <= f[c])
          #end

          @i -= 1

          #sw v, x, y if DEB

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

  def ass *a
    a.each {
      |z|
      begin
        e a, l: :ass
        irb *z

      ensure
        abort

      end unless z
    }
  end

  def to_s
    @v.to_s
  end

  def e *z, l: :'e'
    unless z.nil? || z.empty?

      while z.respond_to?(:size) && z.size == 1 && z != z[0]
        z = z[0]
      end

      z.unshift l if z.respond_to? :unshift
      d *z, o: true
    end

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
puts "\n=> " + RL.new(ARGF, ARGV.pop.to_i).to_s
