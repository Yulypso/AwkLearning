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
        print "[V] service password-encryption is properly configured (line: " nl ")";
    else
        print "[X] service password-encryption is not properly configured"
}
' $1