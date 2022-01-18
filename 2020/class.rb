#!/usr/bin/ruby -W0

# export RUBY_THREAD_VM_STACK_SIZE=15000000
# ulimit -s 2097024

require 'colorize'
require 'ap'

alias :p :pp

DEB = true

# Max stack depth
S = 45000

# Empty? Absurdly big?
E = 9999999

# Input ARGF; process block per element in a line
# Skip empty lines? $1
def inp n = true, &b

  puts if DEB

  ARGF
    .readlines
    .map {
      |o|
      l = o.chomp.split

      next if n && l.empty?

      if b
        l = \
        l .each_with_index.map {
            |v, i|

            yield v, i
          }
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

# Is integer
def isi a
  a.kind_of?(Integer)
end

# Is array
def isa a
  a.kind_of?(Array)
end

# Is Symbol
def iss a
  a.kind_of?(Symbol)
end

# Print inspect, no spaces
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

# Print array $1 nicely
# o: override DEB output
# block to modify printed value
# or compare to E => spc
def pra a, d = 2, o: false, &b
  return unless DEB or o

  s = 2

  spc s+1
  a[0].size.times {
    |i|

    i = i.to_s
    spc d - i.size
    print i
  }
  puts

  spc s+1
  a[0].size.times {
    |i|

    i = i.to_s
    spc d - 1
    print "─"
  }
  puts

  a.each_with_index {
    |x, i|

    spc if i <= 9
    print "#{i}│"

    x.each {
      |z|
      y = z.to_s

      spc d - y.size

      if b
        print yield z, y

      else
        if z == E
          spc

        else
          print y

        end

      end
    }
    puts

  }
  puts
end

# add enumerables $2 into $1
def add a, b
  b.each_with_index {
    |_, k|
    a[k] += b[k]
  }

  a
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
def to_s a, &b
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

# Debug output $*
# o: override DEB output
def deb *i, o: false
  return unless DEB or o

  while i.respond_to?(:size) && i.size == 1 && i != i[0]
    i = i[0]
  end

  p i
  puts
end

# Run irb with context $*
def irb *a
  require 'irb'
  begin
    binding.irb
  rescue
  end
end

# Ass + deb $*
def dss *a
  ass *a
  deb *a
end

# Assert $* per argument
# first symbol replaces default identifier :ass
# Start irb on error
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

      err a, l: r, x: false
      irb *a

    ensure
      abort

    end unless z
  }
end

# Error exit $*
# l: error identifier
# x: exit?
def err *z, l: :'e', x: true
  unless z.nil? || z.empty?

    while z.respond_to?(:size) && z.size == 1 && z != z[0]
      z = z[0]
    end

    z.unshift l if z.respond_to? :unshift
    deb *z, o: true
  end

  exit if x
end

# Print $1 spaces; or $2
def spc n = 1, s = ' '
  print s * n
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

# Lookup around array $1, check block
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
def res r
  puts
  puts "\n=> " + r.to_s
end

# Get commandline arg
def arg
  ARGV.pop.to_i
end

# Create hash-based cache via block
def hsh
  Hash.new {
    |h, i|

    h[i] = yield i
  }
end

# Multiplicate all elements of array
def mul a
  a.inject(1) {
    |x, k|
    x * k
  }
end
