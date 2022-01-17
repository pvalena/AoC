#!/usr/bin/zsh

set -e
zsh -n "$0"

cmd() {
  echo "time $x data${1}${3:+-t}.txt $2"
}

[[ "${1:0:2}" == '-n' ]] && {
  n="${2}"
  shift 2
  :
} || n=

[[ "${1:0:2}" == '-t' ]] && {
  t="$2"
  shift 2
  :
} || t=

i=${1:-}
p=${2:-}

x="./adventofcode${i}${p:+-$p}.rb"

[[ -n "$t" ]] && c="r=\"\$(`cmd $i $x $t` 2>&1 | tee -a /dev/stderr | grep '^=>' | cut -d' ' -f2-)\" && [[ \"$t\" == \"\$r\" ]]"
t=
o="`cmd $i $x`"

echo "> $c ; $o"

cst -c "$x" "ulimit -s 2097024 && $c && $o ; echo"
