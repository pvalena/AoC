#!/usr/bin/ruby -W0

# export RUBY_THREAD_VM_STACK_SIZE=15000000
# ulimit -s 2097024

## Init

def safe_req z
  begin
    require(z)
  rescue LoadError
  end
end

safe_req 'colorize'
safe_req 'ap'
safe_req 'benchmark'
safe_req 'stringio'
safe_req 'parallel'
safe_req 'irb'

if defined?(ap)
  alias :pp :ap
end

## Constants

# Debug mode! On by default
# used for deb() calls
DEB = true.freeze unless defined?(DEB)

# Max stack depth
M = 45000.freeze

# Empty? Absurdly big?
E = 999_999_999_999.freeze

# Number to divide by for sampling
V = 100_000_000.freeze

# For timestamps
T = [Time.now]

B = [
  :zero,
  :one,
  :two,
  :three,
  :four,
  :five,
  :six,
  :seven,
  :eight,
  :nine,
  :ten,
#  :teen,
].freeze

## Helper
# Deep freeze $1
# Goind down on elemnts which understand :each
#
# Note: Defined early for freezing complex consts
def dfr a
  a.each_with_index {
    |v, k|

    if v.respond_to?(:each)
      dfr v

    else
      v.freeze

    end

  }.freeze
end

# Chars 0 to 9
N = dfr ('0'..'9').to_a

# :a to :z symbols in an array
S = dfr (:a..:z).to_a

# Directions in 2d array as 2d coords
# - left, right, up, down
D = dfr \
  [0, -1, 1].inject([]) {
    |k, i|

    if i == 0
      [-1, 1].each {
        |j|
        k << [0, j]
      }
    else
      k << [i, 0]
    end

    k
  }

# Area of 2d coords
A = dfr \
  (-1..1).inject([]) {
    |c, x|

    (-1..1).each {
      |y|

      c << [x, y] unless x == 0 && 0 == y

    }

    c
  }

# Directions in 3d array as 3d coords
# - left, right, up, down, towards, backwards
D3 = dfr \
  [0, -1, 1].inject([]) {
    |k, i|

    if i == 0
      [0, -1, 1].each {
        |j|

        if j == 0

          [-1, 1].each {
            |h|
            k << [0, 0, h]
          }

        else
          k << [0, j, 0]
        end

      }
    else
      k << [i, 0, 0]
    end

    k
  }

# Symbols for 2d directions as above
#  - Left, Right, Up, Down
C = dfr [:L, :R, :U, :D]

# Input ARGF(or f:)
#
# loop - process block (or per element) in a line
#
# $1: Skip empty lines? (or n:)
# $2: Split lines? (or s:) - iterate per element rather than per line
# $4: Gsub values? (or g:) - replaces stuff like .,:;
# $4: Trim whitespace?  (or t:) - splits on any whitespace
#
def inp(nn = nil, ss = nil, gg = nil, tt = nil,
         n: true,  s: true,  g: true,  t: true,
         f: ARGF, &b)

  n = nn unless nn.nil?
  s = ss unless ss.nil?
  g = gg unless gg.nil?
  t = tt unless tt.nil?

  #err :inp, n, s, g, t, f.inspect

  puts if DEB

  f = File.open(f) if f.kind_of?(String)

  f .readlines
    .each_with_index
    .map {
      |o, j|

      l = o.chomp

      l.gsub!(/[()=,.:;]/,' ') if g

      #l = s ? l.split : [l]

      l = l.split if t

      next if n && l.empty?

      if b
        l = \
        if s
          l.each_with_index.map {
            |v, i|

            yield v, i
          }
        else
          yield l, j
        end
      end

      l = l[0] if l.size == 1
      l

    } - [nil]
end

# Tally array, per elements size; or block
def tal s, &b
  s.map {
    |v|
    if b
      yield v

    else
      v.size

    end

  }.tally
end

