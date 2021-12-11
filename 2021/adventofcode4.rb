#!/usr/bin/ruby

require 'ap'
alias :p :pp

dat = ARGF.readline.chomp.split(?,).map { |z| z.to_i }

p dat.join(?,)

puts

bdat = ARGF.readlines.map { |z| z.chomp.split.map{ |x| x.to_i } }

b = 0
d = []

bdat.each { |l|
  next if l.empty?

  d[b] ||= []

  d[b] << l
  b += 1 if d[b].size >= 5
}

p d
puts

r = nil
w = nil

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

p \
r.inject(0) {
  |s, l|

  l.inject(s) {
    |t, v|

    v > 0 ? v + t : t
  }

} * w
