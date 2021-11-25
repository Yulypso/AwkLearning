gawk '
BEGIN {
    i = 0;
    j = 0;
    defined[0] = ""; # access-list ; ip access-list extended
    applied[0] = ""; # access-class ; access-group ; snmp-server
}
{
    # defined ACL
    if($2 == "access-list" && $3 == "extended")
    {
        definedm[i][0] = $0;
        definedm[i][1] = NR;
        defined[i++] = $4;
    }
    
    if($1 == "access-list")
    {
        definedm[i][0] = $0;
        definedm[i][1] = NR;
        defined[i++] = $2;
    }
    
    # applied ACL
    if($1 == "access-class")
    {   
        appliedm[j][0] = $0;
        appliedm[j][1] = NR;
        applied[j++] = $2;
    }
    
    if($2 == "access-group")
    {   
        appliedm[j][0] = $0;
        appliedm[j][1] = NR;
        applied[j++] = $3;
    }

    if($1 == "snmp-server")
    {   
        appliedm[j][0] = $0;
        appliedm[j][1] = NR;
        applied[j++] = $5; 
    }
} 
END {
    found = 0;
    for(i = 0; i < length(defined); ++i)
    {
        for(j = 0; j < length(applied); ++j)
        {
            if(defined[i] == applied[j])
            {
                found = 1
                break;
            }
        }
        if(!found)
            print "[X] Defined [" definedm[i][0] "] but not applied. (line: " definedm[i][1] ")";
        found = 0;
    }

    for(i = 0; i < length(applied); ++i)
    {
        for(j = 0; j < length(defined); ++j)
        {
            if(applied[i] == defined[j])
            {
                found = 1
                break;
            }
        }
        if(!found)
            print "[X] Applied [" appliedm[i][0] "] but not defined. (line: " appliedm[i][1] ")";
        found = 0;
    }
}
' $1