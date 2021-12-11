#!/usr/bin/ruby

require 'ap'
alias :p :pp

DEB = true

def d *i
  if DEB
    p (i.size == 1 ? i[0] : i)
    puts
  end
end

def e
  exit
end

# Data Load
dat = ARGF.readlines
  .map {
    |l|
    l = l.chomp.split(?|)
      .map{
        |x|
        x.split
        #.map { |z| z }
      }
  }

puts

C = [
   [:a, :b, :c, :e, :f, :g],
   [:c, :f],
   [:a, :c, :d, :e, :g],
   [:a, :c, :d, :f, :g],
   [:b, :c, :d, :f],
   [:a, :b, :d, :f, :g],
   [:a, :b, :d, :e, :f, :g],
   [:a, :c, :f],
   [:a, :b, :c, :d, :e, :f, :g],
   [:a, :b, :c, :d, :f, :g]
]

class RL
  def d *i
    if DEB
      p (i.size == 1 ? i[0] : i)
      puts
    end
  end

  def nm
    return @nm if @nm

    @nm = {
        a: @e.dup,
        b: @e.dup,
        c: @e.dup,
        d: @e.dup,
        e: @e.dup,
        f: @e.dup,
        g: @e.dup
      }

    def @nm.r
      return @r if @r

      @r = []
    end

    def @nm.q v
      v.split('')
        .map! {
          |w|
          w.to_sym
        }
        .sort
    end

    def @nm.i x, v, n
      v = q v if v.kind_of?(String)
      v.sort!

      ass 'nm.i:xv', x, v, n, x.size == v.size

      r[n] = v unless r[n]

      (r[8] - x).each do
        |z|
        self[z] -= v
      end

      x.each do
        |z|
        self[z] = \
        self[z].select {
          |m|
          v.include? m
        }
      end
      n
    end

    def @nm.u
      return @u if @u

      @u = {}
    end

    def @nm.e x, v
      v = q v

      u[v.size] ||= []
      u[v.size] << v unless u[v.size].include? v

      v
    end

    def @nm.ass(*a)
      a.each {
        |z|
        abort "Abort: #{a.inspect}" unless z

      } if DEB
    end

    def @nm.df a,b
      ((a - b) + (b - a))
    end

    def @nm.s x, a, b
      return false unless a && b

      v = df(a, b)

      ass 'nm.s:v', a, b, v, v.size == 1
      v = v[0]

      ass 'nm.n:x', x, x.kind_of?(Symbol)
      ass 'nm.n:v', v, v.kind_of?(Symbol)

      self[x] = [v]
    end

    def @nm.c
      unless @c
        @c = Hash.new {
          |h, (l, v)|

          self.keys.each {
            |i|
            unless i == l
              self[i] -= v if self[i].include? v[0]

              ass 'nm.c:r', i, v, l, !self[i].empty?

            else
              ass 'nm.c:c', i, self[i], v, self[i].one?, self[i] == v

            end
          }
        }
      end

      keys.each {
        |x|

        @c[[x, self[x]]] if self[x].one?
      }
    end

    @nm
  end

  def nr
    return @nr if @nr

    @nr = Hash.new {
      |h, v|
      case
        when !v.kind_of?(String)
          v

        when v.size == 2
          nm.i( [:c, :f], v, 1 )

        when v.size == 4
          nm.i( [:b, :c, :d, :f], v, 4 )

        when v.size == 3
          nm.i( [:a, :c, :f], v, 7 )

        when v.size == 7
          nm.i( @e, v, 8 )

        when v.size == 5
          # 2 3 5
          nm.e( [:a, :c, :g], v )

        when v.size == 6
          # 0 6 9
          nm.e( [:a, :b, :f, :g], v )

        else
          abort
      end
    }

    @nr
  end

  def ass(*a)
    a.each {
      |z|
      abort "Abort: #{a.inspect}" if z.nil?
    } if DEB
  end

  def initialize a
    @e = [:a, :b, :c, :d, :e, :f, :g]

    nr[ @e.map{ |n| n.to_s }.join ]

    # Data process
    a.map! {
      |x|

      x.map! {
        |y|
        nr[y]
      }
    }

    @v = a[1]

    d 'nm.u', nm.u
    #.reject { |x| x.nil? }

    1.upto(1000) do
      |i|
      nmd = nm.dup
      nmrd = nm.r.dup

      # 2 3 5
      u = nm.u[5]
      unless nm.r[3] && !( nm.r[1] || nm.r[7] )
        g = \
        u.detect {
          |z|
          x = (nm.r[1] ? 1 : 7)

          nm.r[x].all? {
            |v|
            z.include? v
          }
        }

        if g
          nm.r[3] = g
        end
      end

      if u.size >= 2
        #d 'u1', nm.df(u[0], u[1])

        if u.size >= 3
         # d 'u2', nm.df(u[0], u[2])
          #d 'u3', nm.df(u[1], u[2])
        end
      end

      # 0 6 9
      w = nm.u[6]
      unless nm.r[6] && !( nm.r[1] || nm.r[7] )
        g = \
        w.detect {
          |z|
          x = (nm.r[1] ? 1 : 7)

          !nm.r[x].all? {
            |v|
            z.include? v
          }
        }

        nm.i( [:a, :b, :d, :e, :f, :g], g, 6 ) if g
      end

      nm.s( :a, nm.r[7], nm.r[1] ) unless nm[:a].one?
      nm.s( :d, nm.r[8], nm.r[0] ) unless nm[:d].one?
      nm.s( :c, nm.r[8], nm.r[6] ) unless nm[:c].one?
      nm.s( :e, nm.r[5], nm.r[6] ) unless nm[:e].one?
      nm.s( :e, nm.r[9], nm.r[8] ) unless nm[:e].one?

      unless nm[:g].one? or nm.r[4].nil? or !nm[:a].one?
        g = (nm.r[4] + nm[:a])
        nm.s( :g, g, nm.r[9] )
      end

      bd = \
      unless nm.r[1].nil? or nm.r[4].nil?
        nm.r[4] - nm.r[1]
      end

      eg = \
      unless nm.r[4].nil? or !nm[:a].one?
        nm.r[8] - (nm.r[4] + nm[:a])
      end

      unless (nm[:d].one? and nm[:b].one?) or bd.nil? or (nm.r[2].nil? and nm.r[3].nil?)
        x = ( nm.r[2] ? 2 : 3 )

        g = \
        bd.detect {
          |b|
          nm.r[x].include? b
        }

        if g
          g = [g]
          b = bd - g

          nm[:b] = b unless nm[:b].one?
          nm[:d] = g unless nm[:d].one?
        end
      end

      unless (nm[:e].one? and nm[:g].one?) or eg.nil? or (nm.r[9].nil? and nm.r[5].nil? and nm.r[3].nil?)
        x = nm.r[9] ? 9 : ( nm.r[3] ? 3 : 5 )

        g = \
        eg.detect {
          |b|
          nm.r[x].include? b
        }

        if g
          g = [g]
          e = eg - g

          nm[:e] = e unless nm[:e].one?
          nm[:g] = g unless nm[:g].one?
        end
      end

      unless nm.r[2] or nm.r[3].nil? or !(nm[:e].one? and nm[:f].one?)
        g = nm.r[3] + nm[:e] - nm[:f]
        nm.i( [:a, :c, :d, :e, :g], g, 2 )
      end

      unless nm.r[5] or nm.r[9].nil? or !nm[:c].one?
        d 'five'
        g = nm.r[9] - nm[:c]
        nm.i( [:a, :b, :d, :f, :g], g, 5 )
      end

      unless nm.r[0] or nm.r[8].nil? or !nm[:d].one?
        g = nm.r[8] - nm[:d]
        nm.i( [:a, :b, :c, :e, :f, :g], g, 0 )
      end

      unless nm.r[9] or nm.r[8].nil? or !nm[:e].one?
        g = nm.r[8] - nm[:e]
        nm.i( [:a, :b, :c, :d, :f, :g], g, 9 )
      end

