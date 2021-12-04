gawk '
BEGIN {
    hostnames[0];
    allowed_vlan[0, 0]; 
    nb_allowed_vlan[0] = 0;
    interfaces[0, 0];
    nb_interfaces[0] = 0;
    vlans[0, 0];
    i = -1;
    j = 0;
    k = 0;
}
{
    if ($1 == "hostname")
    {
        hostnames[++i] = $2;
    }
    else if ($1 == "switchport" && $2 == "trunk" && $3 == "allowed" && $4 == "vlan")
    {
        split($5, temp, ",");
        for (k = 0; k++ < length(temp);)
        {
            allowed_vlan[i, k-1] = temp[k];
            nb_allowed_vlan[i] = length(temp);
        }
    }
    else if ($1 == "interface" && $2 ~/^Ethernet(.)$/ && $2 != "Ethernet1")
    {
        interfaces[i, j] = $2;
        nb_interfaces[i] += 1;
    }
    else if ($1 == "switchport" && $2 == "access" && $3 == "vlan")
    {
        vlans[i, k] = $4;
        print hostnames[i], interfaces[i, j++], $3 vlans[i, k++];
    }   
} 
END {

    #print interfaces[0, 0];

    for (i = 0; i < length(hostnames); i++)
    {
        #print nb_interfaces[i];
        for (j = 0; j < nb_interfaces[i]; j++)
        {
            print interfaces[i, j];
        }
    }

    #for (p = 0; p < nb_allowed_vlan[i]; p++)
    #{
    #    if (vlans[i, j] == allowed_vlan[i, p])
    #    {
    #        print hostnames[i], interfaces[i, j], $3$4;
    #    }
    #}

}
' $1

#else if ($1 == "switchport" && $2 == "access" && $3 == "vlan")
#    {
#        vlans[i, j] = $4;
#        for (p = 0; p < nb_allowed_vlan[i]; p++)
#        {
#            if (vlans[i, j] == allowed_vlan[i, p])
#            {
#               print hostnames[i], interfaces[i, j], $3$4;
#            }
#        }
#    }   