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

#### Step 0 - Generate router.unix.* files

```bash
# using generate.sh
$ make -f Makefile.run step0
```

<br/>

#### Step 1 - AWK (2m12s Consistant)

```bash
$ make -f Makefile.run step1

time find conf -name "router.unix.*" -print | xargs -P 1 -n 1 ./check.int.sh > zz.output.step1.txt || true

real    2m9.257s
user    0m44.215s
sys     0m48.917s
```

```bash
./compliance.awk zz.output.step1.txt

Nb lines         (should be 20000)   : 20000
Number of fields (should be 5)       : 5
length($1)       (should be 2)       : 2
length($2)       (should be 12)      : 12
length($3)       (should be 5)       : 5
length($4)       (should be 3)       : 3
length($5)       (should be [18..22]): 18
length($5)       (should be [18..22]): 19
length($5)       (should be [18..22]): 20
length($5)       (should be [18..22]): 21
length($5)       (should be [18..22]): 22
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

Nb lines         (should be 20000)   : 20000
Number of fields (should be 5)       : 1
Number of fields (should be 5)       : 2
Number of fields (should be 5)       : 3
Number of fields (should be 5)       : 4
Number of fields (should be 5)       : 5
Number of fields (should be 5)       : 6
Number of fields (should be 5)       : 7
Number of fields (should be 5)       : 8
Number of fields (should be 5)       : 9
length($1)       (should be 2)       : 1
length($1)       (should be 2)       : 13
length($1)       (should be 2)       : 15
length($1)       (should be 2)       : 17
length($1)       (should be 2)       : 19
length($1)       (should be 2)       : 2
length($1)       (should be 2)       : 20
length($1)       (should be 2)       : 21
length($1)       (should be 2)       : 3
length($2)       (should be 12)      : 0
length($2)       (should be 12)      : 12
length($2)       (should be 12)      : 20
length($2)       (should be 12)      : 21
length($2)       (should be 12)      : 3
length($3)       (should be 5)       : 0
length($3)       (should be 5)       : 21
length($3)       (should be 5)       : 25
length($3)       (should be 5)       : 5
length($3)       (should be 5)       : 6
length($3)       (should be 5)       : 7
length($4)       (should be 3)       : 0
length($4)       (should be 3)       : 1
length($4)       (should be 3)       : 12
length($4)       (should be 3)       : 19
length($4)       (should be 3)       : 2
length($4)       (should be 3)       : 20
length($4)       (should be 3)       : 21
length($4)       (should be 3)       : 23
length($4)       (should be 3)       : 3
length($4)       (should be 3)       : 4
length($4)       (should be 3)       : 5
length($5)       (should be [18..22]): 0
length($5)       (should be [18..22]): 1
length($5)       (should be [18..22]): 10
length($5)       (should be [18..22]): 12
length($5)       (should be [18..22]): 14
length($5)       (should be [18..22]): 15
length($5)       (should be [18..22]): 17
length($5)       (should be [18..22]): 18
length($5)       (should be [18..22]): 19
length($5)       (should be [18..22]): 2
length($5)       (should be [18..22]): 20
length($5)       (should be [18..22]): 21
length($5)       (should be [18..22]): 22
length($5)       (should be [18..22]): 23
length($5)       (should be [18..22]): 25
length($5)       (should be [18..22]): 27
length($5)       (should be [18..22]): 3
length($5)       (should be [18..22]): 4
length($5)       (should be [18..22]): 5
length($5)       (should be [18..22]): 6
length($5)       (should be [18..22]): 8
```

<br/>

#### Step 3 - FLEX (0m23s Consistant)

```bash
$ make -f Makefile.run step3

time find conf -name "router.unix.*" -print | xargs -P 1 -n 1 ./check.flex > zz.output.step3.txt || true

real    0m23.165s
user    0m5.473s
sys     0m8.865s
```

```bash
$ ./compliance.awk zz.output.step3.txt

Nb lines         (should be 20000)   : 20000
Number of fields (should be 5)       : 5
length($1)       (should be 2)       : 2
length($2)       (should be 12)      : 12
length($3)       (should be 5)       : 5
length($4)       (should be 3)       : 3
length($5)       (should be [18..22]): 18
length($5)       (should be [18..22]): 19
length($5)       (should be [18..22]): 20
length($5)       (should be [18..22]): 21
length($5)       (should be [18..22]): 22
```

