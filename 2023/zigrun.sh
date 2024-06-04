#!/usr/bin/env zsh

set -xe
set -o pipefail

# Fx workaround

export LD_LIBRARY_PATH="/usr/lib64/llvm17/lib/"

###

con () {
  echo
  read "?--> Continue?" ||:
  clear
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
  D="$2"
  shift 2 ||:
  :
} || D=

[[ "$1" == '-h' ]] && {
  H="$1"
  shift ||:
  :
} || H=

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

[[ "$1" == '-o' ]] && {
  O="$1"
  shift ||:
  :
} || O=

[[ "$1" == '-x' ]] && {
  X="$1"
  shift ||:
  :
} || X=

[[ -n "$1" ]] && exit 2

###

s="${n}${p:+-$p}"

f="adventofcode${s}.zig"
l="out${s}.log"

[[ -n "$H" ]] && {
#  h=$(bc -q <<< "($(tput lines)/2)")
  h="$(tput lines)"
  H="| head -n $h"
#  H="| head -n ${h}"
}

ta=
/usr/bin/time --help &>/dev/null || ta='-l'

###

echo; echo
clear
set +x

while :; do
  [[ -n "$X" ]] || {
    cst "$f" " \
#        set -x
        { set -o pipefail; echo; echo; set -x } &>/dev/null; clear; \
        timeout ${t} time zig test $a $f 2>&1 $H \
          && exit

      " 2>&1 \
        | tee "$l"

#    set -x

    [[ -n "$V" ]] && {
      grep -qE "^\s*=> ${V}$" "$l" || {
        con
        continue
      }
    }
  }

  echo
  set -x

  R=
  ${tme} ${ta} zig run $aa $f -- "data${n}.txt" $D | tee "$l" && {
    R=$?
    { set +x ; } &>/dev/null
    echo "SUCCESS: $R"
  } || {
    R=$?
    { set +x ; } &>/dev/null
    echo "FAIL: $R"
  }

  [[ -n "$O" ]] && exit $R
  con
done
