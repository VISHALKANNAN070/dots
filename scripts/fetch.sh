#!/bin/sh
clear
read -r kernel < /proc/sys/kernel/osrelease
. /etc/os-release
while read -r line; do
    [ "${line#exec }" = "$line" ] || wm="${line#exec }"
done < "$HOME/.xinitrc"

c0="\033[0m"
c1="\033[37m"

cols=$(tput cols)
pad=$(printf '%*s' $(( (cols - 42) / 2 )) '')

printf "%b" "
${pad}${c1}        
${pad}${c1}os      ${PRETTY_NAME}
${pad}${c1}kernel  ${kernel}
${pad}${c1}shell   ${SHELL##*/}
${pad}${c1}wm      ${wm##*/}
${c0}
${c0}
${c0}
"

