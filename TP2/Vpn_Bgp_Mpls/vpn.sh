#!/bin/bash

$(which cat) "vrfinventaire.txt" | $(which grep) "import" | $(which sort) -k3 > import.txt 
$(which cat) "vrfinventaire.txt" | $(which grep) "export" | $(which sort) -k3 > export.txt

$(which join) -13 -23 export.txt import.txt > join_vrfinventaire.txt