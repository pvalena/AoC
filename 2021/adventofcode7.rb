#!/usr/bin/ruby

def de i
   p i
end

require 'ap'
alias :p :pp

dat = ARGF.readlines
  .map {
    |l|
    l = l.chomp.split(?,)
      .map{
        |x|
        x.to_i
      }
      .flatten
  }[0]

puts
de dat

cr = []
dat.each {
  |x|
  cr[x] ||= 0
  cr[x] += 1
}

dat.max.times {
  |i|
  cr[i] ||= 0
}

de cr
puts

mi = nil
dat.max.times {
  |n|

  f=0

  cr.each_with_index {
    |c, o|

    di = (n-o).abs

    nf = c * di
    f += nf

    #p [o, n, c, di, nf, f]
  }

  de [n, f]

  mi ||= [n, f]
  mi = [n, f] if f < mi[1]
}
puts

p mi
