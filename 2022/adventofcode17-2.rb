#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

class R

  def initialize

#    @s = arg.to_i

    a = \
    inp(s: false) {
      |x, i|

      #next if x == '->'

      #(to_i x.split(?,)).reverse!

      unless true
      x = x.gsub(/[,:;]/,' ').split.each_with_index.map {
        |z, i|

        if i == 4
          z
        else
          z.to_sym
        end
      }

      case x[0]
        when :Valve
        
          #dss :x, x

          a[ x[1] ] = [ x[4].split(?=)[1].to_i, x[9..] ]

        else
          err :ix, i, x, @s
      end
      end

      #x = eval x
      x = to_sym x
    }

    ben {
      @r = run a
    }
  end

  F = [
    ['####'], 

    [' # ',
     '###', 
     ' # '], 

    ['#  ',
     '#  ', 
     '###'], 

    ['#',
     '#', 
     '#', 
     '#'], 

    ['##',
     '##'], 
  ]

  W = 7
  M = [4, 2]
  C = 1000000000000
  D = [-1, 0]
  T = false
  B = false

  def run a

    #err :a, a

    dss :a, a.size == 1

    a = a[0]

    a.map! {
      |x|
      case x
        when :<
          [0, -1]
        when :>
          [0, +1]
      else
        err :x, x
      end
    }

    #deb a, W, M, C

    f = \
    F.map {
      |o|
      
      sha(o)
    }

    t = lin([0,0], [0, W-1])

    as = a.size
    fs = f.size

    z = 0

    #o = File.open('out17-2.txt', 'a')

    c = 0

    l = 0

    b = 0


    # Step ahead
    sm = 100

    if T
      s = 35*sm
      sv = 53*sm
      m = 2
    else
      s = 5345 - 3610
      sv = 2673
      m = 824
    end

    d = {}
    h = {}

    C.times {

      #if c % fs == 0
        #deb :c, c, z, fs, as, o: true
        #c = 0
      #end

      if c % fs == 0 && z == m

        x = t.max[0] + b

        g = t.select {
          |(q, _)|

          q > x - 1

        }.map {
          |(_, q)|

          q
        }

        if B
          l = d[z] || 0
        end

        deb :x, z, c, x, x - l, o: true

        if B
          if d[z]
            h[z] = x - l
          end

          d[z] = x

          if h[z]
            err :hz, z, h[z] if h[z] == x - l
          end
        end        

        #err unless l == 0

        if s > 0 && sv > 0
          while c < C - s
            c += s
            b += sv
          end

          deb :s, c, b, o: true
        end

        l = x
      end

      z = play(t, a, z, f[c % fs], as)

      c += 1

      if B && c > 10000
        err :d, d
      end

      #deb :c, c
      #out t, b

      #o.puts t.max[0]

      break if c >= C
    }

    b + t.max[0]
  end

  def play t, w, z, s, ws

    s = dcl s
    m = dcl M

    m[0] += t.max[0]

    s.each {
      |l|

      add l, m
    }

    #deb :play, s, m, t.max
    #out t, s, sc: '@'.colorize(:red)

    loop {    
      d = w[z % ws]
      z += 1

      if z % ws == 0
        #deb :z, z, o: true
        z = 0
      end

      n = mov(t, s, d)
      s = n if n

      #deb :wind, d
      #out t, s, sc: '@'.colorize(:red)

      n = mov(t, s, D)

      #deb :down
      #out t, s, sc: '@'.colorize(:red)

      break unless n

      s = n
    }

    t.concat s

    z
  end

  def chc t, n
    t & n == [] \
    && \
    n.none? {
      |(_, y)|

      y < 0 || y >= W
    }
  end

  def sha f
    c = []

    x = f.size

    f.each {
      |l|

      x -= 1

      l = l.split('')

      #dss :l, f, l

      y = l.size

      l.each {
        |z|

        y -= 1

        case z
          when '#'
            c << [x, y]

          when ' '
        else
          err :sha, z
        end
      }
    }

    c
  end

  def mov(t, s, d)
    n = dcl s

    n.map {
      |x|

      add x, d
    }

    n if chc(t, n)
  end

  def out(w, s = [], wc: '#'.colorize(:cyan), sc: '-'.colorize(:green), o: false)

    return unless DEB || o

    w = dcl w
    s = dcl s

    # flip

    w.map! {
      |(x, y)|

      [-x, y]
    }

    s.map! {
      |(x, y)|

      [-x, y]
    }

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

    super(a, w, b: false, h: false, o: true)
  end
end

res R.new
