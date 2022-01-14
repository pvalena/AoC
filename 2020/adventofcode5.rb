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
        err :dik

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

z.map! {
  |v|

  id v
}

deb z

res z.max
