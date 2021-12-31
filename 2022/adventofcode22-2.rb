#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

class R

  def initialize

#    @s = arg.to_i

    a = {}
    n = nil
    s = false
    g = false
    t = false

    a = \
    inp(s: s, g: g, t: t) {
      |x, i|

      unless true
        err :inp, x

        xs = x.map { |z| z.to_sym }
        xi = x.map { |z| z.to_i }

        k = xs.shift

        v = xs.size == 1 ? xi[1] : xs

        a[ k ] = v

        #err :a, a, k, xs

        case s ? x : xs[0]
          when :Blueprint
            n = xi[1]
            a[n] = {}

            c = 2

            #err :xs, xs

            next unless xs[1+c]

          when :Each

            c = 0

            #a[ x[1] ] = [ x[4].split(?=)[1].to_i, x[9..] ]

          else
            err :inp, i, x, @s

        end

        t = xs[1+c]

        a[n][t] ||= []
        a[n][t] += [
            [ xs[5+c], xi[4+c] ],
            [ xs[8+c], xi[7+c] ]
          ]

        a[n][t] -= [[nil,nil]]

        #dss :an, a[n]
      end

      #eval x
      #(to_i x.split(?,))
      #x.to_i
      to_sym(x)
    }

    ben {
      @r = run a #.freeze
    }
  end

  def run a

    d = a.pop.join

    n = d.split(/[A-Z]/) - [""]

    d = d.split(/[0-9]*/) - [""]

    d.map! {
      |v|

      [v.to_sym, n.shift.to_i]
    }

    #err :d, d

    c = {}
    f = nil

    a.each_with_index {
      |b, i|

      b.each_with_index {
        |v, j|

        r = [i, j]

        case v
          when :' '
            #err :n, v, r

          when :'.'
            f ||= r

            c[r] = false
            #err :e, v, r

          when :'#'
            c[r] = true
            #err :b, v, r

          else
            err :idk, v, r

        end
      }
    }

    r = [f, :R]

    inloop d, [c, r]
  end

  R = [:R, :D, :L, :U]

  def val x
    l, r = x[1]

    i = R.find_index r
    
    s = 1000 * (l[0] + 1) + 4 * (l[1] + 1) + i

    dss :val, l, r, i

    s
  end

  def play x, a

    c, h = a
    r, n = x

    deb :play, h, n, r, l: true

    move c, h, n

    h[1] = rot h[1], r

    #cout *a
  end

  def rot z, r

    i = R.find_index z

    n = \
    if r == :U
      r = :R
      2
    else
      1
    end

    n.times {
      #dss :rot, n, z, r, i

      i += r == :L ? -1 : 1

      i = R.size - 1 if i < 0

      i %= R.size
    }

    #dss :rot, h[1], r, R[i]

    R[i]
  end

  def rrt t
    R.detect {
      |q|

      dir(q) == t
    }
  end

  def move c, h, n

    #err :c, c.size, l, n

    l, r = h

    d = dir r

    n.times {

      t = nex l, d

      x = 0

      1.times do

        x += 1

        v = c[t]

        break 2 if v

        if v.nil?

          t, d = warp c, t, d

          eut :redo, c, [t, nil], d if x > 1

          #deb :redo, t, d

          redo
        end

        l = t
        r = rrt d
      end

    }

    h[0], h[1] = l, r
  end

  W = 50

  def warp c, l, d
    ck = c.keys

    i = d.find_index 0
    j = (i + 1) % 2

    g = nil
    s = nil

    ck.each {
      |k|

      next unless l[j] == k[j]

      n = (k[i] - l[i]).abs

      s ||= n
      g ||= k

      if n < s
        s = n
        g = k
      end
    }

    unless s.nil? || s >= W
      eut :s, c, [g, nil], l, d if g.nil?

      unless s < 1
        s -= 1
      else

        eut :y, c, [g, nil], l, d

        l = dcl g

        l.reverse!
        d.reverse!

        y = true

      end

      g = dcl g

      o = dcl d
      o[j] *= s

      add g, o

      d = [0, 0]
      d[i] = (g[i] - l[i]) > 0 ? 1 : -1

    else
      x = \
      if j == 0
        max ck
      else
        max2 ck
      end

      g = dcl l
      s = nil

      #v = g[j]

      #v = x if v < 0
      #v = 0 if v > x

      #g[j] = v

      d = qud c, g, d

      #eut :k, c, g, r
    end

    eut :g, c, [l, r], d, s if g.nil?

    unless true \
      || s || K.include?( [g, (r = rrt d)] )

      #cout c, [b, r], o: true
      cout c, [l, nil], o: true
    
      eut :warp, c, [g, r]
    end

    cout c, [l, nil], o: true
    cout c, [g, r], o: true

    [g, d]
  end

  K = [ 
    [[150,   0], :R],
    [[ 38, 149], :L],
    [[130,  99], :L],
    [[  0, 144], :D],
    [[199,  40], :U],
    [[  4,  50], :R],
    [[168,   0], :R],
    [[ 23,  50], :R],
    [[186,   0], :R],
    [[  0,  84], :D],
    [[176,   0], :R]
  ]

  Q = {
    [-1,  1] => [:R, [3, 0]],
    [ 2,  2] => [:U, [0, 2]],
    [ 2, -1] => [:U, [0, 1]],
    [ 0,  3] => [:U, [2, 1]],
    [ 4,  0] => [:N, [0, 2]],
    [-1,  2] => [:N, [3, 0]],
    [ 3, -1] => [:L, [0, 1]],
    [ 0,  0] => [:U, [2, 0]],
    [ 3,  1] => [:R, [3, 0]],
    [ 1,  0 ] => [:R, [3, 0]],
  }

  def qud c, l, d

    q = [ l[0] / W, l[1] / W ]

    if Q[q].nil?
      z = rrt d

      #cout c, [l, nil], o: true
      eut :qud, c, [l, z], q
    end

    v = q == [3, 1]

    cout c, [l, d] if v

    r, s = dcl Q[q]

    f = [-W * q[0], -W * q[1]]

    # 1 side only
    add l, f

    # rotate
    case r
      when :R
        l.reverse!
        flip l, 1

      when :L
        l.reverse!
        flip l, 0

      when :U
        flip l, 0
        flip l, 1

      when :N

      else
        eut :r, c, l, r

    end

    # dir
    d = rtt d, r unless r == :N

    # shift
    add l, s.map { |x| W * x }

    eut :ql, c, [l, d], r if c[l].nil?

    eut :qu, c, [l, d], r if v

    d
  end

  def rtt d, r  
    z = rrt d
    z = rot z, r
    dir z
  end

  def flip l, i, w = W - 1
    l[i] = w - l[i]
  end
  
  def eut l, c, g, *r

    ass :eut, l, g, r, isa?(g), isa?(g[0]) 

    cout c, g, o: true
    err l, *r
  end

  def nex x, y
    [ x[0] + y[0], x[1] + y[1] ]
  end

  def dir x
    a = [:L, :R, :U, :D]

    i = a.find_index x

    r = D[i].dup

    ass :dir, x, r, r == dir_old(x)
    
    r 
  end

  def dir_old x
    case x
      when :R
        D[1]
      when :D
        D[3]
      when :L
        D[0]
      when :U
        D[2]
      else
        err :dir, x, D

    end.dup
  end

  def cout c, h, o: false
    return unless DEB || o

    ass :cout, h, isa?(h), isa?(h[0]) 
  
    f = dcl h[0]

    ck = dcl c.keys
  
    out \
      ck.select { |k| c[k] }, \
      ck.reject { |k| c[k] }, \
      [f]

    deb :cout, h
  end

  def inloop a, b

    c = []
    i = 0
    as = a.size
  
    loop {
      x = i % as

      r = play a[x], b

      #c << val(b, as) if T.include?( i )

      i += 1

      break if i >= as
    }

    val b
  end

  def inparallel a
    t = 4 unless Process.respond_to?(:fork)

    Parallel.map(a, in_threads: t) {
      |(b, v)|

      r = play v, b

      [b, r]

    }.reduce {
      |k, (b, g)|

      k * g
    }
  end

  def out(w, s = [], t = [], \
    wc: '#'.colorize(:cyan), \
    sc: '.'.colorize(:green), \
    tc: '@'.colorize(:red), \
    o: false, f: false, d: 2)

    return unless DEB || o

    a = nil

    unless @outc
      w = dcl w
      s = dcl s

      # flip
      if f
        w.map! {
          |(x, y)|

          [-x, y]
        }

        s.map! {
          |(x, y)|

          [-x, y]
        }
      end

      m = [0, 0]
      n = [E, E]

      #deb :w, w

      # store
      w += s
      w += t

      w.each {
        |l|

        [0, 1].each {
          |i|
          m[i] = l[i] if l[i] > m[i]
          n[i] = l[i] if l[i] < n[i]
        }
      }

      r, c = n
      r -= d
      c -= d
      
      w.map! {
        |l|

        [ l[0] - r, l[1] - c ]
      }

      # load
      s = w.last(s.size + t.size)
      t = s.pop(t.size)

      x, y = m[0] - r + d, m[1] - c + d

      a = [ [ wc ] * y ] * x
      a = dcl a

      #err :w, w.size, s.size

      s.each {
        |g|
        set(a, g, sc)
      }

      w -= t

      @outc = dcl [a, w, r, c]

    else
      a, w, r, c = dcl @outc

      t = dcl t

      # flip
      if f
        t.map! {
          |(x, y)|

          [-x, y]
        }
      end
      
      t.map! {
        |l|

        [ l[0] - r, l[1] - c ]
      }
    end

    w += t

    t.each {
      |g|
      set(a, g, tc)
    }

    super(a, w, b: false, h: false, o: true)
  end
end

res R.new
