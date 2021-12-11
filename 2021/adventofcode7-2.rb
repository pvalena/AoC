#!/usr/bin/ruby

def de i
#   p i
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
p cr.size
puts

sp = Hash.new {  |x,v|  v > 0 ? x[v-1] + v : 0  }

mi = dat.max*1000000000
dat.max.times {
  |n|

  f=0
  cr.each_with_index {
    |c, o|

    f += c * sp[ ( n - o ).abs ]

    if o % 100
      break if f >= mi
    end

    #p [o, n, c, di, nf, f]
  }

  #de [n, f]

  #mi ||= [n, f]
  mi = f if f < mi
}
puts

p mi
