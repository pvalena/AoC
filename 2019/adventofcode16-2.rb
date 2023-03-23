#!/usr/bin/env -S ruby

DEB = false

require_relative 'class'

class R
  def initialize

    puts
    @a = arg

    n, s, g, t = nil
    #n = false
    #s = false
    #g = false
    #t = false

    ii = 0
    j = nil
    a = {}
    a = \
    inp(n, s, g, t) {
      |x, i|

      if true        
        #eval x
        #x.to_i
        #to_sym(x)

        #err :inp, x, @a

        x.split('').map(&:to_i)

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
      @run = run a
    }
  end

  N = 10_000.freeze

  def pat a
    def a.[](q, *k, **g)
      if k.empty? and g.empty? and q.kind_of?(Integer)

        z = q % @@l

        #err :super, z, q

        return super(z) #or k == 1
      end

      super(q, *k, **g)
    end
  end

  def run a

    a = a.first
    @@l = a.size

    @@q = N / 10
    #@@r = 3

    as = N * @@l
    o = a.first(7).join.to_i
    n = @a || 100


    b = [a]
    c = []

    af = [ a.first(@@l) ]

    pat a

    af << \
    (@@l...(@@l*2)).inject([]) {
      |b, w|

      b << a[w]
    }

    af.map!(&:join)

    #err :af, af[1], @@l: true

    deb :run, n, o, @@l, as, l: true, o: true
    ass :a, af[0] == af[1], af

    o = (o..o+7).to_a

    o.map! {
      |c|

      play(b, as, n, c)
    }

#    w.map!(&:reverse).sort!.map! { |(_, x)| x }

    o.join
  end

  def dep b, as, n, c, m, r, u, o, l = 1

    i = 0
    a = []
    q = n

    while q > l

      #deb :o, l, q, o, l: true, o: true

      v = []
      o.each {
        |c|

        v += play(b, as, q, c, m, r, u, l: l)
      }

      w = nil
      v.reject! {
        |y|

        y << y.last if y.size < 2

        f, t = y

        ass :y, \
          y.size == 2, \
          y.size, f, t, f <= t

        s = (f..t)

        unless w
          w = s
          next
        end

        err :s, w, s if inc(s, w)

        err :w1, w, s unless w.include?(s)
        err :w2, w, s unless inc(w, s)

        w.include?(s)
      }

      #deb :dv, q, v.size, v, l: true, o: true

      q -= l

      a << [q, v]

      err :o, v, o unless v.one?

      v = v[0]

      o = (v[0]..v[1])
    end

    a.reverse.each {
      |q, v|

      v = v[0]

      o = (v[0]..v[1])

      o.to_a.shuffle!

      o.each {
#      inparallel(o) {
        |c|

        play(b, as, q, c, m, r, u)
      }
    }
  end

  def inc a, b
    a.first <= b.first && b.last <= a.last
  end

  S = [nil, true, nil, false]
  V = []

  def play a, as, n, i

    n -= 1
    i += 1

    w = a[n]

    unless w
      w = {}

      a[n] = w
    end

    v = 0
    j = 0
    f = true

    sam(i, :play, n, w.size)

    # Prepare
    while j < as

      S.each {
        |s|

        unless s.nil?

          i.times {

            if f
              f = false
              next
            end

            z = w[j]

            unless z
              z = play a, as, n, j

              w[j] = z
            end

            z = -z if s

            v += z

            j += 1

            break 2 if j >= as
          }

        else
          j += i

          if f
            j -= 1
            f = false
          end
        end

        break if j >= as
      }
    end

    v.abs % 10
  end

  def sam i, *z, q: @@q #, r: @@r

    super(i, q: q) {
      |y|

      if y < 10

        #deb :q, i, q, r, i % (q * 10), o: true, l: true

        if i % (q * 10) == 0
          @@q *= 10
        else
          @@q *= 2 if i % (q * 2) == 0
        end

      elsif y > 100

        @@q /= 10 unless q <= 1 || i % (q / 10) != 0

      end

      z
    }
  end
end

res
