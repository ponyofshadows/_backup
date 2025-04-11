#!/bin/bash

wl-paste --watch bash -c 'c=$(wl-paste); if [[ $c =~ ^[a-zA-Z] ]]; then t=$(trans -b :zh "$c"); hyprctl notify 1 10000 "rgb(55FF55)" $"📖 $t"; else t=$(trans -b :en "$c"); hyprctl notify 1 10000 "rgb(55FF55)" $"📖 $t"; fi'

