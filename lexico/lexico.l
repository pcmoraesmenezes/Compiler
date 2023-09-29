identificador  [a-zA-Z]([a-zA-Z0-9])*
numero         [0-9]+
espaco         [ \t\r]+
novalinha      [\n]

%x comentario
%{
   int nlinha = 1;
%}

%%

programa    printf("%4d: %11s: palavra reservada\n", nlinha, yytext);
inicio      printf("%4d: %11s: palavra reservada\n", nlinha, yytext);
fimprograma printf("%4d: %11s: palavra reservada\n", nlinha, yytext);

leia        printf("%4d: %11s: palavra reservada\n", nlinha, yytext);
escreva     printf("%4d: %11s: palavra reservada\n", nlinha, yytext);

se          printf("%4d: %11s: palavra reservada\n", nlinha, yytext);
entao       printf("%4d: %11s: palavra reservada\n", nlinha, yytext);
senao       printf("%4d: %11s: palavra reservada\n", nlinha, yytext);
fimse       printf("%4d: %11s: palavra reservada\n", nlinha, yytext);

enquanto    printf("%4d: %11s: palavra reservada\n", nlinha, yytext);
faca        printf("%4d: %11s: palavra reservada\n", nlinha, yytext);
fimenquanto printf("%4d: %11s: palavra reservada\n", nlinha, yytext);

"+"         printf("%4d: %11s: operador aritmetico soma\n", nlinha, yytext);
"-"         printf("%4d: %11s: operador aritmetico subtracao\n", nlinha, yytext);
"*"         printf("%4d%11s: operador aritmetico multiplicacao\n",nlinha,  yytext);
div         printf("%4d: %11s: operador aritmetico divisao\n", nlinha, yytext);

">"         printf("%4d: %11s: operador relacional maior\n", nlinha, yytext);
"<"         printf("%4d: %11s: operador relacional menor\n", nlinha, yytext);
"="         printf("%4d: %11s: operador relacional igual\n", nlinha, yytext);

e           printf("%4d: %11s: operador logico conjuncao\n", nlinha, yytext);
ou          printf("%4d: %11s: operador logico disjuncao\n", nlinha, yytext);
nao         printf("%4d: %11s: operador logico negacao\n", nlinha, yytext);

"<-"        printf("%4d: %11s: operador de atribuicao\n", nlinha, yytext);
"("         printf("%4d: %11s: simbolo abre parenteses\n", nlinha, yytext);
")"         printf("%4d: %11s: simbolo fecha parenteses\n", nlinha, yytext);

inteiro     printf("%4d: %11s: palavra reservada\n", nlinha, yytext);
logico      printf("%4d: %11s: palavra reservada\n", nlinha, yytext);
V           printf("%4d: %11s: constante logica de verdade\n", nlinha, yytext);
F           printf("%4d: %11s: constante logica de falsidade\n", nlinha, yytext);

{identificador} printf("%4d: %11s: identificador\n", nlinha, yytext);
{numero}        printf("%4d: %11s: numero\n", nlinha, yytext);
{espaco}        /* nao faz nada */
{novalinha}     nlinha++;

"//".*           ; /*Não faz nada */
"/*"             BEGIN(comentario);
<comentario>"*/" BEGIN(INITIAL);
<comentario>.    ; /* Não faz nada */
<comentario>\n   nlinha++;
.               printf("%4d: %11s: ERRO - SIMBOLO NAO RECONHECIDO!\n", nlinha, yytext);

%%

int yywrap(void) { return 1; }

int main (void) {
   yylex();
   return 0;
}