<br/>

#### Step 4 FLEX (0m0.2s Parfois Consistant et Non consistant)

```bash
$ make -f Makefile.run step4

time find conf -name "router.unix.*" -print | xargs -P 50 -n 50 ./check.flex > zz.output.step4.txt || true

real    0m0.203s
user    0m0.117s
sys     0m0.186s
```

```bash
$ ./compliance.awk zz.output.step4.txt

Nb lines         (should be 20000)   : 20000
Number of fields (should be 5)       : 5
length($1)       (should be 2)       : 2
length($2)       (should be 12)      : 12
length($3)       (should be 5)       : 5
length($4)       (should be 3)       : 3
length($5)       (should be [18..22]): 18
length($5)       (should be [18..22]): 19
length($5)       (should be [18..22]): 20
length($5)       (should be [18..22]): 21
length($5)       (should be [18..22]): 22
```

```bash
$ ./compliance.awk zz.output.step4.txt

Nb lines         (should be 20000)   : 20000
Number of fields (should be 5)       : 2
Number of fields (should be 5)       : 5
Number of fields (should be 5)       : 6
Number of fields (should be 5)       : 7
Number of fields (should be 5)       : 8
length($1)       (should be 2)       : 1
length($1)       (should be 2)       : 2
length($1)       (should be 2)       : 3
length($2)       (should be 12)      : 12
length($2)       (should be 12)      : 21
length($3)       (should be 5)       : 0
length($3)       (should be 5)       : 5
length($3)       (should be 5)       : 6
length($4)       (should be 3)       : 0
length($4)       (should be 3)       : 12
length($4)       (should be 3)       : 2
length($4)       (should be 3)       : 3
length($5)       (should be [18..22]): 0
length($5)       (should be [18..22]): 12
length($5)       (should be [18..22]): 18
length($5)       (should be [18..22]): 19
length($5)       (should be [18..22]): 20
length($5)       (should be [18..22]): 21
length($5)       (should be [18..22]): 22
length($5)       (should be [18..22]): 3
length($5)       (should be [18..22]): 5
```

<br/>

#### Step 5 FLEX (0m0.631s Consistant)

```bash
$ make -f Makefile.run step5

time find conf -name "router.unix.*" -print | xargs -P 50 -n 50 ./check.race || true

real    0m0.631s
user    0m0.323s
sys     0m0.963s
cat tmp/* > zz.output.step5.txt
```

```bash
./compliance.awk zz.output.step5.txt

Nb lines         (should be 20000)   : 20000
Number of fields (should be 5)       : 5
length($1)       (should be 2)       : 2
length($2)       (should be 12)      : 12
length($3)       (should be 5)       : 5
length($4)       (should be 3)       : 3
length($5)       (should be [18..22]): 18
length($5)       (should be [18..22]): 19
length($5)       (should be [18..22]): 20
length($5)       (should be [18..22]): 21
length($5)       (should be [18..22]): 22
```

<br/>

#### Step 6 FLEX: compter le nombre de mot "ip" et "any" dans le fichier router.unix

```bash
$ make -f Makefile.run step6

Nb ip: 7
Nb any: 4
```

<br/>

#### Step 7 FLEX: Ecrire un programme FLEX qui vérifie que access-class in & out sont mis sur toutes les lignes vty dans le fichier router.unix


```bash
$ make -f Makefile.run step7

access-class 27 out not implemented in line vty
```

<br/>

#### Step 8 FLEX: Ecrire un programme FLEX qui vérifie que la consistant des ACLs defs pas refs et refs pas defs dans le router.unix. On pourra reprendre le programme en awk et contrôler les performances avec le programme en FLEX sur les milliers d'instances crées de router.unix dans le cadre du TP.


```bash
$ make -f Makefile.run step8

[x] Defined ACL 28 but not applied
[x] Defined ACL 24 but not applied
[x] Applied ACL 23 but not defined
[x] Applied ACL 23 but not defined
[x] Applied ACL 27 but not defined
[x] Applied ACL 23 but not defined
```