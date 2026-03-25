#!/bin/bash

echo "haik, wakarimasta. Lagi process membaca gsxtrack.json dan dipindah ke titik-penting.txt"

jq -r '.features[] | "\(.id), \(.properties.site_name), \(.properties.latitude), \(.properties.longitude)"' gsxtrack.json > titik-penting.txt

echo "Kelar wak. udh selesai dipindah ke titik-penting.txt"