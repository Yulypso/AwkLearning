%{
	#include <stdio.h>
    #include <sys/types.h> 
    #include <unistd.h>
    #include <string.h>

	char filename[100];

    int acin[50] = {0}, i = 0;
    int acout[50] = {0}, j = 0;

    int vtyin[50] = {0}, l = 0;
    int vtyout[50] = {0}, m = 0;
    char * pch;
%}

%x CON_AUX
%x VTY

%%

^"line con"[ ].*|^"line aux"[ ].*$	{
    BEGIN CON_AUX;
}

<CON_AUX>^"line vty"[ ].*$	{
    BEGIN VTY;
}

<CON_AUX>^.*access-class.*in.*$	{
    pch = strtok (yytext, " "); pch = strtok (NULL, " ");
    acin[i++] = strtol(pch, NULL, 10);
}

<CON_AUX>^.*access-class.*out.*$	{
    pch = strtok (yytext," "); pch = strtok (NULL," ");
    acout[j++] = strtol(pch, NULL, 10);
}

<VTY>^" access-class".*in.*$	{
    pch = strtok (yytext, " "); pch = strtok (NULL, " ");
    vtyin[l++] = strtol(pch, NULL, 10);
}

<VTY>^" access-class".*out.*$	{
    pch = strtok (yytext," "); pch = strtok (NULL," ");
    vtyout[m++] = strtol(pch, NULL, 10);
}

(.|\n)	; 

<CON_AUX>^!$	{
    BEGIN INITIAL;
}

<VTY>^!$	{
    BEGIN INITIAL; int found;
    for(int o=-1;++o<sizeof(acin)/sizeof(*(acin))&&(*(acin+o)!=0);found=0){
        for(int e=-1;++e<sizeof(vtyin)/sizeof(*(vtyin))&&(*(vtyin+e)!=0);)if(vtyin[o]==acin[e]){found=1;break;}
        if(!found)printf("access-class %d in not implemented in line vty\n", acin[o]);
    }for(int o=-1;++o<sizeof(acout)/sizeof(*(acout))&&(*(acout+o)!=0);found=0){
        for(int e=-1;++e<sizeof(vtyout)/sizeof(*(vtyout)) && (*(vtyout+e)!=0);)if(vtyout[o]==acout[e]){found=1;break;}
        if(!found)printf("access-class %d out not implemented in line vty\n", acout[o]);
    }
}

<CON_AUX>(.|\n)	; 

<VTY>(.|\n)	; 

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
