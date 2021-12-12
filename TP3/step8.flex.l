%{
	#include <stdio.h>
    #include <sys/types.h> 
    #include <unistd.h>
    #include <string.h>

	char filename[100];

    int defined[50] = {0}, i = 0; 
    int applied[50] = {0}, j = 0; 

    char cdefined[50][100], k = 0; 
    char capplied[50][100], l = 0; 

    char * pch;
%}

%%

^"ip access-list extended".*$	{
    pch = strtok (yytext," "); pch = strtok (NULL," ");
    pch = strtok (NULL," "); pch = strtok (NULL," ");
    strcpy(cdefined[k++], pch);
}

^"access-list".*$	{
    pch = strtok (yytext," "); pch = strtok (NULL," ");
    defined[i++] = strtol(pch, NULL, 10);
}

^" access-class".*$	{
    pch = strtok (yytext, " "); pch = strtok (NULL, " ");
    applied[j++] = strtol(pch, NULL, 10);
}

^"snmp-server".*$	{
    pch = strtok (yytext, " "); pch = strtok (NULL, " ");
    pch = strtok (NULL, " "); pch = strtok (NULL, " ");
    pch = strtok (NULL, " ");
    applied[j++] = strtol(pch, NULL, 10);
}

^" ip access-group".*$	{
    pch = strtok (yytext," "); pch = strtok (NULL," ");
    pch = strtok (NULL," ");
    strcpy(capplied[l++], pch);
}

(.|\n)	; 

^end$	{
    int found;
    for(int o=-1;++o<sizeof(defined)/sizeof(*(defined))&&(*(defined+o)!=0);found=0){
        for(int e=-1;++e<sizeof(applied)/sizeof(*(applied))&&(*(applied+o)!=0);)if(applied[o]==defined[e]){found=1;break;}
        if(!found)printf("[x] Defined ACL %d but not applied\n", defined[o]);
    }for(int o=-1;++o<sizeof(cdefined)/sizeof(*(cdefined))&&(*(cdefined+o)!=0);found=0){
        for(int e=-1;++e<sizeof(capplied)/sizeof(*(capplied))&&(*(capplied+o)!=0);)if(!strcmp(capplied[o], cdefined[e])){found=1;break;}
        if(!found)printf("[x] Defined ACL %s but not applied\n", cdefined[o]);
    }for(int o=-1;++o<sizeof(applied)/sizeof(*(applied))&&(*(applied+o)!=0);found=0){
        for(int e=-1;++e<sizeof(defined)/sizeof(*(defined)) && (*(defined+e)!=0);)if(defined[o]==applied[e]){found=1;break;}
        if(!found)printf("[x] Applied ACL %d but not defined\n", applied[o]);
    }for(int o=-1;++o<sizeof(capplied)/sizeof(*(capplied))&&(*(capplied+o)!=0);found=0){
        for(int e=-1;++e<sizeof(cdefined)/sizeof(*(cdefined)) && (*(cdefined+e)!=0);)if(!strcmp(cdefined[o], capplied[e])){found=1;break;}
        if(!found)printf("[x] Applied ACL %s but not defined\n", capplied[o]);
    }
}

%%

int main(int argc, char **argv) {

    if (argc > 1) 
    {
        for (int i = 1; i < argc; ++i)
        {
            strncpy(filename,argv[i], strlen(argv[i]));
            filename[strlen(argv[i])] = '\0';

            yyin = fopen(argv[i], "r");
            yylex();
            fclose(yyin);
        }
    }
    return 0;
}