# Yield nearby fields in 3d array
def near3 w
  a, b, c = w

  D3.any? {
    |(x, y, z)|

    t = [ a+x, b+y, c+z ]

    f.include?( t )
  }
end

# Is integer
def isi? *a
  isw? Integer, *a
end

# Is integer
def ish? *a
  isw? Hash, *a
end

# Is array
def isa? *a
  isw? Array, *a
end

# Is range
def isr? *a
  isw? Range, *a
end

# Is Symbol
def iss? *a
  isw? Symbol, *a
end

# Is Text
def ist? *a
  isw? String, *a
end

# Is WHAT?
def isw? s, *a
  a.all? {
    |b|
    b.kind_of?(s)
  }
end

# inspect, to string, no spaces
def pri n
  n.inspect.to_s.split(' ').join
end

# Create-copy empty array {a}
def cre a
  w = []
  a.size.times {
    |i|

    w[i] ||= []

    a[i].size.times {
      |j|

      w[i][j] = E
    }
  }
  w[0][0] = 0
end

# Generate larger array based on $1; size $2 times
def gen s, t, &b
  n = []
  e = [a.size, a[0].size]

  t.times {
    |x|

    q = x * r[0]

    t.times {
      |y|

      s.each_with_index {
        |v, z|

        i = q + z
        n[i] ||= []

        v.each_with_index {
          |t, w|

          n[i] << \
            if b
              yield t, x, y

            else
              t

            end

        }

      }

    }

  }

  n
end

# Optimize hash $1; use 2d array keys $2 as indexes
def opt f, a
  n = {}
  m = false

  a.size.times {
    |i|

    a[0].size.times {
      |j|

      v = f[[i,j]]
      n[[i,j]] = v
    }
  }

  n
end

# Print 2d-array $1 nicely
# o: override DEB output
# block to modify printed value
# or compare to E => spc
# h: show header?
def pra a, d = 2, o: false, h: true, &b

  return unless DEB or o

  z = \
  a.detect {
    |x|
    x.respond_to? :size

  }.size

  s = 2

  if h
    spc s+1
    z.times {
      |i|

      i = i.to_s
      spc(d - i.size + 1)
      print i
    }
    puts

    spc s+1
    z.times {
      |i|

      i = i.to_s
      spc(d - i.size + 1)
      print "─"
    }
    puts
  end

  a.each_with_index {
    |x, i|
    (i, x) = x if a.kind_of? Hash

    if h
      spc if i.to_s.size < 2
      print "#{i}│"
    end

    x.each_with_index {
      |z, j|
      (j, z) = z if x.kind_of? Hash

      y = z.to_s

      z, y = \
        if b
          yield(z, y)

        elsif z == E
          [' '] * 2

        end

      y = z if y.nil?

      spc(d - z.to_s.size + 1)
      print y

    } if x.respond_to? :each_with_index
    puts

  } if a.respond_to? :each_with_index
  puts
end

def pr3 a, l = :i, &b
  return unless DEB

  k = \
    if a.respond_to? :keys
      a.keys.sort

    else
      (0...a.size)

    end

  k.each {
    |i|
    x = a[i]

    if x
      deb l, i
      pra x, &b
    end
  }
end

def pr4 a, l = :j, &b
  return unless DEB

  k = \
    if a.respond_to? :keys
      a.keys.sort

    else
      (0...a.size)

    end

  k.each {
    |i|
    x = a[i]

    deb l, i
    pr3 x, &b if x
  }
end

# add enumerables $2 into $1
def add a, b
  b.each_with_index {
    |_, k|
    a[k] += b[k]
  }

  a
end

# remove enumerables $2 into $1
def del a, b
  b.each_with_index {
    |_, k|
    a[k] -= b[k]
  }

  a
end

# return a value in range
# $1: value
# $2: from
# $3: to
def lim v, f, t
  if v < f
    f
  elsif v > t
    t
  else
    v
  end
