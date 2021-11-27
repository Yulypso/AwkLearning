gawk '
BEGIN {
    nl;
    inBlock = 0;
    block;
    lin = 0;
    lout = 0;
}
{
    if($1 == "!" && inBlock)
    {
        if(!lin || !lout)
            print "[X] line is not properly configured: " block " (line: " nl ")"; 
        inBlock = 0;
    }

    if ($1 == "line" && inBlock == 1)
    {
        if(!lin || !lout)
            print "[X] line is not properly configured: " block " (line: " nl ")"; 
        
        inBlock = 1;
        nl = NR;
        block = $0
        lin = 0;
        lout = 0;
    }

    if($1 == "line" && inBlock == 0)
    {
        inBlock = 1;
        nl = NR;
        block = $0
        lin = 0;
        lout = 0;
    }

    if(inBlock && ($3 == "in" || $3 == "out"))
    {
        if($3 == "in")
            lin = 1;
        if($3 == "out")
            lout = 1;
    }
} 
END {}
' $1