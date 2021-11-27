gawk '
BEGIN {
    ### Definition des crypto-map
    i = 0;
    j = 0;
    k = 0;
    nl = 0;
    matchAddressLine[0] = 0;

    inCryptoMapBlock = 0;
    matchAddress = 0;
    
    cryptoMaps[0] = "";
    cryptoMapsId[0] = "";

    matchAddresses[0] = "";
    accessLists[0] = "";

    cryptoMapFound = 0;
    peerFound = 0;
    transformSetFound = 0;
    matchAddressFound = 0;

    isCryptoMapValid = 0;

    ### Application crypto-map pour FastEthernet
    inFastEthernetBlock = 0;
    
}
{
    if($1 == "!")
    {
        if(inCryptoMapBlock && peerFound && transformSetFound && matchAddressFound)
        {
            isCryptoMapValid = 1;
            matchAddressLine[j] = nl;
            matchAddresses[j++] = matchAddress;
        }

        inCryptoMapBlock = 0;
        peerFound = 0;
        transformSetFound = 0;
        matchAddressFound = 0;
        matchAddress = "";
    }

    if($1 == "crypto" && $2 == "map")
    {
        inCryptoMapBlock = 1;
        cryptoMapFound = 1;
        cryptoMapsLine[i] = NR
        cryptoMapsId[i++] = $3;
    }

    if(inCryptoMapBlock)
    {
        if($1 == "set" && $2 == "peer")
            peerFound = 1;
        
        if($1 == "set" && $2 == "transform-set")
            transformSetFound = 1;

        if($1 == "match" && $2 == "address")
        {
            matchAddressFound = 1;
            nl = NR;
            matchAddress = $3;
        }
    }
    else
    {
        if($1 == "access-list")
            accessLists[k++] = $2;
    }
} 
END {
    if(isCryptoMapValid)
    {
        found = 0;

        for(i = 0; i < length(matchAddresses); ++i)
        {
            for(j = 0; j < length(accessLists); ++j)
            {
                if(matchAddresses[i] == accessLists[j])
                {
                    found = 1
                    break;
                }
            }
            if(!found)
                print "[X] Defined [match address " matchAddresses[i] "] but not applied. (line: " matchAddressLine[i] ")";
            found = 0;
        }
    }
    else
        print "[X]: No crypto map properly defined"
    
}
' $1 $2 $3