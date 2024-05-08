#!/usr/bin/env zsh

set -xe

n="$1"
shift ||:

[[ -n "$n" ]]

[[ "${1:0:1}" == '-' ]] || { p="$1"; shift ||: ;}

#####

[[ "$1" == '-d' ]] && {
  X="$2"
  shift 2 ||:
  :
} || X=

a='-freference-trace'
#a="${a} -OReleaseFast"

f="adventofcode${n}${p:+-$p}.zig"

t=30

exec cst -c "$f" \
  "set -x ; echo ; echo; clear; zig test $a $f && timeout ${t} zig run $a $f -- data${n}.txt $X"
