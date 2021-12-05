gawk '
BEGIN {
    print "#!/usr/bin/env sage\n";
    print "import graphviz\n";
    print "f = graphviz.Digraph(\"G\", filename=\"commutateur-VLAN.gv\")"
    print "g=DiGraph()";
    print "f.attr(\"node\", shape=\"circle\")";
}
{
    print "g.add_edges([(\""$4"-"$5"\", \"" $1"-"$2"\")])";
    print "f.edge(\""$4"-"$5"\", \"" $1"-"$2"\")";
    print "g.add_edges([(\""$1"-"$2"\", \"" $4"-"$5"\")])";
    print "f.edge(\""$1"-"$2"\", \"" $4"-"$5"\", label=\"VLAN-"$3"\")";
}
END {
    print "g.show()";
    print "f.view()";
    print "g.connected_components()";
}
' $1