#!/usr/bin/ruby

def deb i
#   p i
end

n=1000

require 'ap'
alias :p :pp

dat = ARGF.readlines
  .map {
    |l|
    l = l.chomp.split(' ')
    [0,2].map{
      |x|
      l[x].split(?,).map { |y| y.to_i }
    }
    .flatten
  }


#dat.select! {
#  |d|
#  d[0] == d[2] || d[1] == d[3]
#}


e = []
n.times { e << 0 }

b = []
n.times { b << e.dup }

dat.each {
  |d|

  if d[0] == d[2]
    r = d[0]

    if d[1] > d[3]
      d[1], d[3] = d[3], d[1]
    end

    d[1].upto(d[3]) {
      |c|
      b[c][r] += 1
    }

  elsif d[1] == d[3]
    c = d[1]

    if d[0] > d[2]
      d[0], d[2] = d[2], d[0]
    end

    d[0].upto(d[2]) {
      |r|
      b[c][r] += 1
    }

  else
    if d[0] > d[2]
      d[0], d[2] = d[2], d[0]
      d[1], d[3] = d[3], d[1]
    end

    r = d[0]

    if d[1] > d[3]
      deb [d, 'd']
      d[1].downto(d[3]) {
        |c|
        b[c][r] += 1
        r += 1
      }
    else
      deb [d, 'u']
      d[1].upto(d[3]) {
        |c|
        b[c][r] += 1
        r += 1
     }
    end
  end
}

deb b

p \
b.inject(0) {
  |s, l|

  l.inject(s) {
    |t, v|

    v >= 2 ? t + 1 : t
  }
}

exit



###

b = 0
d = []

dat.each {
  |c|
  puts ">> #{c}"
  w = c

  d.map! {
    |b|

    b.map! {
      |l|

      l.map! {
        |k|

        k == c ? -1 : k
      }
    }
  }

  d.each {
    |b|

    b.each {
      |l|

      l.each {
        |k|
        print "#{k} #{' ' * (2 - k.to_s.size)}"
      }
      puts
    }
    puts
  }

  bi = -1
  r = d.detect {
    |b|
    bi += 1

    b.detect {
      |l|

      l.select {
        |k|
        k < 0
      }.size == 5

    }
  }
  if r
    puts "W: #{bi}"
    p d[bi]
    puts
    d.delete_at(bi)
    break if d.empty?
    redo
  end

  bi = -1
  r = d.detect {
    |b|
    bi += 1

    f = false

    5.times {
      |k|

      f = \
      0.upto(4).select {
        |l|

        b[l][k] < 1

      }.size == 5

      break if f
    }

    f
  }
  if r
    puts "W: #{bi}"
    p d[bi]
    puts
    d.delete_at(bi)
    break if d.empty?
    redo
  end
}

p r
puts
