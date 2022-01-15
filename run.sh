#!/usr/bin/zsh

set -e
zsh -n "$0"

[[ "${1:0:2}" == '-n' ]] && {
  n="${2}"
  shift 2
  :
} || n=

[[ "${1:0:2}" == '-t' ]] && {
  t="${1:1}"
  shift
  :
} || t=

i=${1:-}
p=${2:-}

x="./adventofcode${i}${p:+-$p}.rb"

cst -c "$x" "ulimit -s 2097024 && time $x data${i}${t:+-$t}.txt $n; echo"
