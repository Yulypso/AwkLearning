#!/bin/bash

./perimeter.awk "../Files/r[1-6].txt" > perimeter.txt
./perimeter.sh > sorted_perimeter.txt
./perimeterToSage.awk "sorted_perimeter.txt" > "perimeter.sage"
chmod +x perimeter.sage
./perimeter.sage

rm bgp-as.gv
rm perimeter.txt
rm sorted_perimeter.txt
rm perimeter.sage
rm perimeter.sage.py