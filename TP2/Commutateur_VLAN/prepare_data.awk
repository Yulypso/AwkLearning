gawk '
BEGIN {
    allowed_vlan[0, 0];
    nb_allowed_vlan[0];
    cats[0];
    nb_interfaces[0];
    Ethernets[0, 0];
    vlans[0, 0];
    i = -1;
}
{
    if ($2 == "allowed:")
    {
        j = 0;
        split($3, temp, ",");
        cats[++i] = $1;
        for (k = 0; k++ < length(temp);)
            allowed_vlan[i, k-1] = temp[k];
        nb_allowed_vlan[i] = length(temp);
    }
    if ($2 ~/^Ethernet(.)$/)
    {
        nb_interfaces[i]++;
        Ethernets[i, j] = $2;
        vlans[i, j++] = $3;
    }
} 
END {
    for (i = 0; i < length(cats); i++)
        for (k = 0; k < nb_interfaces[i]; k++)
        {
            for (j = 0; j < nb_allowed_vlan[i]; j++)
                if (vlans[i, k] == allowed_vlan[i, j])
                    print cats[i], Ethernets[i, k], vlans[i, k];

            for (l = 0; l < nb_interfaces[i]; l++)
            {
                flag = 0;
                for (h = 0; h < nb_allowed_vlan[i]; h++)
                    if (vlans[i, k] == vlans[i, l] && Ethernets[i, k] != Ethernets[i, l] && vlans[i, l] != allowed_vlan[i, h] && vlans[i, k] != allowed_vlan[i, h])
                        flag += 1;
                if (flag == nb_allowed_vlan[i])
                    print cats[i], Ethernets[i, k], vlans[i, k]
            }
        }
}
' $1