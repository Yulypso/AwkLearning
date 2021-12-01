#!/bin/bash

./vpn.awk "../Files/pe[1-4].txt"> vrfinventaire.txt
./vpn.sh
./vrfJoinToSage.awk "join_vrfinventaire.txt" > "sage_vrfinventaire.sage"
chmod +x sage_vrfinventaire.sage
./sage_vrfinventaire.sage

rm vpn-bgp-mpls.gv
rm export.txt
rm import.txt
rm vrfinventaire.txt
rm join_vrfinventaire.txt
rm sage_vrfinventaire.sage.py
rm sage_vrfinventaire.sage
