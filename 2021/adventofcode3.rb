#!/usr/bin/ruby

require 'ap'
alias :p :pp

dat = ARGF.readlines.map { |z| z.chomp.split('').map{ |x| x.to_i } }


odat = dat.dup

12.times { |b|
  g = [0,0]

  odat.each_with_index {
    |d, i|

    g[d[b]] += 1
  }

  #c = g * e

  k = g[1] >= g[0] ? 1 : 0

  odat.select! { |d|
    d[b] == k
  }

  p [b, g, k]

  break if odat.size == 1
}

ox = odat[0].join.to_i(2)

####


12.times { |b|
  g = [0,0]

  dat.each_with_index {
    |d, i|

    g[d[b]] += 1
  }

  #c = g * e

  k = g[0] <= g[1] ? 0 : 1

  dat.select! { |d|
    d[b] == k
  }

  p [b, g, k]

  break if dat.size == 1
}

co = dat[0].join.to_i(2)

p [ox, co, ox*co]
