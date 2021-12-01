#!/bin/bash

/bin/cat "vrfinventaire.txt" | /usr/bin/grep "import" | /usr/bin/sort -k3 > import.txt 
/bin/cat "vrfinventaire.txt" | /usr/bin/grep "export" | /usr/bin/sort -k3 > export.txt

join -13 -23 export.txt import.txt > join_vrfinventaire.txt