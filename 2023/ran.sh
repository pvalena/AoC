#!/usr/bin/env zsh

set -xe

[[ "$1" == "-r" ]] && {
  shift||:
  r="$1"
  :
} || r=

[[ "$1" == "-n" ]] && {
  shift||:
  n="$1"
  :
} || n=

[[ -n "$1" ]]
d="$1"
shift||:

[[ -n "$1" ]]
s="$1"
shift||:

[[ -n "$1" ]]
e="$1"
shift||:


[[ -n "$r" ]] && {
  x=$(($e - $s))

  o=$e

  s=0
  e=$x
  :
} || o=

for i in {$s..$e}; do

  [[ -n "$r" ]] \
    && j=$(($o - $i)) \
    || j=$i

  [[ -n "$n" ]] || clear

  echo -e "\n\n>>> $j"; set -x

  time ./adventofcode${d} data${d}.txt "$j" && break

  { set +x; } &>/dev/null
done

{ set +x; }&>/dev/null
