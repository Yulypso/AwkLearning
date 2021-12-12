%{
	#include <stdio.h>
    #include <sys/types.h> 
    #include <unistd.h>
    #include <string.h>

	char filename[100];
    FILE *file = NULL;
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
        fprintf(file, "ip access-group unset for %s\n", filename);
    access_group_set = 0;
}

<L1>(.|\n)	; 

%%

int main(int argc, char **argv) {

    char pidString[20];

    if (argc > 1) 
    {
        int pid = getpid();
        snprintf(pidString, sizeof(pidString), "./tmp/%d", pid);

        file = fopen(pidString, "w");
        if (file == NULL)
        {
            printf("Error: Opening file %d\n", pid);
            exit(1);
        }

        for (int i = 1; i < argc; i++)
        {
            strncpy(filename, argv[i], strlen(argv[i]));
            filename[strlen(argv[i])] = '\0';
            yyin = fopen(argv[i], "r");

            yylex();
            fclose(yyin);
        }
        fclose(file);
    }
    return 0;
}
