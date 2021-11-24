gawk '
BEGIN {
    serviceFound = 0;
    line;
    nl;
}
{
    if($1 == "snmp-server" && $4 == "RO") 
    {
        serviceFound = 1;
        line = $0
        nl = NR
    }
    else if($1 == "snmp-server" && $4 != "RO") 
    {
        line = $0
        nl = NR
    }
} 
END {
    if(serviceFound)
        print "[V] snmp-server properly configured: " line " (line: " nl ")";    
    else
        print "[X] snmp-server is not properly configured: " line " (line: " nl ")"; 
}
' $1