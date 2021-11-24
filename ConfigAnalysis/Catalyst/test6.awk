gawk '
BEGIN {
    i = -1;
    j = 0;
    interfaces[0] = ""
    interfaceContents[0][0] = ""
}
{
    if($1 == "!")
    {
        j = 0;
        i++;
    }

    if($1 == "interface")
    {
        interfaces[i] = $0
        interface[i][nl] = NR;
    }

    
    if($1 == "switchport")
        interfaceContents[i][j++] = $0

} 
END {
    trunkEncapsulation = 0;
    trunkMode = 0;

    for(i = 0; i < length(interfaces); ++i)
    {
        print interfaces[i], "(line: " interface[i][nl] ")";
        
        for(j = 0; j < length(interfaceContents[i]); ++j)
        {
            print interfaceContents[i][j];

            # mode trunk
            if(interfaceContents[i][j] ~/^(.)*mode trunk(.)*$/)
                trunkMode = 1;

            # trunk encapsulation
            if(interfaceContents[i][j] ~/^(.)*trunk encapsulation(.)*$/)
                trunkEncapsulation = 1;
            

        }
        trunkEncapsulation = 0;
        trunkMode = 0;
    }

    # verify if trunk mode
}
' $1