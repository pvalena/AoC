#!/usr/bin/ruby

n=256

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

#p dat

sch = []
9.times { |x| sch << 0 }

dat.each {
  |x|
  sch[x] ||= 0
  sch[x] += 1
}

n.times {
  f = sch.shift

  sch[8] = f
  sch[6] += f
}

p sch.inject(0) {
    |s, l|
    s + l
  }
