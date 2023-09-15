digito [0-9]
letra [A-Za-z]
%{
    int count = 0;

%}

%%
{letra}({letra}|{digito})* {count++; puts(yytext);} /* identificador */
.                                  /* nada */
\n                                 /* nada */

%%
int yywrap()
{
    return 1;
}
int main()
{
    yylex();
    printf("Count= %d\n", count);
    return 0;
}
