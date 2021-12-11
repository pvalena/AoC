#!/usr/bin/ruby

n=170

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

p dat

sch = []

n.times {
  f = []

  dat.map! {
    |c|

    if c <= 0
      f << 8
      6
    else
      c - 1
    end
  }

  dat += f
}

p [n, dat.size]
