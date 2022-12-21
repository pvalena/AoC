#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

class R

  def initialize

#    @s = arg.to_i
  
    a = \
    inp(f: 'out17-2.txt') {
      |x, i|

      x.to_i
    }

    ben {
      @r = run a
    }
  end

  def run a

    #err :a, a

    r = 0
    w = a.map { |c| n = c - r; r = c; n }

    dss :run, w.size

    seq w, a
  end

  def seq w, a
    f = w[0...(w.size/2)]
    s = w[(w.size/2)..]

    deb :seq, f.size, s.size

    lv = []

    0.upto(f.size).each_with_index {
      |i|

      j = 0
      v = []
      vb = nil
      vl = nil

      f[i..].each_with_index {
        |x, l|

        y = s[j]
        j += 1

        if x == y
          v << y

          vl = a[i+l]

          if vb.nil?
            vb = [i+l, vl]
          end

        else
       
          if v.size > lv.size
            lv = v
            deb :v, vb, i, v.size, vl
          end

          v = []
          vb = nil
          vl = nil
        end
      }

      if v.size > lv.size
        lv = v
        deb :lv, vb, i, v.size, vl
      end
    }

    return lv.size if lv.size < 10

    seq lv, a
  end

end

res R.new
