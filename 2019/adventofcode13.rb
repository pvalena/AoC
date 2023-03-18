#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

class R

  def initialize

    @a = arg

    a = {}
    j = nil

    n, s, g, t = nil

    #n = false
    #s = false
    #g = false
    #t = false

    a = \
    inp(n, s, g, t) {
      |x, i|

      #err :inp, x

      if true        
        #eval x
        x.to_i
        #to_sym(x)
        #x.split('=')[1].to_i

      else
        xs = x.map { |z| z.to_sym }
        xi = x.map { |z| z.to_i }

        k = xs.shift

        v = xs.size == 1 ? xi[1] : xs

        a[ k ] = v

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

      end
    }

    ben {
      @r = run a
    }
  end

  def run a
    #err :a, a
  
    a = a.first

    i = Icc.new a, 3

    #def a.[](i)
    #  err :oor, i if isi?(i) && i < 0
    #  super(i) || 0
    #end

    c = {}

    play i, c

    out c, o: true

    c.select {
      |k, v|

      v == 2

    }.size
  end

  def play i, c

    a = nil

    loop do
      a = i.run

      break unless a && a.size == 3

      z = a.shift 2
      v = a.shift

      ass :z, z, v, z.size == 2, (0..4).include?(v)
    
      c[z] = v
    end

    #ass :play, a, a.empty?
  end

  def out c, **h
    w = []

    c.each {
      |k, v|

      ass :k, k, :v, v, (0..4).include?(v)

      w[v] ||= []
      w[v] << k
    }

    deb :q, w

    w.map! {
      |g|

      #err :g, g

      g ? g : []
    }

#    err :w, w.first(3)

    super(*w.first(3), **h)
  end
end

class Icc
  def initialize a, n #, l = 0

    def a.[](i)
      err :oor, i if isi?(i) && i < 0
      super(i) || 0
    end

    @a = [a, 0]
    @r = 0
    @n = n

    # run
    #loop {

  end

  def run a = @a, n = @n

    r = amp a, [], n

    deb :run, r

    r
  end

  def amp a, g, n, o = []

    loop {
      a[1] = play(*a, g, o)

      break if o.size >= n

      return if a[1].nil?
    }

    ass :amp, o.size, o.size == n

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
