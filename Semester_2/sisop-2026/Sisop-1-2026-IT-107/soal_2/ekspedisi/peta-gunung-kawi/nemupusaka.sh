#!/bin/bash

file="titik-penting.txt"

awk -F', ' '
BEGIN {
}
NR==1 {
    lat_min=lat_max=$3
    lon_min=lon_max=$4
}
{
    if ($3 < lat_min) lat_min = $3
    if ($3 > lat_max) lat_max = $3
    if ($4 < lon_min) lon_min = $4
    if ($4 > lon_max) lon_max = $4
}
END {
    pusat_lat = (lat_min + lat_max) / 2
    pusat_lon = (lon_min + lon_max) / 2
    
    printf "Koordinat: "
    printf "%.6f, %.6f\n", pusat_lat, pusat_lon
    printf "Koordinat: %.6f, %.6f\n", pusat_lat, pusat_lon > "posisipusaka.txt"
}' "$file"