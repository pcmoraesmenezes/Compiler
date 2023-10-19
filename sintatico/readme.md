# Sintatico

## Como executar

Para executar o analisador sintatico, esteja na mesma pasta que o diretorio `sintatico` e execute o comando:

```bash

make

```

## Como testar

Observe que o arquivo gerado tem o nome "simples". Até o momento o projeto do sintatico faz a verificação para testar se as entradas estão corretas, ou seja 
se o arquivo segue a estrutura do compilador. Para testar, execute o comando:

```bash

./simples < arquivo_de_entrada

```

Existe um arquivo de entrada para testes chamado t1.simples, ele possuí uma entrada válida

```bash

./simples < t1.simples

```

A saída será Programa OK!

Existe um outro arquvio de entrada para testes com a entrada inválida, chamado t2.simples

```bash

./simples < t2.simples

```

A saída será Syntax error near token: inicio

O erro está na estrutura, o inicio está sendo utilizado antes do programa, o correto seria:

```bash

programa

inicio

fimprograma

```
