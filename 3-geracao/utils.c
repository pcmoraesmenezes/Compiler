// TABELA DE SIMBOLOS

#define TAM_TAB 100

enum{
    INT,
    LOG
};


struct elemTabSimbolos {
    char id[100]; // nome do identificador 
    int end; // endereco
    int tip; // tipo
} tabSimb[TAM_TAB], elemTab;

int posTab = 0; // indica a proxima posição livre para inserir

int buscaSimbolo(char *s){
    int i;
    for (i = posTab - 1; strcmp(tabSimb[i].id, s) && i >= 0; i--)
    ;
    if (i == -1){
        char msg[200];
        sprintf(msg, "Identificador [%s] não encontrado! ", s);
        yyerror(msg);
    }
    return i;
    
}

void insereSimbolo (struct elemTabSimbolos elem){

    int i;

    if (posTab == TAM_TAB){
        yyerror("Tabela de simbolos cheia! ");
        exit(1);
    }
    for (i = posTab - 1; strcmp(tabSimb[i].id, elem.id) && i >= 0; i--)
    ;
    if (i != -1){
        char msg[200];
        sprintf(msg, "Identificador [%s] duplicado!", elem.id);
        yyerror(msg);
    }
    tabSimb[posTab++] = elem;
}

void mostraTabela (){
    puts("Tabela de simbolos: ");
    puts("---------------------------");
    printf("%30s | %s | %s\n", "ID", "END", "TIP");
    for(int i = 0; i < 50; i++)
        printf("-");
    for (int i = 0; i <posTab; i++){
        printf("\n%30s | %3d | %s", tabSimb[i].id, tabSimb[i].end, tabSimb[i].tip == INT? "INT" : "LOG");
    }
    puts("");
}
// Pilha semantica

#define TAM_PIL 100
int pilha[TAM_PIL];
int topo = -1;

void empilha (int valor){
    if (topo == TAM_PIL ){
        yyerror ("Pilha cheia! ");
    }
    pilha[++topo] = valor;
}

int desempilha(){
    if (topo == -1){
        yyerror("Pilha vazia! ");
    }
    return pilha[topo--];
}


//tipo1 e o tipo2 sao os tipos esperados na expressão
//ret é o tipo retornado pela expressão -> Ele será empilhado
void testaTipo (int tipo1, int tipo2, int ret){
    int t1 = desempilha();
    int t2 = desempilha();
    if(t1 != tipo1 || t2 != tipo2)
        yyerror("Tipos incompatíveis! ");
    empilha(ret);
}
