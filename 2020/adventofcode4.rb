#!/usr/bin/ruby -W0

require_relative 'class'

z = inp(false) {
  |x, i|

  x.split(?:)[0].to_sym
}


req = [
    :byr,
    :iyr,
    :eyr,
    :hgt,
    :hcl,
    :ecl,
    :pid,
  ]


def val r, v
  (r - v).empty?
end

c = []
q = 0

z.each {
  |v|

  if iss v
    c << v

  elsif v.any?
    c += v

  else
    if val req, c
      q += 1

    else
      #irb req, c

    end

    c = []

  end
}

q += 1 if val req, c

res q
