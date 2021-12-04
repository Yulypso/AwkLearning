gawk '
BEGIN {
    router_ip[0];
    router_nb[0];
    as_nb_list[0];
    as_ip[0, 0];
    as_nb[0, 0];
    nb_neighbor[0] = 0;
    i = 0;
    j = 0;
    k = 0;
}
{
    if ($1 == "ip" && $2 == "address")
        router_ip[i] = $3;
    else if ($1 == "router" && $2 == "bgp")
        router_nb[i] = $3;
    else if ($1 == "neighbor" && $3 == "remote-as")
    {
        as_nb_list[k++] = $4;
        as_ip[i, j] = $2;
        as_nb[i, j++] = $4;
        nb_neighbor[i]++;
    }
    else if ($1 == "!")
    {
        j = 0;
        nb_neighbor[++i] = 0;
    }
} 
END {
    for (i = 0; i < length(router_nb); i++)
        for (j = 0; j < nb_neighbor[i]; j++)
            for (k = 0; k < length(router_nb); k++)
                if (router_nb[k] == as_nb[i, j] && router_ip[k] == as_ip[i, j])
                    for (l = 0; l < nb_neighbor[k]; l++)
                        if(as_ip[k, l] == router_ip[i] && as_nb[k, l] == router_nb[i])
                            print router_ip[i], router_nb[i], as_ip[i, j], as_nb[i, j]
}
' $1