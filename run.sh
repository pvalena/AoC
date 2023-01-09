#!/usr/bin/env zsh

set -e
zsh -n "$0"

export RUBYOPT='--jit'
export RUBY_THREAD_VM_STACK_SIZE=15000000

u="ulimit -s"
l=2097024
m=

#
# 1: command
# 2: task nr
# 3: testing
# 4..: extra args
#
# SLP = sleep ?
#
SLP=0
cmd () {
  : "cmd: $1 $2 $3 $4"
  local q="${1} data${2}${3:+-t}.txt ${4} ${5} ${6} ; echo ; sleep ${SLP}"

  [[ -z "$m" ]] || {
    q="time { ${q}; }"
  }

  echo "{ $q; }"
}

[[ "${1:0:2}" == '-d' ]] && {
  DEBUG="$1"
  set -x
  shift
  :
} || DEBUG=

[[ "${1:0:2}" == '-n' ]] && {
  n="$2"
  shift 2
  :
} || n=

[[ "${1:0:2}" == '-p' ]] && {
  f="$2"
  shift 2
  :
} || f=adventofcode

[[ "${1:0:2}" == '-s' ]] && {
  SLP="$2"
  shift 2
  :
} || SLP=1

[[ "${1:0:2}" == '-t' ]] && {
  t="$2"
  shift 2
  :
} || t=

: "opts: n=$n f=$f t=$t"

i=${1:-}
p=${2:-}

: "args: i=$i p=$p"

x="./${f}${i}${p:+-$p}.rb"

[[ -r "$x" ]] || exit 7
[[ -x "$x" ]] || chmod +x "$x"

[[ -n "$t" ]] \
  && c="r=\"\$(`cmd $x $i ${t:-''} $n` 2>&1 | tee -a /dev/stderr | { grep '^=>' | cut -d' ' -f2-} 2>/dev/null )\" && [[ \"$t\" == \"\$r\" ]] && echo" \
  || c="echo -n"
t=
o="`cmd $x $i '' $n`"

echo "> $c"
echo ">> $o"

zsh -c "set -x; $u $l" || {
  l=65520
  zsh -c "set -x; $u $l"
}

# ineffective
#while [[ $l -gt 2 ]]; do
#  zsh -c "set -x; $u $l" && break
#
#  let "l = $l / 2"
#done

cst -c "$x" "${DEBUG:+set -x;} $u $l && $c && $o"