end

# Deep clone a
def dcl a
  b = []

  a.each_with_index {
    |v, k|

    b[k] = \
      if v.respond_to?(:each)
        dcl v

      else
        v.dup

      end
  }

  b
end

# Convert values in nested arrays $1 `.to_i`
def to_i a
  a.map {
    |v|

    if v.respond_to?(:map)
      to_i v

    else
      v.to_i

    end
  }
end

# Convert values in nested arrays $1 `.to_s`
# Optionally handle by block
def tos a, &b
  a.map {
    |v|

    if v.respond_to?(:map)
      to_s v

    else
      r = yield v if b

      r ? r : v.to_s
    end
  }
end
def to_s *a, &b
  tos *a, &b
end

# Length-1 symbols from a string
# Optionally override processing via block
def sym x, &b
  x = \
  x.split('')
   .map! {
    |z|
    r = yield z if b

    r ? r : z.to_sym
  }

  if x.size == 1
    x[0]
  else
    x
  end
end
alias :to_sym :'sym'

# Nicely print long array $1, with $2 elements per line
def dar z, n = 5
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

# Compute manhattan distance
# $1: [a,b]
# $2: [x,y]
def man x, y
  y.each_with_index.inject(0) {
    |k, (g, i)|

    k + (x[i] - g).abs
  }
end

# Debug output $*
# o: override DEB output
def deb *i, o: false, l: nil
  return unless DEB or o

  a = i.shift if i.first.kind_of?(Symbol)

  while i.respond_to?(:size) && i.size == 1 && i != i[0]
    i = i[0]
  end

  if l.nil?
    l = !( (i.respond_to?(:each) && i.flatten.size >= 5) || i.kind_of?(Hash) )
  end

  unless l
    pp a
    pp i

    #i.each {
    #  |j|
    #  pp j
    #}
  else
    p [a, i]
  end

  puts if DEB
end

# Run irb with context $*
def irb *a #= nil
  require 'irb'
  binding.irb
end

# Ass + deb $*
def dss *a, **k
  ass *a if DEB || k[:o]
  deb *a, **k
end

# Assert $* per argument
# first symbol replaces default identifier :ass
# Start irb on error
def ass *a
  a.each {
    |z|
    begin

      err(*a, x: false, o: true)
      #irb *a

    ensure
      abort

    end unless z
  }
end

# Error exit $*
# l: error identifier
# x: exit?
def err *z, l: :'e', x: true, **k
  unless z.nil? || z.empty?

    if l === true || l === false
      k[:l] = l

      l = :e
    end

    while z.respond_to?(:size) && z.size == 1 && z != z[0]
      z = z[0]
    end

    z.unshift l if z.respond_to?(:unshift) && !iss?(z.first)
    deb *z, o: true, **k
  end

  exit if x
end

# Print $1 spaces; or $2
def spc n = 1, s = ' '
  print s * n if n > 0
end

# Substract first element in array $1
# If element is $2, substract next one etc.
#               $2 -> $3
# IOW align for Min $2; Max $3
def sub b, a = 1, m = 9
  c = true

  b.size.times {
    |j|

    if c
      b[j] -= 1
      c = false

    end

    break if b[j] >= a

    c = true
    b[j] = m

  }
end

# Bumb nth $2 entry in array $1 by 1
# If the element reaches $3, go for next one etc.,
# and set it to $2.
#
# IOW Align to min $2, max $3
def bum b, n = 0, a = 1, m = 9
  b[n] += 1

  c = false

  b.each_with_index {
    |_, j|

    if c
      b[j] += 1
      c = false

    end

    return if b[j] <= m && j >= n

    c = true
    b[j] = a
  }
end

