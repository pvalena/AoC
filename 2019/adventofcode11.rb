#!/usr/bin/env -S ruby

DEB = false

require_relative 'class'

class R

  def initialize

    @a = arg

    a = {}
    j = nil

    n, s, g, t = nil

    #dcl([nil] * 4)

    #n = false
    #s = false
    #g = false
    #t = false

    a = \
    inp(n, s, g, t) {
      |x, i|

      #err :inp, x

      unless true

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
      x.to_i
      #to_sym(x)
      #x.split('').map(&:to_i)
    }

    ben {
      @r = run a #.freeze
    }
  end

  def run a
    # computer
    a = a.first

    def a.[](i)
      err :oor, i if isi?(i) && i < 0
      super(i) || 0
    end

    a = [a, 0]
    @r = 0
    l = @a || 0

    # robot
    c = {}
    q = [c, dir(:U), [0, 0]]

    # run
    loop {
      r = amp a, [l]

      deb :amp, r

      break unless r

      l, q[1] = rob *q, *r

      deb :rob, l, [rrt(q[1]), q[2]], l: true
    }

    out c, o: true

    #err :c, c

    c.size
  end

  def rob c, q, l, r, t

    c[ l.dup ] = (r > 0)

    v = (t == 0 ? :L : :R)

    q = rtt q, v

    add l, q

    v = c[l] ? 1 : 0

    [v, q]
  end

  def amp a, g, o = []

    loop {
      a[1] = play(*a, g, o)

      break if o.size >= 2

      return if a[1].nil?
    }

    ass :amp, o.size, o.size == 2

    o
  end

  def play c, i, g, o

    ass :i, i, c[i]

    a = c[i..i+3]

    ass :a, c, i, isa?(a)

    s = a.shift
    m = s / 100
    s = s % 100

    m = m.to_s.split('').map { |v| v.to_i }.reverse
    m << 0 until m.size >= 3
    
    w = c[i+3]
    w += @r if m[2] == 2

    deb :play, i, s, a, l: true

    case s
      when 1
        a = san c, m, a

        ass :add, a[0], a[1], w, w >= 0

        c[w] = a[0] + a[1]

      when 2
        a = san c, m, a

        ass :mul, a[0], a[1], w, w >= 0

        c[w] = a[0] * a[1]
        
      when 3
        a = san c, m, a.first

        w = c[i+1]
        w += @r if m[0] == 2

        ass :g, g.any?

        deb :input, w, g.first
        ass w >= 0

        c[w] = g.shift

      when 4
        a = san c, m, a.first

        #deb :output, a[0]
        o << a[0]

      when 5
        a = san c, m, a.first(2)

        deb :jump_t, a[0], a[1]
        ass a[1] >= 0

        return a[1] if a[0] != 0

      when 6
        a = san c, m, a.first(2)

        deb :jump_f, a[0], a[1]
        ass a[1] >= 0

        return a[1] if a[0] == 0

      when 7
        a = san c, m, a

        deb :less, a[0], a[1], w
        ass w >= 0
        
        c[w] = a[0] < a[1] ? 1 : 0

      when 8
        a = san c, m, a

        deb :eql, a[0], a[1], w #, o: true
        ass w >= 0

        c[w] = a[0] == a[1] ? 1 : 0

      when 9
        a = san c, m, a.first

        deb :relative, a[0] #, o: true
        @r += a[0]

      when 99
        deb :exit #, o: true
        return

      else
        err :s, s
    end

    n = a.size + 1

    #err :n, n

    i + n
  end

  def san c, m, *n

    n = n.first if n.size == 1 && isa?(n.first)

    ass :san, m, n

    n = \
    n.each_with_index.map {
      |v, i|

      ass :v, v, i, isi(v), !m[i].nil?

      if m[i] == 1
        v

      else
        o = m[i] == 2 ? @r : 0

        ass :v, v, o, m[i]

        c[v + o]
      end
    }
  
    err :san_out, m, n if n.include?(nil)

    n
  end

  def out c, z = {}, m = nil, **k

    w, g = [], []

    c.keys.each {
      |x|

      v = c[x]

      if v

        w

      else

        g

      end << x
    }

    q = z.keys
    q << m if m

    super(w, [], q, **k)
    
    
    [].each {
      |x|

      v = z[x]

      if v

        v = \
        if v.size == 1

          rrt v[0]

        else

          v.size

        end

        v.to_s.colorize(:green)
  
      else

        '@'.colorize(:red)

      end
    }
  end
end

res
