gawk '
BEGIN {
    print "#!/usr/bin/env sage\n";
    print "import graphviz\n";
    print "f = graphviz.Digraph(\"G\", filename=\"ipsec.gv\")"
    print "g=DiGraph()";
    print "f.attr(\"node\", shape=\"circle\")";
    ips[0];
    interfaces[0];
    ciphers[0];
    i = 0;
}
{
    ips[i] = $1
    interfaces[i] = $2
    ciphers[i++] = $3
}
END {

    already_printed_interfaces[0];
    already_printed_ciphers[0];
    k = 0;
    flag = 0;

    for (i = 0; i < length(ips); i++)
        for (j = 0; j < length(ips); j++)
            if (interfaces[i] == interfaces[j] && ciphers[i] == ciphers[j] && ips[i] != ips[j])
            {
                flag = 1;
                for (l = 0; l < length(already_printed_interfaces); l++)
                    if (already_printed_interfaces[l] == interfaces[j] && already_printed_ciphers[l] == ciphers[j])
                        flag = 0;
                if (flag == 1)
                {
                    print "g.add_edges([(\""ips[i]"\", \"" ips[j]"\")])";
                    print "f.edge(\""ips[i]"\", \"" ips[j]"\", label=\"["interfaces[i]"]("ciphers[i]")\")";

                    print "g.add_edges([(\""ips[j]"\", \"" ips[i]"\")])";
                    print "f.edge(\""ips[j]"\", \"" ips[i]"\")";
                }
                already_printed_interfaces[k] = interfaces[j];
                already_printed_ciphers[k++] = ciphers[j];
            }

    print "g.show()";
    print "f.view()";
    print "g.connected_components()";
}
' $1