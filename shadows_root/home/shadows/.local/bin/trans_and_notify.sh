#!/bin/bash
# required by clipboard-listener.sh
wl-paste
c=$(wl-paste | sed 's/-$//' | tr -d "\n\r" | sed "s/^[[:space:]]*//" | tr -d "\000-\037\177")
echo "$c"

if [[ $c =~ ^[a-zA-Z] ]]; then 
  t=$(curl -s -X POST http://localhost:5000/translate \
    -H "Content-Type: application/json" \
    -d "$(jq -n --arg q "$c" --arg src "en" --arg tgt "zh" \
      "{q: \$q, source: \$src, target: \$tgt}")" \
    | jq -r ".translatedText")
  msg="📖 $(echo "$t" | grep -oE '.{1,40}')"
  hyprctl notify 6 15000 0 "$msg"
elif [ -z "$c" ]; then
  :
else
  t=$(curl -s -X POST http://localhost:5000/translate \
    -H "Content-Type: application/json" \
    -d "$(jq -n --arg q "$c" --arg src "zh" --arg tgt "en" \
      "{q: \$q, source: \$src, target: \$tgt}")" \
    | jq -r ".translatedText")
  msg="📖 $(echo "$t" | grep -oE '.{1,40}')"
  hyprctl notify 6 15000 0 "$msg"
fi
