#!/bin/bash

file="kantin.log"

menu=("Nasi" "Kopi" "Teh" "Roti" "Ayam")

random_index=$(( RANDOM % 5 ))

pesanan=${menu[$random_index]}

echo ""Membeli: $pesanan""

# awk -v min=0 -v max=4 'BEGIN{srand(); print int(min+rand()*(max-min+1))}' (harusnya ini) -> https://unix.stackexchange.com/questions/140750/generate-random-numbers-in-specific-range
