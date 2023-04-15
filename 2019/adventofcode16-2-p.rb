#!/usr/bin/env -S ruby

DEB = false

require_relative 'class'

class R

  F = 'data.txt'

  def initialize

    File.write(F, '')

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
    #ass :a, af[0] == af[1], af

    o = (o..o+7).to_a

    dep b, as, n, c, o

#    o.shuffle!

#    err :b, b[n]

    w = b[n]

    o.map {
      |z|

      w[z]

    }.join
  end

  def shr v
    w = nil

    v.uniq.reject {
      |y|

      y << y.last if y.size < 2

#      f, t = y

#        ass :y, \
#          y.size == 2, \
#          y.size, f, t, f <= t

#      s = (f..t)

      unless w
        w = y
        next
      end

      err :y, w, y if inc(y, w)

      #err :inc, w, y unless inc(w, y)

      inc(w, y)
    }
  end

  def dep b, as, n, c, o, l = 1

    i = 0
    a = [[n, o]]
    q = n
    w = nil

    while q > l

#      w = nil if q > n-3

      o = \
      unless w
        v = \
        Parallel.map(o, in_processes: 4) {
          |c|

          shr play(b, as, q, c, l: l)

        }.reduce(:'+')

        v = shr v

        #err :n, v, o unless v.size == 1

        v = v[0]
        w = (v[0]..v[1])

      else

        w

      end

      q -= l

      #ass :qo, q, o.inspect, q <= 100 && q >= 0, o.size > 0

      deb :a, q, o, stm, l: true, o: true

      a << [q, o]
    end

    a.reverse.each {
      |q, o|

      w = b[q]

      unless w
        w = {}

        b[q] = w
      end

      #deb :o, q, o

      #err :a, b[1].size if q == 2

      #o = [o] if isi?(o)

#      ass :q, q, q <= n, o.inspect, isr?(o)

      z = \
      inparallel(o, in_processes: 4) {
        |c|

        play(b, as, q, c)

      }

      File.truncate(F, 0)

      File.open(F, File::WRONLY) {
        |f|

        f.puts 'q', q

        z.each {
          |v, c|

          w[c] = v

          f.puts c, v
        }
      }

      deb :w, q, o, w.size, stm, o: true, l: true
    }
  end

  def inc a, b
    a.first <= b.first && b.last <= a.last
  end

  S = [nil, true, nil, false]
  V = []

  def play a, as, n, i, l: nil, e: 5

    #ass :p, n, i, e, isi?(i, n), l: true

    n -= 1
    i += 1

    v = 0
    j = 0
    f = true

    sam i, :play, n, l, w.size if DEB

    x = []

    # Prepare
    while j < as

      S.each {
        |s|

        unless s.nil?

          x << [s]
          y = x.last
          z = nil

          i.times {

            if f
              f = false
              next
            end

            if z || y.size >= 2

              z = j

            else

              y << j

            end

            j += 1

            break if j >= as
          }

          y << z if z

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

    x.delete [nil]
    #x.shuffle!    # if l

    #ass :x, x.size > 0

    if l
      l -= 1

      #deb :l, n, l, x.size

      if l <= 0
        x.each { |y| y.shift }
        return x
      end
    end


    w = a[n]

    unless w
      w = {}

      a[n] = w
    end


    # Check
    v = 0
    x.each {
      |y|

      y << y.last if y.size < 3

      s, f, t = y

      o = (f..t)

      o.each {
        |j|

        z = w[j]

        unless z
          deb :g, n, i, j, o: true, l: true

          z = play a, as, n, j, l: l

          w[j] = z
        end

        z = -z if s
        v += z
      }
    }

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
