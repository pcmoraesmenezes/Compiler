%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);
%}

%token NUM
%token MAIS
%token MENOS
%token VEZES
%token DIV
%token ABRE
%token FECHA
%token ENTER

%start comando

%left MAIS MENOS
%left VEZES DIV

%%

comando
    : comando expr ENTER { printf ("result = %d\n", $2);}
    | 
    ;

expr
    : NUM                { $$ = $1; }
    | expr MAIS expr     { $$ = $1 + $3;}
    | expr MENOS expr   { $$ = $1 - $3;}
    | expr VEZES expr   { $$ = $1 * $3;}
    | expr DIV expr     { $$ = $1 / $3;}
    | ABRE expr FECHA   { $$ = $2;}
    ;

%%

void yyerror(char *s) {
    printf("%s \n", s);
}

int main(void) {
    yyparse();
    return 0;
}
