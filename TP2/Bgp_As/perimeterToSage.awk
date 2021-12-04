gawk '
BEGIN {
    print "#!/usr/bin/env sage\n";
    print "import graphviz\n";
    print "f = graphviz.Digraph(\"G\", filename=\"bgp-as.gv\")"
    print "g=DiGraph()";
    print "f.attr(\"node\", shape=\"circle\")";
}
{
    print "g.add_edges([(\""$2"\", \"" $4"\")])";
    print "f.edge(\"AS-"$2"\", \"AS-" $4"\", label=\"["$1"]->["$3"]\")";
}
END {
    print "g.show()";
    print "f.view()";
    print "g.connected_components()";
}
' $1