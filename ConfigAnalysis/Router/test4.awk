gawk '
BEGIN {
    nl;
    interfaceNb = 0;
    isIpValid = 0;
    accessGroupFound = 0;
}
{
    if($1 == "!" && interfaceNb)
    {
        if(accessGroupFound)
            print "[V] interface is properly configured: " interface " (line: " nl ")";  
        else if(!accessGroupFound)
            print "[X] interface is not properly configured: missing [access-group] " interface " (line: " nl ")";  
        interfaceNb = 0;
    }

    if($1 == "interface")
    {
        ++interfaceNb;
        nl = NR;
        interface = $0;
        isIpValid = 0;
        accessGroupFound = 0;
    }

    else if(interfaceNb && $1 == "ip" && $3 ~/^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/ && $4 ~/^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/)
        isIpValid = 1;
    
    if(interfaceNb && isIpValid && $1 == "ip" && $2 == "access-group")
        accessGroupFound = 1;
} 
END {}
' $1