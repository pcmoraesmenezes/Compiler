%{
    #include "calc.h"
    #include <stdlib.h>
    void yyerror (char *);
%}

%%
[0-9]+     {
                yylval = atoi(yytext);
                return NUM; 
            }

"+" return MAIS;
"-" return MENOS;
"*" return VEZES;
"div" return DIV;
"(" return ABRE;
")" return FECHA;
\n  return ENTER;
[ \t]+ /* ignore white space */;
.  yyerror("unknow caracter\n"); 
%%

int yywrap(void) {
    return 1;
}
