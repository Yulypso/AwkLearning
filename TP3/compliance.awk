gawk '
BEGIN {
    nblines = 0;
}
{
    print "Number of fields (should be 5)       : "NF; 
    print "length($1)       (should be 2)       : "length($1);
    print "length($2)       (should be 12)      : "length($2);
    print "length($3)       (should be 5)       : "length($3);
    print "length($4)       (should be 3)       : "length($4);
    print "length($5)       (should be [18..22]): "length($5);
    nblines++;
} 
END {
    print "Nb lines         (should be 20000)   : "nblines;
}
' $1 | sort | uniq