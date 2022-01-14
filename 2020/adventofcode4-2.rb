#!/usr/bin/ruby -W0

require_relative 'class'

z = inp(false) {
  |x, i|

  v= x.split(?:)

  [v[0].to_sym] + v[1..]
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


def val r, c
  r = dcl r

  ass :v, c.any?, r.any?

  c.each {
    |(i, v)|
    r -= [i]
  }
  return false unless r.empty?

  c.map! {
    |(i, v)|

    r = \
      case i
        # byr (Birth Year) - four digits; at least 1920 and at most 2002.
        when :byr
          v = v.to_i
          v >= 1920 && v <= 2002

        # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
        when :iyr
          v = v.to_i
          v >= 2010 && v <= 2020

        # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
        when :eyr
          v = v.to_i
          v >= 2020 && v <= 2030

        # hgt (Height) - a number followed by either cm or in:
        #     If cm, the number must be at least 150 and at most 193.
        #     If in, the number must be at least 59 and at most 76.
        when :hgt
          j = v[-2..]
          v = v[..-2].to_i

          if j == 'cm'
            v >= 150 && v <= 193

          elsif j == 'in'
            v >= 59 && v <= 76

          end

        # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
        when :hcl
          v = v.split('')
          v.size == 7 \
            && v[0] == '#' \
            && (v[1..] - ('0'..'9').to_a - ('a'..'f').to_a).empty?

        # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
        when :ecl
          %w{amb blu brn gry grn hzl oth}.include? v

        # pid (Passport ID) - a nine-digit number, including leading zeroes.
        when :pid
          v.size == 9 \
            && (v.split('') - ('0'..'9').to_a).empty?

        when :cid
          true

        else
          err :idk, i,v

      end

    unless r
      return false

    else
      #deb i, v #if i == :hcl # ].include? i # || i == :hcl && v.size

    end

    v
  }

  true
end

c = []
q = 0

z.each {
  |v|

  if iss v[0]
    c << v

  elsif v.any?
    c += v

  else
    if val req, c
      #err :val, c
      q += 1

    else
      #err :nop, c
      #irb req, c

    end

    c = []

  end
}

q += 1 if val req, c

res q
