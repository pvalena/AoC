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

[[ "$1" == '-v' ]] && {
  V="$2"
  shift 2 ||:
  :
} || V=

###

a='-freference-trace'
aa="-OReleaseFast"

s="${n}${p:+-$p}"

f="adventofcode${s}.zig"
l="out${s}.log"

t=30

###

con () {
  read "?--> Continue?" ||:
}

###

set +x

while :; do
  cst -c "$f" "echo ; echo; clear; set -x ; timeout ${t} time zig test $a $f && exit" | tee "$l"

  [[ -n "$V" ]] && {
    echo

    grep -E "^\s*=> ${V}$" "$l" || {
      con
      continue
    }
  }

  echo
  set -x

  time zig run $aa $f -- "data${n}.txt" $X || echo FAIL

  { set +x ; } &>/dev/null
  con
done
