# DCC510-ProgramaCalculadora

O objetivo desse trabalho é fazer um programa em Assembly MIPS que simule uma calculadora. Deve ser mostrado ao usuário um menu com as seguintes opções:

|OP    |Código |    Descricao                  |                   Retorno|
|------|-| -------------------------------|--------------------------|
|soma: |1 |	Soma de dois inteiros	 			 |                 $v0 = $a0 + $a1|
|      |                               |                          |
|subtrai: |2|	Subtração de dois inteiros			    |           $v0 = $a0 - $a1|
|      |   |                            |                          |
|multiplica: |3|	Multiplicação de dois inteiros			 |        $v0 = $a0 * $a1|
|      |    |                           |                          |
|divide:	|4|	Divisão de dois números em ponto flutuante	|   $v0 = $a0 / $a1|
|      |     |                          |                          |
|potencia:|5|	Potência de dois inteiros			            |     $v0 = $a0 ^ $a1|
|      |      |                         |                          |
|raiz_q:	|6|	Raiz quadrada de um ponto flutuante		  |       $v0 = sqrt($a0)|
|      |        |                       |                          |
|tabuada: |7|	Impressão da tabuada de 1 inteiro		  |         sem retorno|
|      |         |                      |                          |
|quit:	|8|	Fim do programa					                        | sem retorno|
|      |                               |                          |


Observações importantes:

* O programa deve ser totalmente comentado, linha por linha.

* Gravar um vídeo explicando o código;

* Deve ser enviado o arquivo com o código e um arquivo de vídeo.

* Sempre que uma operação for concluída deve-se retornar ao menu principal. O encerramento do programa somente deverá ocorrer com a opção “Encerrar o programa”.

* Não considere números negativos.
