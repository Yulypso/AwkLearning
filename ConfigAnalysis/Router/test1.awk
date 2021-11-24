gawk '
BEGIN {
    serviceFound = 0;
    nl;
}
{
    if($1 == "service" && $2 == "password-encryption") 
    {
        serviceFound = 1;
        nl = NR
    }

} 
END {
    if(serviceFound)
        print ">>> service password-encryption is properly configured (line: " nl ")";
    else
        print ">>> service password-encryption is not configured"
}
' $1