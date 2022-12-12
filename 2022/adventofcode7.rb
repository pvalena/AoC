#!/usr/bin/env -S ruby

require_relative 'class'

class R

  def initialize
    # data
    a = \
    inp {
      |x, i|

      x
    }

    b = \
    Benchmark.measure {
      run a
    }

    deb :b, b.real
  end

  def run a
    # init
    d = { }
    t = d

    a.each {
      |q|

      break if q.empty?  

      t = play q, d, t
    }

    siz d

    dss :d, d

    @r = val d
  end

  def siz d
    s = 0

    d.each {
      |k,v|

      next if k == :u

      s += \
      if ish?(v)

        siz v

      else
        
        v.to_i

      end
    }

    d[:s] = s
    s
  end

  L = 100000

  def val d
    s = 0

    d.each {
      |k,v|

      next if k == :u

      s += \
      if ish?(v)

        val v

      end || 0
    }

    s += d[:s] if d[:s] <= L

    s
  end

  def play q, d, t

    m = q.shift

    if m == "$"

      c = q.shift

      #deb :c, c, q

      case c
        when 'cd'
          v = q.first

          if v == '/'
            t = d

          elsif v == '..'
            ass :t, t, t[:u]
            t = t[:u]

          else
            t[v] ||= {}
            t[v][:u] = t
            t = t[v]
          end

        when 'ls'
          
        else
          err :nyi, c, q
      end

    else 
      case m
        when 'dir'
        else
          t[q.first] = m
      end
    end

    t
  end

  def fin r
    r
  end

  def to_s
    r = fin @r
    r.to_s
  end   
end

#DEB = false

res R.new
