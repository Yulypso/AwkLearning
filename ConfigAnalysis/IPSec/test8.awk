gawk '
BEGIN {
    found = 0;
}
{
    if($1 == "access-list" && $2 == "110" && $5 == "10.0.1.0" && $6 == "0.0.0.255" && (($7 == "10.0.1.0" && $8 == "0.0.0.255") || ($7 == "" && $8 == "")))
        found = 1;
    if($1 == "end" && found != 1)
        print "[X] No access-list 110 properly configured: (" FILENAME ")";
    else if($1 == "end" && found == 1)
        found = 0;
} 
END {}
' $1 $2 $3