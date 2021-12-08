gawk '
BEGIN {
    inBlock = 0;
    access_group_set = 0;
}
{
    if ($1 == "interface")
    {
        inBlock = NR;
        next;
    }

    if (inBlock != 0 && $2 == "access-group")
    {
        access_group_set = 1;
        next;
    }

    if (inBlock != 0 && $1 == "!" && access_group_set == 0)
    {
        print "ip access-group unset for " FILENAME
        inBlock = 0;
        access_group_set = 0;
        next;
    }
    else if (inBlock != 0 && $1 == "!" && access_group_set == 1)
    {
        inBlock = 0;
        access_group_set = 0;
        next;
    }
} 
END {
    
}
' $*