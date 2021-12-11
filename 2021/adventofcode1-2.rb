#!/usr/bin/ruby

require 'ap'
alias :p :pp

inc = 0
r = nil

dat = ARGF.readlines.map { |z| z.chomp.to_i }

dat.each_with_index {
  |_, i|
  next if i < 2

  c = 3.times.inject(0) { |g, x| g + dat[i - x] }

  p [c, r]

  if r
    inc += 1 if r < c
  end

  r = c
}

p "increased: #{inc}"



