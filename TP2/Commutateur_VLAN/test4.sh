#!/bin/bash

./commutateurVLAN.awk "../Files/cat[1-4].txt" > data.txt
./prepare_data.awk "data.txt" > VLAN.txt
./sorted_VLAN.sh > sorted_VLAN.txt
./prepare_edges.awk "sorted_VLAN.txt" > commutateurVLAN.txt
./commutateurVLANToSage.awk "commutateurVLAN.txt" > commutateurVLAN.sage
chmod +x commutateurVLAN.sage
./commutateurVLAN.sage

rm *.gv
rm *.py
rm *.txt
rm *.sage