%{
	#include <stdio.h>
    #include <sys/types.h> 
    #include <unistd.h>
    #include <string.h>

    int occurs(char * str, char * toSearch);

	char filename[100];
    int nbIp = 0;
    int nbAny = 0;
%}


%%

^.*ip.*|.*any.*$	{
    nbIp += occurs(yytext, "ip");
    nbAny += occurs(yytext, "any");
}

(.|\n)	; 

%%

int occurs(char * s, char * pa) {
    int a = 0, p; for(int i = -1; ++i < strlen(s); p = i+1) {
        for(int j = -1; ++j < strlen(pa);) if(*(s + i) == *(pa + j)) ++i; if((i-p) == strlen(pa)) ++a; i = p;
    } return a;
}

int main(int argc, char **argv) {

    if (argc > 1) 
    {
        for (int i = 1; i < argc; i++)
        {
            strncpy(filename,argv[i], strlen(argv[i]));
            filename[strlen(argv[i])] = '\0';

            yyin = fopen(argv[i], "r");
            yylex();
            fclose(yyin);
        }

        printf("Nb ip: %d\n", nbIp);
        printf("Nb any: %d\n", nbAny);
    }
    return 0;
}
