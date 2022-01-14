#!/usr/bin/ruby -W0

require_relative 'class'

z = inp {
  |x, i|

  sym x
}

def id v
  r = [0, 128]
  c = [0, 8]

  v.each {
    |w|

    case w
      when :F
        lo r

      when :B
        up r

      when :L
        lo c

      when :R
        up c

      else
        err :dik, w

    end
  }

  r[0] * 8 + c[0]
end

def lo r
  r[1] /= 2
end

def up r
  r[1] /= 2

  r[0] += r[1]
end

ass :id, id(sym 'FBFBBFFRLR') == 357

s = {}

z.map! {
  |v|

  s[v] = id v
}

l = s.values

[:F,:B].each { |a|
[:F,:B].each { |b|
[:F,:B].each { |c|

[:F,:B].each { |d|
[:F,:B].each { |e|
[:F,:B].each { |f|
[:F,:B].each { |g|

[:L,:R].each { |h|
[:L,:R].each { |i|
[:L,:R].each { |j|

  n=[a,b,c,d,e,f,g,h,i,j]

  next if s[n]

  v = id n

  ass n, v, !l.include?(v)

  deb :f, n, v if l.include?(v+1) && l.include?(v-1)

}}} }}}} }}}
