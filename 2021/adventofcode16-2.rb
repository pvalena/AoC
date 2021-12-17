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
        |o|
        o.chomp!
        l = o.chomp.to_i(16).to_s(2)

#        d :p, o, l, l.size, o.size * 4, (l.size == o.size * 4)
        l.prepend '0' until l.size >= o.size * 4

        ass o, l, l.size, o.size * 4, (l.size == o.size * 4)

        [o, l
          .split('')
          .map(&:to_i) ]
      }

    1.times {
      |i|
      run
    }
  end

  def run
    #pa

    @a.map! {
      |(o, a)|

      d :s, o

      pk a, o
    }

    @v = @a.first
  end

  def pk a, o = nil
    v = bi a, 3
    t = bi a, 3

#    d :pk, v, t, a.join

    if DEB and o
      case o
        when "C200B40A82"; ass o, t, (t == 0)
        when "04005AC33890"; ass o, t, (t == 1)
        when "880086C3E88112"; ass o, t, (t == 2)
        when "CE00C43D881120"; ass o, t, (t == 3)
        when "D8005AC2A8F0"; ass o, t, (t == 6)
        when "F600BC2D8F"; ass o, t, (t == 5)
        when "9C005AC2F8F0"; ass o, t, (t == 7)
        when "9C0141080250320F1802104A08"; ass o, t == 7
      end
    end

    if t == 4
      li a
    else
      op a, t
    end
  end

  def bp a
    d a.map {
      |x|
      x.join
    }
  end

  def op z, t = 4
    ass :op, t, z.any?

    r = []

    if z.shift == 0
      l = bi z, 15

      f = z.size - l

      ass :q, f, l, l > 0, f > 0, z.size > 0

      r << pk(z) until z.size <= f

      ass r, f, l, z.size

    else
      l = bi z, 11

      ass l, z.join

      l.times {
        |i|
        #d :i, l

        r << pk(z)
      }
    end

    d :t, t, r

    case t
      when 0
        r.sum
      when 1
        r.inject(1) {
          |x, v|
          v * x
        }
      when 2
        r.min
      when 3
        r.max
      when 4
        r
      when 5
        r[0] > r[1] ? 1 : 0
      when 6
        r[0] < r[1] ? 1 : 0
      when 7
        r[0] == r[1] ? 1 : 0
      else
        e :t, t, r
    end
  end

  def li z, f = true
    ass :li, z.any?

    q = z.shift
    m = z.shift(4)

    #d :l, q, m

    m += li(z, false) if q == 1

    return bi m if f
    #(b = bi(m); d :f, b, m.join; return b) if f
    m
  end

  def bi a, n = nil
    ( n ? a.shift(n) : a )
      .join.to_i(2)
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
    b.keys.each {
      |k|
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
      begin
        $stderr.puts "Abort: #{a.inspect}\n"
        binding.irb

      ensure
        abort

      end unless z
    }
  end

  def to_s
    @v.to_s
  end

  def e *z
    unless z.nil? || z.empty?
      z.unshift :e if z.respond_to? :unshift
      d z
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
