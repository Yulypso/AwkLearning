gawk '
BEGIN {
    is_FastEthernet = 0;
    is_cipher = 0;
}
{
    if ($2 ~/^FastEthernet(.)$/)
    {
        is_FastEthernet = 1;
        ip = $1;
        interface = $2;
    }
    if ($2 ~/^cipher(.)$/ && is_FastEthernet)
    {
        is_cipher = 1;
        cipher = $2
    }
    if (is_cipher && is_FastEthernet)
    {
        print ip, interface, cipher;
        is_FastEthernet = 0;
        is_cipher = 0;
    }
} 
END {
}
' $1