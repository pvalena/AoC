#!/usr/bin/env -S ruby

#DEB = false

require_relative 'class'

class R

  def initialize

#    @s = arg.to_i

    a = {}
    n = nil
    s = false

    #a = \
    inp(s: s) {
      |x, i|

      #err :inp, x

      xs = x.map { |z| z.to_sym }
      xi = x.map { |z| z.to_i }

      k = xs.shift

      v = xs.size == 1 ? xi[1] : xs

      a[ k ] = v

      #err :a, a, k, xs

      unless true
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
      #to_sym x
      #(to_i x.split(?,))
      #x.to_i
    }

    ben {
      @r = run a.freeze
    }
  end

  def run a

    a = a.dup

    #err :a, a[:humn]

    a[:root][1] = :'='
    a[:humn] = [nil, :'?', nil]

    b = \
      hsh {
        |h, i|

        unless i.nil?
          ass :hsh, i, a[i]

          f, o, s = a[i]

          g = [ h[f], h[s] ]

          z = nil

          (g[0] = f; z = true) unless isi? g[0]
          (g[1] = s; z = true) unless isi? g[1]

          case o
            when :'='
              g

            when :'?'
              #err :'?', g
              nil

            else
              if z
                g.insert(1, o)

              else
                g.reduce o

              end
          end
        end
      }

    a.reject! {
      |k, v|

      unless v.respond_to? :each

        b[k] = v

      end
    }

    r = b[:root]

    q = (r[0].kind_of? Integer) ? 0 : 1
    n = r[q]
    q = r[ (q + 1) % 2 ]

    dss :run, q, n

    #inloop a, b

    b[:humn] = a[:humn]

    ser b, n, q
  end

  def ser b, v, q

    #err :h, b[q], v, q if q == :humn

    l, o, r = b[q]

    li = l.kind_of? Integer

    if li
      n, q = l, r
    else
      n, q = r, l
    end

    v = \
    case o
      when :'+'
        v - n

      when :'-'
        if li
          n - v
        else
          v + n
        end

      when :'/'
        if li
          n / v
        else
          v * n
        end

      when :'*'
        v / n

      when :'?'
        return v

      else
        err :NYI, o, l, r, n, q

    end

    dss :ser, n, q, v

    ser b, v, q
  end

  def inloop a, b

    c = []
    i = 0
    as = a.size
  
    loop {
      x = i % as
      r = play a[x], b, as

      #c << val(b, as) if T.include?( i )

      i += 1

      break if i >= as
    }

    val b, as
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