# 2d area lookup in Hash table using keys as coords
# $1 = Hash table
# $2 = Key
# $3 = Offsets array
# $4 = Clone Hash for every run
#
# Return array with entries which block returned.
# nil = ignore
def are a, k, c = A, n: false, &b

  a = cop a if n

  z = []

  c.each {
    |o|

    x = nex k, o

    v = a[x]

    next unless v

    w = yield x, v

    z << w if w
  }

  z
end

# Sum all entries in array
def sum s
  s.map {
    |a|
    a.values.sum
  }
end

# Are indexes $2,$3 inside array $1
def bor s, i, j
  i >= 0 && j >= 0           \
    && i < s.size            \
    && j < s[i].size
end

# Lookup around 2D array $1, check block
# coordinates $2, $3
def rou z, i, j, &b
  c = 0

  -1.upto(1).each {
    |a|
    x = i + a

    -1.upto(1).each {
      |b|
      y = j + b

      next unless [a, b] != [0, 0] \
          && bor(z, x, y)

      c += 1 if yield z[x][y], a, b

    } if z[x]

  }

  c
end

# Lookup around 3D array
# & check (+1 on success) via block
# $1: array
# $2, $3, $4: coordinates
def rou3 z, i, j, &b
  c = 0

  err :NYI, 'rou3'

  -1.upto(1).each {
    |a|
    x = i + a

    -1.upto(1).each {
      |b|
      y = j + b

      next unless [a, b] != [0, 0] \
          && bor(z, x, y)

      c += 1 if yield z[x][y], a, b

    } if z[x]

  }

  c
end

# Runs `any?` on array $1,
# checking only n $2 starting and ending elements.
# block; or compare element to $3
def sen s, n = 3, v = 1, &b
  (s.first(n) + s.last(n)).any? {
    |x|

    (x.first(n) + x.last(n)).any? {
      |y|

      if b
        yield y

      else
        y == v

      end
    }
  }
end

# Compute all 2d deltas (or block) for indexes in array $1
# $1 = [[a,b],[c,d]]
def dlt s, &l
  d = []

  s.each_with_index {
    |a, i|

    s[(i+1)..].each {
      |b|

      d << \
        if l
          yield a, b

        else
          (0..2).inject(0) {
            |x, k|
            x + (a[k] - b[k]).abs
          }

        end
    }
  }

  d
end

# Same as dlt, but use 3 for block
def dlt3 s, &l
  d = []

  s.each_with_index {
    |a, i|

    s[(i+1)..].each {
      |b|

      s[(i+2)..].each {
        |c|

        d << \
          yield(a, b, c)

      }
    }
  }

  d
end

# In array $1, swap entries $2 and $3
def swp a, f, s
  (a[f], a[s]) = [a[s], a[f]]
end

# Print result $1
def res r = R.new
  puts "=> #{r}"
end

# Get commandline arg
#
# $1: what to call on arg 
#   :to_i by default - but feel free to redefine to anything
def arg(i = :to_i, **k)
  return unless ARGV.size > 1

  v = ARGV.pop
  if i && v
    v = v.split(?,).map{ |x| x.send(i, **k) }
    v = v.first if v.one?
  end

  v
end

# Create hash-based cache via block
def hsh
  Hash.new {
    |h, i|

    h[i] = yield h, i
  }
end

# Multiplicate all elements of array
def mul a
  a.inject(1) {
    |x, k|
    x * k
  }
end

# out() and err()
# All args
# $1: passed only to out
# $2: passed to both out and err
def eut a, x = {}, l = :eut
  out a, **x
  err l, **x
end

# Range $1 to $2 or $2 to $1
# whatever makes sense :)
# & each_with_index if block
def ran b, e, &l

  b, e = e, b if b > e 

  r = (b..e)

  r.each_with_index {
    |x, i|
    yield x, i

  } if block_given?

  r
end

