 bison -g -v -d gramatica.y -o gramatica.c

 -g serve para gerar o grafo da gramática

-v serve para gerar o arquivo de debug

-d serve para gerar o arquivo de cabeçalho

-o serve para definir o nome do arquivo de saída

gramatica.c é o arquivo de saída



dot -Tpng gramatica.gv -o gramatica.png

dot serve para gerar o grafo

-Tpng serve para gerar o arquivo em png

gramatica.gv é o arquivo de entrada

-o serve para definir o nome do arquivo de saída

gramatica.png é o arquivo de saída

