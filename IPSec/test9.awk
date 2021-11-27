gawk '
BEGIN {
    ### Definition des crypto-map
    i = 0;
    j = 0;
    k = 0;
    nl = 0;
    matchAddressLine[0];

    inCryptoMapBlock = 0;
    matchAddress = 0;
    
    cryptoMaps[0];
    cryptoMapsId[0];

    matchAddresses[0];
    accessLists[0];

    cryptoMapFound = 0;
    peerFound = 0;
    transformSetFound = 0;
    matchAddressFound = 0;

    isCryptoMapValid = 0;

    ### Application crypto-map pour FastEthernet
    l = 0;
    inFastEthernetBlock = 0;
    fastEthernetLine = 0;
    fastEthernet = 0;

    cryptoMapsAppliedId[0];
    cryptoMapApplied = 0;
    cryptoMapAppliedLine[0];
    cryptoMapAppliedFound = 0;

    isCryptoMapValid = 0;

    ### To know when next file
    fileN = FILENAME;
}
{
    if(fileN != FILENAME)
    {
        isCryptoMapValid = 0;
        fileN = FILENAME;
    }

    if($1 == "!")
    {
        if(inCryptoMapBlock && peerFound && transformSetFound && matchAddressFound)
        {
            isCryptoMapValid = 1;
            matchAddressLine[j] = nl;
            matchAddresses[j++] = matchAddress;
        }

        if(inFastEthernetBlock && !cryptoMapAppliedFound)
            print "[X] No crypto map applied for [" fastEthernet "] (" FILENAME " line: " fastEthernetLine ")";
        else if (inFastEthernetBlock && cryptoMapAppliedFound)
        {
            cryptoMapAppliedLine[l] = nl;
            cryptoMapsAppliedId[l++] = cryptoMapApplied;
        }

        inCryptoMapBlock = 0;
        peerFound = 0;
        transformSetFound = 0;
        matchAddressFound = 0;
        matchAddress = "";

        inFastEthernetBlock = 0;
        cryptoMapAppliedFound = 0;
        cryptoMapApplied = 0;
        fastEthernet = 0;
    }

    if($0 ~/^(crypto map)(.)*$/)
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

    if($1 == "interface" && $2 ~/^(.)*FastEthernet(.)*$/)
    {
        inFastEthernetBlock = 1;
        fastEthernet = $0;
    }
    
    if(inFastEthernetBlock)
    {
        fastEthernetLine = NR; 

        if($0 ~/^( crypto map)(.)*$/)
        {
            cryptoMapAppliedFound = 1;
            cryptoMapApplied = $3;
            nl = NR;
        }
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
                print "[X] Applied [match address " matchAddresses[i] "] but not defined. (" FILENAME " line: " matchAddressLine[i] ")";
            found = 0;
        }
    }
    else
        print "[X] No crypto map properly defined in configuration file. (" FILENAME ")";
    
    for(i = 0; i < length(cryptoMapsAppliedId); ++i)
    {
        for(j = 0; j < length(cryptoMapsId); ++j)
        {
            if(cryptoMapsAppliedId[i] == cryptoMapsId[j])
            {
                found = 1
                break;
            }
        }
        if(!found)
            print "[X] Applied [crypto map " cryptoMapsAppliedId[i] "] but not defined. (" FILENAME " line: " cryptoMapAppliedLine[i] ")";
        found = 0;
    }
}
' $1 $2 $3