#!/usr/bin/env -S ruby

DEB = false

require_relative 'class'

class R

  def initialize

    @s = arg.to_i
    
    @s == 0 && @s = 2000000

    a = \
    inp(s: false) {
      |x, i|

      #next if x == '->'

      #(to_i x.split(?,)).reverse!

      x = x.gsub(/[,:]/,' ').split

      case x[0]
        when 'Sensor'
          (x[2..3] + x.last(2)).map { |z| z.split(?=)[1].to_i }
        else
          err :ix, i, x, @s
      end

      #x = eval x


      #x = to_sym x
    }

    ben {
      @r = run a
    }
  end

  def run a, l = @s

    deb :a, a.size, l, o: true

    w = []

    a = \
    a.inject([]) {
      |k, x|

      s = [x[1], x[0]]
      b = [x[3], x[2]]

      w += play(s, b, l)
      w.uniq!

      k << s[1] if s[0] == l
      k << b[1] if b[0] == l

      k
    }

    dss :w, w, :a, a, o: true

    (w - a).size
  end

  def play f, y, l

    d = man f, y

    deb :play, f, y, d, o: true

    x = \
    D.map {
      |r|

      [ r[0]*d + f[0], r[1]*d + f[1] ]
    }
    
    dss :x, x

    j = []

    x.each {
      |a|

      x.each {
        |b|

        next unless a[1] <= b[1] && a[1] != b[1]

        i = 0
        r = (a[0]..b[0])
        g = (b[0]..a[0])

        if r.include?(l)

          if a[0] <= b[0] && a[1] <= b[1]
            j << b[1] - (b[0] - l)
          else
            dss :ab1, a, b, r
          end

        elsif g.include?(l)

          if a[0] >= b[0] && a[1] <= b[1]
            j << a[1] + (a[0] - l)
          else
            dss :ab2, a, b, g
          end

        end

        #err :j, j

      }
    }

    unless j.empty?
      j = \
      ran(*j).to_a

      unless true
        'comment'.map {
          |g|

          [l, g]
        }
      end

      dss :j, j, j.size, o: true
    end

    j
  end

  def out(w, s = [], wc: '#'.colorize(:cyan), sc: 'X'.colorize(:green))

    return unless DEB

    w = dcl w
    s = dcl s

    m = [0, 0]
    n = [E, E]
    d = 2

    #deb :w, w

    # store
    w += s

    w.each {
      |l|

      [0, 1].each {
        |i|
        m[i] = l[i] if l[i] > m[i]
        n[i] = l[i] if l[i] < n[i]
      }
    }

    r, c = n
    c -= d
    
    w.map! {
      |l|

      [ l[0] - r, l[1] - c ]
    }

    # load
    s = w.last(s.size)

    x, y = m[0] - r + d, m[1] - c + d

    a = [ [ wc ] * y ] * x
    a = dcl a

    #err :w, w.size, s.size

    s.each {
      |g|
      set(a, g, sc)
    }

    super(a, w, b: false, h: false)
  end
end

res R.new