def out(w, s = [], t = [],
  wc: nil,
  fc: '#'.colorize(:cyan),
  sc: '.'.colorize(:green),
  tc: '@'.colorize(:red),
  o: false, f: false, d: 2,
  b: false, h: false, &block)

  return unless DEB || o

  wc = fc unless wc

  a = nil

  unless @outc
    w = dcl w
    s = dcl s

    # flip
    if f
      w.map! {
        |(x, y)|

        [-x, y]
      }

      s.map! {
        |(x, y)|

        [-x, y]
      }
    end

    m = [0, 0]
    n = [E, E]

    #deb :w, w

    # store
    w += s
    w += t

    w.each {
      |l|

      [0, 1].each {
        |i|
        m[i] = l[i] if l[i] > m[i]
        n[i] = l[i] if l[i] < n[i]
      }
    }

    r, c = n
    r -= d
    c -= d
    
    w.map! {
      |l|

      [ l[0] - r, l[1] - c ]
    }

    # load
    s = w.last(s.size + t.size)
    t = s.pop(t.size)

    x, y = m[0] - r + d, m[1] - c + d

    a = [ [ wc ] * y ] * x
    a = dcl a

    #err :w, w.size, s.size

    s.each {
      |g|
      set(a, g, sc)
    }

    w -= t

    @outc = dcl [a, w, r, c]

  else
    a, w, r, c = dcl @outc

    t = dcl t

    # flip
    if f
      t.map! {
        |(x, y)|

        [-x, y]
      }
    end
    
    t.map! {
      |l|

      [ l[0] - r, l[1] - c ]
    }
  end

  w += t

  t.each {
    |g|

    l = \
    if block_given?

      yield [g[0] + r, g[1] + c]

    else

      tc

    end

    set(a, g, l)
  }

  bout(a, w, b: b, h: h, o: true)
end

# Print selected output using pra
# $1: Array to print
# $2: Array with indexes to select
# $3: spacing
# h: headers
# b: blank screen before
def bout a, v, s = 0, h: true, b: false, o: false
  a = \
  a.each_with_index.map {
    |r, i|

    r.each_with_index.map {
      |g, j|

      g if v.include? [i, j]
    }
  }

  if b
    f = StringIO.new
    $stdout = f
  end

  pra(a, s, h: h, o: o) {
    |x|
    x ? x : ' '
  }

  if b
    $stdout = STDOUT
    f = f.string.lines.map { |z| z.rstrip }.join("\n")
    system('clear')
    print f
    STDOUT.flush
  end
end

# Set value in 2d array
# $1: Array
# $2: [x, y]
# $3: value
def set a, l, z
  i, j = l

  a[i][j] = z
end

# Get value from 2d array
# $1: Array
# $2: [x, y]
# $3: optional block for post-processing
def get a, l, &b
  i, j = l

  r = a[i][j]

  r = yield(r, i, j) if b

  r
end

# Helper
def to_s
  @run.to_s
end   

# Benchmark
def ben &b
  b = \
  Benchmark.measure {
    yield
  }

  deb :b, b.real, o: true
end

# Copy hash; dup keys and values
def cop h
  h = h.dup

  h.keys.each {
    |k|

    h[k.dup] = h[k].dup
  }

  h
end

# Draw a set of lines!
# see lin(), return coordinates
# $1: [A,B,C]  # Draws A -> B -> C
# Where A.. are 2d coordinates
def dra a
  w = []

  a.each {
    |l|

    l -= [nil]

    f = l.shift

    l.each {
      |t|

      z = lin(f, t)

      w += z
      f = t
    }
  }

  w.uniq
end

# 2d line, from $1 to $2
# Returns discrete coordinates
def lin f, t
  z = []

  ran(f[0], t[0]) {
    |x|

    ran(f[1], t[1]) {
      |y|

      z << [x, y]

    }
  }

  z
end

# Coords based recursive search
# $1 = Hash
# $2 = coords
# $3 = result
# $4 = directions
# &b
def rcs a, k, s = [], c = A, r = [], &b

  v = a[k]

  return s unless v

