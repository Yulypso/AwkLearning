gawk '
BEGIN {
    nl;
    blockNb = 0;
    isprint = 0;
    lin = 0;
    lout = 0;
}
{
    if($1 == "!")
        blockNb = 0;
    else if($1 == "line")
    {
        nl = NR;
        ++blockNb;
        lin = 0;
        lout = 0;
        isprint = 0;
    }

    else if(blockNb && ($3 == "in" || $3 == "out") && !(lin && lout))
    {
        if($3 == "in")
            lin = 1;
        if($3 == "out")
            lout = 1;
    }

    if(!isprint && blockNb && lin && lout)
    {
        print ">>> line is properly configured: (line: " nl ")";  
        isprint = 1;
    }
    else if(!isprint && blockNb && lin && !lout)
    {
        print ">>> line is not properly configured, missing [out]: (line: " nl ")"; 
        isprint = 1;
    }
    else if(!isprint && blockNb && !lin && lout)
    {
        print ">>> line is not properly configured, missing [in]: (line: " nl ")"; 
        isprint = 1;
    }
    else if(!isprint && $1 != "line" && blockNb && !lin && !lout)
    {
        print ">>> line is not properly configured, missing [in] and [out]: (line: " nl ")"; 
        isprint = 1;
    }
} 
END {}
' $1