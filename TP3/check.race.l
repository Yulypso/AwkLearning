%{
	#include <stdio.h>
	char filename[100];
    int access_group_set = 0;
    int line = 0;
%}


%x L1

%%

^interface[ ].*$	{
    BEGIN L1;
    line = yylineno;
}

(.|\n)	; 

<L1>^[ ]ip[ ]access-group[ ].*$	{
    access_group_set = 1;
}

<L1>^!$	{
    BEGIN INITIAL;
    if (access_group_set == 0)
        printf("ip access-group unset for %s\n", filename);
    access_group_set = 0;
}

<L1>(.|\n)	; 

%%

int main(int argc, char **argv ) {

    strncpy(filename,argv[1],strlen(argv[1]));
    filename[strlen(argv[1])] = '\0';


    yyin = fopen( argv[1], "r" );
    yylex();
    fclose(yyin);
}