#      unless nm.r[9] or nm.r[5].nil? or !nm[:c].one?
#        g = nm.r[5] + nm[:c]
#        nm.i( [:a, :b, :c, :d, :f, :g], g, 9 )
#      end

      unless nm.r[5] or nm.r[6].nil? or !nm[:e].one?
        g = nm.r[6] - nm[:e]
        nm.i( [:a, :b, :d, :f, :g], g, 5 )
      end

      unless nm.r[6] or nm.r[5].nil? or !nm[:e].one?
        d 'six'
        g = nm.r[5] + nm[:e]
        nm.i( [:a, :b, :d, :e, :f, :g], g, 6 )
      end

      nm.c

      if nm == nmd && nm.r == nmrd
        d 'same', i
        break
      end
    end

    d 'nm', nm

    if DEB
      nm.r.each_with_index {
        |x, i|
        puts "#{i}: #{x}" if x

      }
      puts

      nm.r.each_with_index {
        |x, i|
        z = x.map {
          |q|
          nm.key([q])

        }.sort if x
        #puts "#{i}: #{z}," if z
        ass 'check', i, z, '==', C[i], z == C[i] if z
      }
    end

    @v.map! {
      |z|
      if z.kind_of?(Numeric)
        z
      else
        v = z.map {
          |q|
          nm.key([q])

        }.sort

        i = nm.r.index(z)

        ass 'N/A', z, '->', v, i
        i
      end
    }
  end

  def to_s
    @v.join.to_s
  end

  def to_i
    self.to_s.to_i
  end
end

dat.map! do
  |x|

  d '========================================================='
  system 'clear'

  d x.each {
    |z|
    z.each {
      |y|

      y.split('').sort.join

    }.sort
  }

  r = RL.new(x)

  r.to_i
end

d dat

p dat.sum

p dat.inject(0) {
    |s, l|
    s + l
  }