#  deb :rcs, k, v, s, r, l: true

  v = yield k, v, s

  return s unless v

  a.delete(k)

  c.each {
    |o|

    x = nex k, o

    rcs a, x, s, c, [k] + r, &b
  }

  s
end

# Return maximum from
# values in the second column of 2d array
# $1: array
def max3 a
  a.map { |(_, _, x)| x }.max
end

# Return maximum from
# values in the second column of 2d array
# $1: array
def max2 a
  a.map { |(_, x)| x }.max
end

# Return maximum from
# values in the first column of 2d array
# $1: array
def max a
  a.map { |(x, _)| x }.max
end

# Return minimum from
# values in the second column of 2d array
# $1: array
def min3 a
  a.map { |(_, _, x)| x }.min
end

# Return minimum from
# values in the second column of 2d array
# $1: array
def min2 a
  a.map { |(_, x)| x }.min
end

# Return minimum from
# values in the first column of 2d array
# $1: array
def min a
  a.map { |(x, _)| x }.min
end

# Rotate a direction Left or Right or U-turn
# $1: direction to rotate
# $2: L / R / U
def rot z, r

  q = [:L, :U, :R, :D]
  i = q.find_index z

  n = \
  if r == :U
    r = :R
    2
  else
    1
  end

  n.times {
    i += r == :L ? -1 : 1

    i = q.size - 1 if i < 0

    i %= q.size
  }

  q[i]
end

# Rotate direction coords
#
# $1: direction
# $2: rotation
def rtt d, r
  @rtt ||= \
    hsh {
      |_, (d, r)|

      z = rrt d
      z = rot z, r
      dir z
    }

  @rtt[ [d, r] ]
end

def flip l, i, w = W - 1
  l[i] = w - l[i]
end

def nex x, y
  [ x[0] + y[0], x[1] + y[1] ]
end

def nex3 x, y
  [ x[0] + y[0], x[1] + y[1], x[2] + y[2] ]
end

def dir x
  x = x.to_sym unless iss? x
  i = C.find_index x

  D[i]
end

# Reverse rotation to direction symbol
#
# $1: direction coords
def rrt t
  C.detect {
    |q|

    dir(q) == t
  }
end

def inloop a, i = 0

  loop {
    i = play(a, i)

    break unless i
  }

  @o
end

def inparallel a, o: false, **k
  unless o
    t = 4 unless Process.respond_to?(:fork)

    return \
    Parallel.map(a, in_threads: t, **k) {
      |b|

      r = \
      if block_given?

        yield b

      else

        play b

      end

      [r, b]
    }
  end

  h = [true] * 8
  m = Mutex.new
  s = []

  while h.any?

    w = true

    h.map! {
      |t|

      if t === true

        w = false

        next unless a.any?

        Thread.new {

          b = \
          m.synchronize {
            a.shift
          }

          r = \
          if block_given?

            yield b

          else

            play b

          end

          Thread.current[:r] = [r, b]
        }

      elsif t.alive?
        t

      else
        w = false

        t.join

        s << t[:r]

        true
      end
    }

    if w
      sleep 1

    else
      h.delete(nil) unless a.any?

    end
 end

  s
end

def sam i, *z, q: V, r: 0, l: :sam
  if i % q == r

    z.unshift l unless iss?(z.first)

    T << Time.now

    d = T.last(2).reduce(:'-').abs

    if block_given?

      z = yield(d, *z)

    end

    deb *z, i, d, T.last, o: true, l: true
  end
end

def evf f
  r = nil

  begin
    z = File.readlines(f).join

    deb :evf, f, z

    r = eval(z)

    deb :eval, r
  rescue
  end

  r
end

def stm t = T
  t << Time.now

  if block_given?
    yield t
  else
    [ t.last(2).reduce(:'-').abs, t.last ]
  end
end

def inc a, b
  a.first <= b.first && b.last <= a.last
end
