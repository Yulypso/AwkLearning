awk '
{
    if($1 == "interface") print $0;

    if($1 == "ip" && $2 == "address") print interface, $0;
}
' $1