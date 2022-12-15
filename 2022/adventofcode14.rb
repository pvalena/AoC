#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

class R

  def initialize

    #@s = arg

    a = \
    inp() {
      |x, i|

      next if x == '->'

      to_i x.split(?,)

      #err :ix, i, x

      #x = eval x

      #x = x.gsub(/[,:]/,' ').split

      #x = to_sym x
    }

    @s = [0, 500]

    ben {
      @r = run a
    }
  end

  def run a

    w = dra a

    @n = w.max[0]

    o = []

    while s = san(w + o)

      break if @s == s

      o << s
    end

    out w, o

    o.size
  end

  def out(w, o = [])
    w = dcl w
    o = dcl o
    s = dcl @s

    m = [0, 0]
    n = [E, E]
    d = 2

    w += o
    w << s
  
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

    o = w.last(o.size + 1)
    s = o.pop

    #err :o, o.size
    
    #err :w, w

    x, y = m[0] - r + d, m[1] - c + d

    a = [ [ :'#' ] * y ] * x
    a = dcl a

    set(a, s, :+)

    o.each {
      |g|
      set(a, g, :o)
    }
 
    super(a, w)
  end

  def san w, n = @n
    s = dcl @s

    r = [0, 0]

    while r != s
      r = s
      s = rux( w, s )
  
      #err :s, s
      
      return if s[0] > n
    end

    #dss :san, s

    s
  end

  R = [[1, 0], [1, -1], [1, 1]]

  def rux w, s
    #dss :rux, s

    R.each {
      |x|

      n = [ s[0] + x[0], s[1] + x[1] ]

      return n unless w.include?(n)
    }

    s
  end

  def play 

    #deb :play, l, r unless li && ri

    if false

    else
      err :play, l, r, li, ri, la, ra

    end
  end

end

res R.new
