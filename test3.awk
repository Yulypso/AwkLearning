awk '
BEGIN {}
{
    if($1 == "interface") {
        if($0 in interface) { #indice la ligne comme index du tableau interface (l index est lui meme la ligne de l interface)
            print $0, "doublon";
        } else {
            interface[$0] = "";
            this = $0;
        }
    }
    if($1 == "ip" && $2 == "address") interface_ip[this] = $0;

} 
END {
    for(id in interface) {
        print id, interface_ip[id]; # id ici est donc la ligne qui correspond a index de interface
    }
}
' $1