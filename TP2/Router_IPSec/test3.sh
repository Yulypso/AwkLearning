#!/bin/bash

./ipsec.awk "../Files/conf[1-4].txt" > ipsec.txt
./ipsec.sh > sorted_ipsec.txt
./sorted_ipsec.awk "sorted_ipsec.txt" > ipsec_graph.txt
./ipsecToSage.awk "ipsec_graph.txt" > ipsec.sage
chmod +x ipsec.sage
./ipsec.sage

rm ipsec.gv
rm ipsec.sage.py
rm ipsec.txt
rm sorted_ipsec.txt
rm ipsec_graph.txt
rm ipsec.sage