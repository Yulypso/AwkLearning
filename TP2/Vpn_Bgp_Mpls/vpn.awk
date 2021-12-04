gawk '
BEGIN {
    hostname;
    client;
}
{
    if($1 == "hostname")
        hostname = $2;

    if($1 == "ip" && $2 == "vrf")
        client = $3;

    if($1 ~/^route-target(.)*$/)
        print hostname "-" client " " $2 " " $3
} 
END {
}
' $1