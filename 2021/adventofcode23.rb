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
  E = 99998888

  def initialize a, i
    @i = i
    i = nil

    @a = []

    @z = 0

    a .readlines
      .map {
        |o|
        l = o.chomp.split

        next if l.empty?

        s = []

        l .shift
          .split('')
          .each_with_index {
            |v, i|

            next if ['', '#', '.']. include? v

            s << v.to_sym
          }

        @a << s unless s.empty?
      }

    @a = @a.transpose

    l = (:A..:Z).to_a #.to_a.unshift('')

    @l = {}

    l.each_with_index {
      |v, i|
      @l[v] = i
    }

    @e = @l[:Z]

    f = [:Z]

    @b = dc @a

    @w = E #20193

    @i.times {
      |g|

      @a = dc @b
      @z = 0

      @f = []
      3.times {
        @f << f.dup
      }

      @f.unshift f.dup * 2
      @f << f.dup * 2

      d :s, @w

      q = 0
      while run(g) && q < 10000
        g += 1
        q += 1

        break if @z >= @w
      end

      if @z < @w
        @w = [@w, @z].min if suc g
      end

      #abort if @w < 17321
    }

    @z = @w

    fin
  end

  def run g
    s = Hash.new(0)

    unless true
      @a.each_with_index {
        |(x, y), i|

        [x, y].each {
          |z|

          s[ [whe(z), i] ] += 1
        }
      }
    end

    k = 0

    @f.each_with_index {
      |c, i|

      tar(c, i) {
        |t, r, j|

        as :a, c, i, t, r, j

        return rov i, t if fpa i, t, r, a: true
      }
    }

    @a.each_with_index {
      |c, i|

      #g += rand(10)

      (x, y) = c

      r = whe x
      r = whe x, i if g % 2 == 0

      o = eok([x,y], i)

      m = g % 5

      ( k += 1; next ) if 2 == o

      unless true
        m = \
        if i < 2
          ds :n, s[[:l, 0]], s[[:l, 1]], eok([y], 0), eok([y], 1)

          s[[:l, 0]] + s[[:l, 1]] - eok([y], 0) - eok([y], 1)

        else
          ds :n, s[[:r, 2]], s[[:r, 3]], eok([y], 2), eok([y], 3)

          s[[:r, 2]] + s[[:r, 3]] - eok([y], 2) - eok([y], 3)
        end
      end

      as :f, i, [x, y], m, o

      tar(c, i) {
        |t, r|
        return mov i, r if fpa i, t, r # && g % 6 == 0
      }

      # Guessing
      #return mov i, r if [:A, :D].include? x && g % 8 == 0

      #return mov i, r if :B == x && i == @l[:A] && g % 9 == 0

      #return mov i, r if :C == x && i == @l[:D] && g % 7 == 0

      #if :B == x && @f[1][0] == :Z && g % 5 == 0
      #  t = @l[:B]
      #  return mov i, r, i - t if fpa i, t, r
      #end

      return mov i, r, m if g % 4 == 0 #|| g % 4 == 1

      return mov i, (r == :l ? :r : :l), m if g % 4 == 2 #|| g % 4 ==
      3

 #     return mov i, r if g % 5 == 0

#      return mov i, (r == :l ? :r : :l) if g % 6 == 0

    }

    !(k == 4)
  end

  def suc g, k = 0

    @a.each_with_index {
      |c, i|

      k += 1 if 2 == eok(c, i, s: true)
    }

    @f.each_with_index {
      |(x, y), i|

      k += 1 if x == :Z && [:Z, nil].include?(y)
    }

    if DEB
      d :u, g, k, @f, @a, @w, @z, o: true if k == 9
    else
      d :u, g, k, @w, @z, o: true if k == 9
    end

    k == 9
  end

  def mov f, t, m = 0, c: 2
    return true unless @a[f]

    s = emp @a[f][0]

    if s == 1
      c += 1
    end

    t = \
    if t == :l
      w = -1
      f
    else
      w = 1
      f + w
    end

    m.times {
      return true unless @f[t] && @f[t][0] == :Z

      t += w
      c += 2
    }

    return true unless t >= 0 && f >= 0 && @f[t]
    q = emp @f[t][0]

    if q == 0
      return true unless [0, @f.size - 1].include?(t) && @f[t][1] == :Z

      as :q, [t, q], @f[t][q], @f[t][q] != :Z

      @f[t][1] = @f[t][q].dup
      @f[t][q] = :Z

      @z += ene @f[t][1]

    else
      q = 0

    end

    as :mov, f, s,  @a[f][s], @a[f][s] != :Z, \
                  @f[t][q], @f[t][q] == :Z

    @z += c * ene(@a[f][s])

    @f[t][q] = @a[f][s].dup
    @a[f][s] = :Z

    ds :m, @f[t][q], [f, s], [t, q], c, @z, @f[t][q] != :Z, \
      @f, @a

    true
  end

  def rov f, t, c: 0

    c += 2 if f <= t

    c += 2 * (f - t).abs

    s = emp @f[f][0]

    if s == 1
      c += 1
    end

    q = emp @a[t][0]

    if q == 1
      q = 0 unless @a[t][q] == :Z

    end

    #return true unless @a[t][q]

    c += 1 if q == 1

    as :rov, @f[f][s], @f[f][s] != :Z, \
                  @a[t][q], @a[t][q] == :Z

    @z += c * ene(@f[f][s])

    @a[t][q] = @f[f][s].dup
    @f[f][s] = :Z

    ds :r, @a[t][q], [f, s], [t, q], c, @z, @a[t][q] != :Z, \
      @f, @a

    true
  end

  def emp v
    v == :Z ? 1 : 0
  end

  def whe x, f = @l[:C]
    r = \
    case x
      when :A
        f >= @l[:A] ? :l : :r
      when :B
        f >= @l[:C] ? :l : :r
      when :C
        f <= @l[:C] ? :r : :l
      when :D
        f <= @l[:D] ? :r : :l
      else
        :n
    end

    r
  end

  def tar c, i
    c.each_with_index {
      |z, j|
      next if z == :Z

      t = @l[z]
      (tx, ty) = @a[t]

      if tx == :Z && [z, :Z].include?(ty)

        r = whe(z, i)

        yield t, r, j
      end

      break
    }
  end

  def fpa f, t, r, a: false

    w = 0
    w = \
    if r == :l
      t += 1 # unless a
      -1
    else
      f += 1 unless a
      1
    end

    return true if f == t

    f += w if a

    loop {
      return false unless f > 0 && f < @f.size && @f[f]

      as :fpa, [f, t, w], @f[f]

      return false unless @f[f][0] == :Z

      break if f == t

      f += w
    }

    true
  end

  def ene k
    t = @l[k]
    s = 1
    t.times { s *= 10 }
    s
  end

  def eok a, i, s: false
    a.map {
      |z|

      if s
        i == @l[z]
      else
        [i, @e].include? @l[z]
      end

    }. tally[true] || 0
  end

  def fin
    d :z, @f, @a, @z
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
