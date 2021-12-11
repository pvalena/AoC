#!/usr/bin/bash

ruby -ne 'BEGIN { D=true; r=nil; i=0; d=0; ii=0; } ; c=$_.chomp.to_i; p [r,c,(r.to_i < c)] if D; ii+=1 unless (r.to_i >= c || r.nil?) ; if r.to_i > c; d+=1; else i+=1 unless r.to_i==c ; end unless r.nil? ; r=c ; END { p "inc: #{i}, dec: #{d}, iinc: #{ii}"; } ' \
  < data.txt

r=; while read c; do [[ -n "$r" && "$c" -gt "$r" ]] && echo "$c"; r="$c"; done < 'data.txt' | wc -l
