#!/usr/bin/ruby

#require 'colorize'
#require 'ap'

#alias :p :pp

class RL
  DEB = false
  #DEB = true

  # export RUBY_THREAD_VM_STACK_SIZE=15000000
  # ulimit -s 2097024

  S = 45000
  E = 9999999

  def initialize a, i
    @v = nil
    @i = 0

    # Data load
    #@t = sym(ARGF.first.chomp)
    #a.first

    @a = \
    a .readlines
      .map {
        |l|
         l = l.chomp
          .split('')
          .map {
            |x|
            x.to_i
          }

         #w = sym(l[0])
         #v = sym(l[2])

         #ass 'w', w, @c[w].nil?

         #d w, v

      }#.sort.uniq

    gn
    cw

    1.times {
      |i|
      run
      #r = res
      #puts ">> #{i+1}: #{r}"
    }
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

  def run
    #pa

    @e = [@a.size - 1, @a[0].size - 1]
    ass @e, @a[*@e]

    f = fl
    @v = f[@e]

    r = [[1, 0],[0, 1]]

    @r = @v

    loop {
      puts ">>> " + @v.to_s

      100.times {

        n = fl(r, f)
        @v = n[@e]
        f = n
        print '.'

        unless @r == @v
          puts "\nNew: #{@v}"
          @r = @v
        end
      }
      puts

      #pa a: @w

      f = opt f
    }
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

  def sw v, i, j
    #ass 'b', i, j, v, @w[i]

    if v < @w[i][j]
      #ass 'c', i, j, @w[i][j], v
      #ass 's', v, @w[i][j], (v < @w[i][j])
      @m = true

      @w[i][j] = v

    elsif v > @w[i][j]
      puts "Big Bad: #{v} > #{@w[i][j]}"
      abort
    end
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
            @v += 1
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

puts
puts "\nResult: " + RL.new(ARGF, ARGV.pop.to_i).to_s
