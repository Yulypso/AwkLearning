#!/bin/bash

./vpn.awk "../Files/pe[1-4].txt"> vrfinventaire.txt
./vpn.sh
./vrfJoinToSage.awk "join_vrfinventaire.txt" > "sage_vrfinventaire.sage"
chmod +x sage_vrfinventaire.sage
./sage_vrfinventaire.sage