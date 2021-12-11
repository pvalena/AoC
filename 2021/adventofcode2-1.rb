#!/usr/bin/ruby

require 'ap'
alias :p :pp

c = [0,0]
a = 0

dat = ARGF.readlines
#.map { |z| z.split .chomp.to_i }

dat.each_with_index {
  |d, i|
  #next if i < 2

  #c = 3.times.inject(0) { |g, x| g + dat[i - x] }

  (o, n) = d.split
  n = n.to_i

  case o
    when "forward"
      c[0] += n
      c[1] += a*n
    when "down"
      a += n
    when "up"
      a -= n
    else abort
  end

  p [c, o, n]
}

p "c: #{c.inspect}; x: #{c[0] * c[1]}"
