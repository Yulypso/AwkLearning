#!/usr/bin/env sage

g=DiGraph()
g.add_vertex("A") #noeud
g.add_vertex("B") #noeud
g.add_edges([("A","B")]) #arc
g.add_vertex("C") #noeud
g.show() 
g.connected_components()