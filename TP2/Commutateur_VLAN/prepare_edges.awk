gawk '
BEGIN {
    nb_interconnected_vlan[0];
    vlans[0];
    i = -1;
    j = 0;
    current_vlan;
}
{
    if (current_vlan != $3)
    {
        j = 0;
        i++;
        current_vlan = $3;
    }
    nb_interconnected_vlan[i]++;
    vlans[i, j++] = $0;
} 
END {
    # Each VLAN has n*(n-1)/2 connections
    for (i = 0; i < length(nb_interconnected_vlan); i++)
        for (k = 0; k < nb_interconnected_vlan[i]; k++)
            for (l = k; l < nb_interconnected_vlan[i]; l++)
                if (vlans[i, k] != vlans[i, l])
                    print vlans[i, k], vlans[i, l];
}
' $1