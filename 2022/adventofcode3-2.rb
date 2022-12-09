#!/usr/bin/env -S ruby

require_relative 'class'

class R

  def initialize
    # data
    a = \
      inp() {
        |x, i|

        to_sym x
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
    f = []
    fi = []

    # loop
    a.each_with_index {
      |m, mi|

      next if fi.include? mi

      a.each_with_index {
        |n, ni|

        next if m == n
        next if fi.include? ni

        z = m & n

        next if z.empty?
        
        a.each_with_index {
          |o, oi|

          next if o == n || o == m
          next if fi.include? oi

          q = o & z

          next unless q.size == 1

          f << q.first
          fi += [mi, ni, oi]
          break
        }

        break if fi.include? mi

      }

    }

    @r = f
  end

  VAL = (:a .. :z).to_a + (:A..:Z).to_a

  def prio x
    ass :prio, x, VAL.include?(x), VAL

    VAL.find_index(x) + 1
  end

  def fin r
    r.map { |z| prio(z) }.sum
  end

  def to_s
    r = fin @r
    r.to_s
  end   
end

#DEB = false

res R.new
