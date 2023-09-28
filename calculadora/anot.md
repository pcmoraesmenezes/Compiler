simples: lexico.l sintatico.y;

flex -o lexico.c lexico.l;

bison -v -d sintatico.y -o sintatico.c;

./calc