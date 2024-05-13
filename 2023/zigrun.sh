#!/usr/bin/env zsh

set -xe
set -o pipefail

###

con () {
  echo
  read "?--> Continue?" ||:
}

###

a='-freference-trace'
aa="-OReleaseFast"
t=60
tme=/usr/bin/time

###

n="$1"
shift ||:

[[ -n "$n" ]]

[[ "${1:0:1}" == '-' ]] || { p="$1"; shift ||: ;}

###

[[ "$1" == '-d' ]] && {
  X="$2"
  shift 2 ||:
  :
} || X=

[[ "$1" == '-h' ]] && {
  H="$1"
  shift ||:
  :
} || H=

[[ "$1" == '-s' ]] && {
  S="$1"
  shift ||:
  :
} || S=

[[ "$1" == '-v' ]] && {
  V="$2"
  shift 2 ||:
  :
} || V=

[[ "$1" == '-q' ]] && {
  a=
  aa=
  shift ||:
  :
}

[[ -n "$1" ]] && exit 2

###

s="${n}${p:+-$p}"

f="adventofcode${s}.zig"
l="out${s}.log"

[[ -n "$H" ]] && {
  h=$(bc -q <<< "($(tput lines)/2)")
  H="| head -n $h"
#  H="| head -n ${h}"
}

###

set +x

while :; do
  echo
  echo
  clear

  [[ -n "$S" ]] || {
    cst -c "$f" " \
        set -o pipefail; set -x ; \
        timeout ${t} time zig test $a $f 2>&1 $H \
      " \
        | tee "$l"

    [[ -n "$V" ]] && {
      grep -E "^\s*=> ${V}$" "$l" || {
        con
        continue
      }
    }
  }

  echo
  set -x

  ${tme} -l zig run $aa $f -- "data${n}.txt" $X | tee "$l" || echo "FAIL: $?"

  { set +x ; } &>/dev/null
  con
done
