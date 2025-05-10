#!/bin/bash
# required by clipboard-listener.sh
set -e
c=$(wl-paste)
[ -n "$c" ]
c=$(echo "$c" | awk 'NR==1{sub(/^[[:space:]]+/, "")} {if (/-$/){sub(/-$/,""); printf "%s", $0} else {printf "%s ", $0}}' | tr -d "\r" | tr -d '\000-\037\177')
if [[ ! $c =~ [一-龥] ]]; then
  t=$(curl -s -X POST http://localhost:5000/translate \
    -H "Content-Type: application/json" \
    -d "$(jq -n --arg q "$c" --arg src "en" --arg tgt "zh" \
      "{q: \$q, source: \$src, target: \$tgt}")" \
    | jq -r ".translatedText")
  msg="🆎→🀄 $(echo "$t" | grep -o -P '.{1,20}')"
  hyprctl notify 6 15000 "rgb(FF99CC)" "$msg"
else
  t=$(curl -s -X POST http://localhost:5000/translate \
    -H "Content-Type: application/json" \
    -d "$(jq -n --arg q "$c" --arg src "zh" --arg tgt "en" \
      "{q: \$q, source: \$src, target: \$tgt}")" \
    | jq -r ".translatedText")
  msg="🆎→🀄 $(echo "$t" | grep -o -P '.{1,20}')"
  hyprctl notify 6 15000 "rgb(FF99CC)" "$msg"
fi
