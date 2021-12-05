gawk '
BEGIN {
    hostnames[0];
    interfaces[0, 0];
    i = -1;
    j = 0;
}
{
    if ($1 == "hostname")
        hostnames[++i] = $2;
    else if ($1 == "switchport" && $2 == "trunk" && $3 == "allowed" && $4 == "vlan")
        print hostnames[i] " allowed: " $5
    else if ($1 == "interface" && $2 ~/^Ethernet(.)$/ && $2 != "Ethernet1")
        interfaces[i, j] = $2;
    else if ($1 == "switchport" && $2 == "access" && $3 == "vlan")
        print hostnames[i], interfaces[i, j++], $4;
} 
END {
}
' $1