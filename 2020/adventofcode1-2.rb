#!/usr/bin/ruby -W0

require_relative 'class'

z = inp { |x| x.to_i }

res \
dlt3(z) {
  |a, b, c|
  a + b + c == 2020 && a * b * c || nil

}.uniq - [nil]
