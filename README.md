# RichAwk

## Author

[![Linkedin: Thierry Khamphousone](https://img.shields.io/badge/-Thierry_Khamphousone-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/tkhamphousone/)](https://www.linkedin.com/in/tkhamphousone)

---

<br/>

## Setup

```bash
$ git clone https://github.com/Yulypso/RichAwk.git
$ cd RichAwk

# required libraries
$ sage --pip install graphviz
```

---

<br/>

## Languages

- AWK
- Bash
- Sage
- Flex / Bison

---

<br/>

## Run Awk/Gawk scripts

### TP1

```bash
$ cd TP1
$ ./Router/test1.awk ./Files/router.unix
$ ./Router/test2.awk ./Files/router.unix
$ ./Router/test3.awk ./Files/router.unix
$ ./Router/test4.awk ./Files/router.unix
$ ./Router/test5.awk ./Files/router.unix
$ ./Catalyst/test6.awk ./Files/cat[1-3].unix
$ ./Catalyst/test7.awk ./Files/cat[1-3].unix
$ ./IPSec/test8.awk ./Files/conf[1-3].unix
$ ./IPSec/test9.awk ./Files/conf[1-3].unix
```

### TP2

```bash
$ cd ./TP2/Vpn_Bgp_Mpls
$ ./test1.sh

$ cd ./TP2/Bgp_As
$ ./test2.sh

$ cd ./TP2/Router_IPSec
$ ./test3.sh

$ cd ./TP2/Commutateur_VLAN
$ ./test4.sh
```

---

<br/>

### TP3

```bash
$ cd ./TP3
```
---

<br/>

#### Step 1 - AWK (2m12s Consistant)

```bash
$ make -f Makefile.run step1
$ ./compliance.awk zz.output.step1.txt

time find conf -name "router.unix.*" -print | xargs -P 1 -n 1 ./check.int.sh > zz.output.step1.txt || true

real    2m12.079s
user    0m44.351s
sys     0m46.534s
```

```bash
Number of fields : 5
length($1) (=2): 2
length($2) (=12): 12
length($3) (=5): 5
length($4) (=3): 3
length($5) (=[18-22]): 18
length($5) (=[18-22]): 19
length($5) (=[18-22]): 20
length($5) (=[18-22]): 21
length($5) (=[18-22]): 22
```

<br/>

#### Step 2 - AWK (0m0.5s Non consistant)

```bash
$ make -f Makefile.run step2

time find conf -name "router.unix.*" -print | xargs -P 50 -n 50 ./check.int.sh > zz.output.step2.txt || true

real    0m0.578s
user    0m1.577s
sys     0m1.537s
```

```bash
$ ./compliance.awk zz.output.step2.txt

Number of fields : 1
Number of fields : 2
Number of fields : 3
Number of fields : 4
Number of fields : 5
Number of fields : 6
Number of fields : 7
Number of fields : 8
Number of fields : 9
length($1) (=2): 1
length($1) (=2): 11
length($1) (=2): 13
length($1) (=2): 15
length($1) (=2): 17
length($1) (=2): 19
length($1) (=2): 2
length($1) (=2): 20
length($1) (=2): 21
length($1) (=2): 3
length($2) (=12): 0
length($2) (=12): 12
length($2) (=12): 21
length($2) (=12): 3
length($3) (=5): 0
length($3) (=5): 21
length($3) (=5): 5
length($3) (=5): 6
length($3) (=5): 7
length($4) (=3): 0
length($4) (=3): 1
length($4) (=3): 12
length($4) (=3): 2
length($4) (=3): 21
length($4) (=3): 3
length($4) (=3): 4
length($4) (=3): 5
length($4) (=3): 6
length($5) (=[18-22]): 0
length($5) (=[18-22]): 1
length($5) (=[18-22]): 12
length($5) (=[18-22]): 17
length($5) (=[18-22]): 18
length($5) (=[18-22]): 19
length($5) (=[18-22]): 2
length($5) (=[18-22]): 20
length($5) (=[18-22]): 21
length($5) (=[18-22]): 22
length($5) (=[18-22]): 23
length($5) (=[18-22]): 3
length($5) (=[18-22]): 4
length($5) (=[18-22]): 5
length($5) (=[18-22]): 6
length($5) (=[18-22]): 7
length($5) (=[18-22]): 8
length($5) (=[18-22]): 9
```

<br/>

#### Step 3 - FLEX (0m23s Consistant)

```bash
$ make check.flex
$ make -f Makefile.run step3

time find conf -name "router.unix.*" -print | xargs -P 1 -n 1 ./check.flex > zz.output.step3.txt || true

real    0m23.165s
user    0m5.473s
sys     0m8.865s
```

```bash
$ ./compliance.awk zz.output.step3.txt

Number of fields : 5
length($1) (=2): 2
length($2) (=12): 12
length($3) (=5): 5
length($4) (=3): 3
length($5) (=[18-22]): 18
length($5) (=[18-22]): 19
length($5) (=[18-22]): 20
length($5) (=[18-22]): 21
length($5) (=[18-22]): 22
```

<br/>

#### Step 4 TODO

```bash
$ make check.flex
$ make -f Makefile.run step3

time find conf -name "router.unix.*" -print | xargs -P 1 -n 1 ./check.flex > zz.output.step3.txt || true

real    0m23.165s
user    0m5.473s
sys     0m8.865s
```

```bash
$ ./compliance.awk zz.output.step3.txt

Number of fields : 5
length($1) (=2): 2
length($2) (=12): 12
length($3) (=5): 5
length($4) (=3): 3
length($5) (=[18-22]): 18
length($5) (=[18-22]): 19
length($5) (=[18-22]): 20
length($5) (=[18-22]): 21
length($5) (=[18-22]): 22
```