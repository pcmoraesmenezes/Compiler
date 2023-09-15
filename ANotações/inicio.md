# INicio do projeto de compilador 
## AUla dia 14/09

### Analise lexica
Metacaracter | Significado
-------------|------------
.            | Qualquer caractere exceto nova linha
\w           | Qualquer caractere alfanumérico
\W           | Qualquer caractere não alfanumérico
\d           | Qualquer caractere numérico
\D           | Qualquer caractere não numérico
\s           | Qualquer caractere de espaço em branco
\S           | Qualquer caractere que não seja espaço em branco
\b           | Limite de palavra
\B           | Não é um limite de palavra
^            | Início de uma string
$            | Fim de uma string
[]           | Qualquer caractere dentro dos colchetes
[^ ]         | Qualquer caractere fora dos colchetes
\            | Escape para caracteres especiais
\|           | Ou
( )          | Grupo
x            | O caractere x
\n           | Nova linha
'*'            | Zero ou mais ocorrências
'+'            | Uma ou mais ocorrências
?            | Zero ou uma ocorrência
{n}          | Exatamente n ocorrências
$            | Fim de uma string
a|b          | Alternativa a ou b
(ab)+        | Uma ou mais ocorrências de ab
(ab)*        | Zero ou mais ocorrências de ab
(ab)?        | Zero ou uma ocorrência de ab
"a+b"        | Literal a+b
[abc]        | Qualquer caractere dentro dos colchetes (a, b ou c)
[^abc]       | Qualquer caractere fora dos colchetes

### Exemplos:

cadeia       | Significado
-------------|------------
a            | Literal a
ab           | Literal ab
a*           | Zero ou mais ocorrências de a
a+           | Uma ou mais ocorrências de a
a?           | Zero ou uma ocorrência de a
a{3}         | Exatamente 3 ocorrências de a
a{3,}        | 3 ou mais ocorrências de a
a{3,6}       | Entre 3 e 6 ocorrências de a
a{,6}        | No máximo 6 ocorrências de a
a{3,6}?      | Entre 3 e 6 ocorrências de a (não guloso - pega o mínimo possível)
a{3,6}+      | Entre 3 e 6 ocorrências de a (guloso - pega o máximo possível)
a*b          | Zero ou mais ocorrências de a seguido de b
a+b          | Uma ou mais ocorrências de a seguido de b
a?b          | Zero ou uma ocorrência de a seguido de b



### ANotações

```
flex -t lexico.l > lexico.c
```

lexico.c contem a implementaça do automato do analisador lexico, dentro da função gerada que é chamada yylex()

```
gcc lexico.c -o lexico
```

lexico é o nome do executavel gerado pelo gcc

```
./lexico < teste.txt
```

teste.txt é o arquivo de entrada para o analisador lexico



### Analise LExica


Nome do token | Expressão regular
--------------|------------------
int yylex(void) | Função principal do analisador léxico que retorna o token encontrado
int yywrap(void) | Função que retorna 1 quando o analisador léxico deve parar de ler a entrada e 0 caso contrário
int yylineno | Número da linha atual
char *yytext | Texto do token encontrado
int yyleng | Tamanho do token encontrado
int yyin | Arquivo de entrada
int yyout | Arquivo de saída
int yy_flex_debug | Habilita modo debug
int yyrestart(FILE *input_file) | Reinicia o analisador léxico para ler o arquivo input_file
int yyparse(void) | Função principal do analisador sintático
int yyerror(char *s) | Função que é chamada quando um erro sintático é encontrado
char *yytext | Ponteiro para o padrão lexico (string) encontrado
yyleng | Tamanho do padrão lexico encontrado
yylval | Valor do padrão lexico encontrado
FILE * yyout | Arquivo de saída
FILE * yyin | Arquivo de entrada
INITIAL | Estado inicial do analisador léxico
BEGIN condition | Muda para o estado condition
ECHO | Imprime o padrão lexico encontrado

### Executando

```
flex -t lexico.l > lexico.c
gcc lexico.c -o lexico
./lexico < teste.txt
```