gawk '
BEGIN {
    nl;
    def; # access-list ; ip access-list extended
    ref; # access-class ; access-group ; snmp-server
}
{
    if($1 == "!")
    {
        
    }


    
} 
END {}
' $1