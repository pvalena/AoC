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
    i = nil

    @l = [0, 0] * 3

    @s = Hash.new(0)

    @a = {}

    @z = 0

    @r = 0

    a .readlines
      .map {
        |o|
        l = o.chomp.split

        next if l.empty?

        s = []

        v = (l.shift == 'on')

        l .shift
          .split(/[,.=\n]/)
          .each_with_index {
            |v, i|
            s << v.to_i if i % 2 == 1
          }

        @r += 1

        @a[[ [s[0],s[1]], [s[2],s[3]], [s[4],s[5]] ]] = [v, @r]
      }

    run

    fin
  end

  def run
    @a.each {
      |(x, y, z), (v, r)|

      #d :r, (v ? 1 : 0), r, x, y, z, o: true

      # We need all
      #next unless v

      @l = [
          [ [@l[0][0], x[0]].min, [@l[0][1], x[1]].max ],
          [ [@l[1][0], y[0]].min, [@l[1][1], y[1]].max ],
          [ [@l[2][0], z[0]].min, [@l[2][1], z[1]].max ],
        ]

    }

    x = @l[0]

    @v = [[]] * 3
    @x = []

    i = nep r: true #, x[0]

    e i

    r = tun(0, i, x[0], x[1])

    dss :q, x[1], r, r <= x[1]
  end

  def tun j, i, w, b, u: false
    return w unless i

    x = i[j]
    r = @a[i]

    return w unless w <= b && x[0] <= b

    if x[1] < w
      ni = nex j, w

      return tun j, ni, w, b
    end

    d :i, j, w, b, i

    ni = nil
    s = nil

    loop {
      return w unless w <= x[1]

      ni = nex j, w

      s = :e
      break unless ni

      nx = ni[j]
      nr = @a[ni]

      dss :t, j, [x, r], [nx, nr]

      # Non-overlap
      s = :n
      break unless nx[0] <= x[1]

      # Embedded, LP
      if nx[1] <= x[1] && nr[1] < r[1]

        dss :m, j, w, b
        next
      end

      # Same start
      if nx[0] == x[0]

        # Let's hope there's only one conflicting
        if r[1] < nr[1]
          dss :s, j, w, b

          @v[j] -= [i]
          return tun j, ni, w, b
        end

        # let's go with HP
        #e :hups
      end

      # Overlapping, HP
      if r[1] > nr[1]

        dss :h, j, w, b

        t = @v[j]

        w = tun j, i, w, b, u: true

        @v[j] = t

        dss :l, j, w, b

        return w if u
        return tun j, ni, w, b
      end

      # LP
      w = wrt j, i, ni, b, w, nx[0] - 1, r, s: :o

      t = @v[j]

      w = tun j, ni, w, b, u: true

      @v[j] = t
    }

    dss s, j, w, b

    wrt j, i, ni, b, w, x[1], r, s: s
  end

  def wrt j, pi, i, b, w, t, r, s: :w
    return w unless w <= t

    if r[0]
      t = b if t > b

      nj = j + 1

      if nj < 3
        dss :w, s, j, w, t, pi

        @v[nj] = []

        nw = pi[nj][0]
        nb = pi[nj][1]

        if @x[nj]
          nw = [@x[nj][0], nw].max
          nb = [@x[nj][1], nb].min

          #ass :x, nw, nb, nw < nb
        end

        d :z, j, nj, nw, nb, pi, @x[nj]

        if nw <= nb
          ni = nex nj

          l = \
          if ni
            :p

          else
            :n

            ni = nex nj, nw

            e :ni unless ni
          end

          ass :u, j, l, pi

          @x[j] = [w, t]
          @x[nj+1] = pi[nj+1] if j == 0

          tun(nj, ni, nw, nb)

          @x[nj+1] = nil if j == 0
          @x[j] = nil

        end

      else
        x = @x[j]
        dss :x, x, [w, t], @z

        @x[j] = [[w, x[0]].max, [t, x[1]].min]

        s = \
        @x.inject(1) {
          |t, (a, b)|
          #dss :m, t, a, b, (a-b).abs
          t * ((a - b).abs + 1)
        }

        @z += s

        dss :d, @x, s, @z
      end
    end

    t + 1
  end

  def prv i, w, k = nil, a = @a
    a.each_with_index {
      |(s, v)|

      #e :nex, s[i][0], v, k, a[k] if k

      if s[i][0] < w \
        && !@v[i].include?(s) \
        && (k.nil? || s[i][0] > k[i][0])

        k = s
      end
    }

    if k
      @v[i] << k
      @v[i].uniq!
      k
    end
  end

  def nex i, w = nil, k = nil, a = @a, r: nil

    w ||= @l[i][0]

    a.each_with_index {
      |(s, v)|

      #e :nex, s[i][0], v, k, a[k] if k

      if s[i][0] >= w \
        && !@v[i].include?(s) \
        && (k.nil? || s[i][0] < k[i][0]) \
        && (r.nil? || v[0] == r)

        k = s
      end
    }

    if k
      @v[i] << k
      @v[i].uniq!
      k
    end
  end

  def nep i = nil, z = @r, k: nil, a: @a, r: nil

    z = @a[i][1] - 1 if i

    d :nep, z, i, k, r

    a.each_with_index {
      |(s, v)|

      #e :nex, s[i][0], v, k, a[k] if k

      if v[1] <= z \
        && (k.nil? || v[1] > @a[k][1]) \
        && (r.nil? || @a[s][0] == r)

        k = s
      end
    }

    k
  end

  def bor a, b
    a = @l[0] if a < @l[0]
    b = @l[1] if b > @l[1]
    [a, b]
  end

  def fin
    d :f, @z
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

  def ad v, xa, sa
    va = v + xa
    va -= 10 while va > 10
    [va, sa + va]
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
