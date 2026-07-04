#!/usr/bin/env bash

if pgrep -x "$(basename "$0")" | grep -v -w $$ > /dev/null; then
    exit 0
fi

official=$(checkupdates 2>/dev/null | wc -l)
aur=$(yay -Qua 2>/dev/null | grep -F "->" | grep -v "Flagged Out Of Date" | wc -l)

total=$(( official + aur ))

css="updates"
(( total > 25 )) && css="warning"
(( total > 100 )) && css="urgent"

if (( total > 0 )); then
    printf '{"text":"%d","alt":"%d","tooltip":"%d updates","class":"%s"}\n' \
           "$total" "$total" "$total" "$css"
else
    printf '{"text":"0","alt":"0","tooltip":"no updates","class":"green"}\n'
fi
