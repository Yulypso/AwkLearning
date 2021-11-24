gawk '
BEGIN {

}
{
    if($1 == "interface") {
        print $0;
    }
} 
END {}
' $1