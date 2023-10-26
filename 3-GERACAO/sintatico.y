%{
#include <stdio.h>
#include <stdlib.h>
#include "lexico.c"
#include <string.h>
#include "utils.c"

// void erro(char *);
// int yyerror(char *);
%}

%start programa

%token T_PROGRAMA
%token T_INICIO
%token T_FIM
%token T_IDENTIF
%token T_LEIA
%token T_ESCREVA
%token T_ENQTO
%token T_FACA
%token T_FIMENQTO
%token T_SE
%token T_ENTAO
%token T_SENAO
%token T_FIMSE
%token T_ATRIB
%token T_VEZES
%token T_DIV
%token T_MAIS
%token T_MENOS
%token T_IGUAL
%token T_MAIOR
%token T_MENOR
%token T_E
%token T_OU
%token T_V 
%token T_F
%token T_NUMERO
%token T_NAO
%token T_ABRE
%token T_FECHA
%token T_INTEIRO
%token T_LOGICO

%left T_E T_OU
%left T_IGUAL
%left T_MAIOR T_MENOR
%left T_MAIS T_MENOS
%left T_VEZES T_DIV

%%

programa
    : cabecalho variaveis
    | {fprintf(yyout, "\tAMEM\n");}
    |T_INICIO lista_comandos 
     {fprintf(yyout, "\tDMEM\n");}
    |T_FIM
     {fprintf(yyout, "\tFIMP\n");}
    ;

cabecalho
    : T_PROGRAMA T_IDENTIF
    | {fprintf(yyout, "\tINPP\n");}
    ;

variaveis
    : /* vazio */
    | declaracao_variaveis
    ;

declaracao_variaveis
    : tipo lista_variaveis declaracao_variaveis
    | tipo lista_variaveis
    ;

tipo
    : T_INTEIRO
    | T_LOGICO
    ;

lista_variaveis
    : T_IDENTIF lista_variaveis
    | T_IDENTIF
    ;

lista_comandos
    :
    | comando lista_comandos
    ;

comando 
    : leitura
    | escrita
    | repeticao
    | selecao
    | atribuicao
    ;

escrita
    : T_LEIA T_IDENTIF
    {fprintf(yyout, "\tESCR\n");}
    ;

leitura
    : T_LEIA T_IDENTIF
     {
        fprintf(yyout, "\tLEITA\n");
        fprintf(yyout, "\tARGZ\n");
    }

repeticao   
    : T_ENQTO
    {fprintf(yyout, "LX\tNADA\n");}
    expr T_FACA
     {fprintf(yyout, "\tDSVF\tLy\n");}
    lista_comandos T_FIMENQTO
    {
        {fprintf(yyout, "\tDSVF\tLx\n");}
        {fprintf(yyout, "LY\tNADA\n");}
    }
    ;

selecao
    : T_SE expr T_ENTAO 
    {fprintf(yyout, "\tDSVF\tLx\n");}
    |lista_comandos T_SENAO
    {fprintf(yyout, "\tDSVS\tLy\n");
    fprintf(yyout, "Lx:");}
     lista_comandos T_FIMSE
    {fprintf(yyout, "Ly:");}

    ;

atribuicao
    : T_IDENTIF T_ATRIB expr
    {fprintf(yyout, "\tDSVF Lx\n");}
    ;

expr
    : expr T_VEZES expr
    {fprintf(yyout, "\tMULT\n");}
    | expr T_DIV expr
    {fprintf(yyout, "\tDIVI\n");}
    | expr T_MAIS expr
    {fprintf(yyout, "\tSOMA\n");}
    | expr T_MENOS expr
    {fprintf(yyout, "\tSUBT\n");}

    | expr T_MAIOR expr
    {fprintf(yyout, "\tCMMA\n");}
    | expr T_MENOR expr
    {fprintf(yyout, "\tCMME\n");}
    | expr T_IGUAL expr
    {fprintf(yyout, "\tCMIG\n");}

    | expr T_E expr
    {fprintf(yyout, "\tCONJ\n");}
    | expr T_OU expr
    {fprintf(yyout, "\tDISJ\n");}

    | termo
    ;

termo
    : T_IDENTIF
    {fprintf(yyout, "\tCRVG\n");}
    | T_NUMERO
    {fprintf(yyout, "\tCRCT %s\n", atomo);}
    | T_V
    {fprintf(yyout, "\tCRCT\t1\n");}
    | T_F
    {fprintf(yyout, "\tCRCT\t0\n");}
    | T_NAO termo
    {fprintf(yyout, "\tNEGA\n");}
    | T_ABRE expr T_FECHA
    ;

%%

int main(int argc, char *argv[]){
    char *p ,nameIn[100], nameOut[100];
    argv++;
    if (argc < 2){
        puts("\nCompilador da linguagem SIMPLES");
        puts("\n\tUSO: ./simples <nome>[.simples]\n\n");
        exit(1);
    }
    p = strstr(argv[0], ".simples");
    if (p) *p = 0;
    strcpy(nameIn, argv[0]);
    strcat(nameIn, ".simples");
    strcpy(nameOut, argv[0]);
    strcat(nameOut, ".mvs");
    yyin = fopen(nameIn, "rt");
    if(!yyin){
        puts("Programa fonte não encontrado");
        exit(2);
    }
    yyout = fopen(nameOut, "wt");
    yyparse();
    printf("Programa OK!\nNum de linhas: %d\n", numLinha );
    return 0;
}