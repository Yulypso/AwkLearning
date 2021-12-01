gawk '
BEGIN {
}
{
} 
END {
}
' $1 $2 $3 $4 $5 $6


# BGP(@IP1, @IP2)
interface loopback
 ip address 10.0.0.1 #IP1

router bgp 4
 neighbor 13.0.0.1 remote-as 2 #IP2
 neighbor 13.0.0.1 prefix-list bgp-deny in
 neighbor 13.0.0.1 password secret
 neighbor 11.0.0.1 remote-as 1
 neighbor 11.0.0.1 password secret