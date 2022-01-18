#!/usr/bin/zsh

set -e
zsh -n "$0"

cmd() {
  echo "time ${2} data${1}${3:+-t}.txt"
}

[[ "${1:0:2}" == '-n' ]] && {
  n="$2"
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

[[ -n "$t" ]] \
  && c="r=\"\$(`cmd $i $x $t` $n 2>&1 | tee -a /dev/stderr | grep '^=>' | cut -d' ' -f2-)\" && [[ \"$t\" == \"\$r\" ]]" \
  || c="echo -n"
t=
o="`cmd $i $x` $n"

echo "> $c"
echo ">> $o"

cst -c "$x" "ulimit -s 2097024 && $c && $o ; echo"
