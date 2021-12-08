awk '{ 
    print "Number of fields : "NF; 
    print "length($1) (=2): "length($1);
    print "length($2) (=12): "length($2);
    print "length($3) (=5): "length($3);
    print "length($4) (=3): "length($4);
    print "length($5) (=[18-22]): "length($5);
}' $1 | sort | uniq