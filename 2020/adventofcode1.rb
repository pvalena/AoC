#!/usr/bin/ruby -W0

require_relative 'class'

z = inp { |x| x.to_i }

deb \
dlt(z) {
  |a, b|
  a + b == 2020 && a * b || nil

} - [nil]
