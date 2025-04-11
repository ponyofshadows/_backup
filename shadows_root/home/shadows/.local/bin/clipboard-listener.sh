#!/bin/bash
wl-paste --watch bash -c 'c=$(wl-paste | tr -d "\n"); 
if [[ $c =~ ^[a-zA-Z] ]]; then 
  t=$(curl -s -X POST http://localhost:5000/translate -H "Content-Type: application/json" -d "{\"q\": \"$c\", \"source\": \"en\", \"target\": \"zh\"}" | jq -r ".translatedText");
  hyprctl notify 6 15000 "rgb(55FF55)" $"📖 $(echo $t | fold -w 40)"; 
else 
  t=$(curl -s -X POST http://localhost:5000/translate -H "Content-Type: application/json" -d "{\"q\": \"$c\", \"source\": \"zh\", \"target\": \"en\"}" | jq -r ".translatedText");
  hyprctl notify 6 15000 "rgb(55FF55)" $"📖 $(echo $t | fold -w 40)"; 
fi'
