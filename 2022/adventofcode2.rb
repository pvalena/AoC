#!/usr/bin/env -S ruby

require_relative 'class'

class R

  def initialize
    # data
    a = \
      inp() {
        |x, i|

        x.to_sym
      }

    b = \
    Benchmark.measure {
      run a
    }

    deb :b, b.real
  end

  def run a
    # init
    s = 0

    # loop
    a.each {
      |m|

      begin
        s += play *m

        rescue
            err :run, m
      end
    }

    @r = s
  end

  def play o, m

    m, o = tra(m), tra(o)

    deb :play, m, o

    win(m, o) + score(m)
  end

  def tra x
    case x
      when :A, :X; :rock
      when :B, :Y; :paper
      when :C, :Z; :scissors
      else
        err :tra, x
    end    
  end

  def win x, y
    case
       when x == y; 3

       when beats(x, y); 6

       else 0
    end
  end

  def beats x, y
    case x
      when :rock;     y == :scissors
        
      when :paper;    y == :rock
        
      when :scissors; y == :paper
    end
  end

  def score x
    case x
      when :rock;     1
      when :paper;    2
      when :scissors; 3
      else
        err :score, x
    end
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
