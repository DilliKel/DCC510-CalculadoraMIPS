# Kelvin Araújo Ferreira - 2019037653

#-------------------------------------------------------------------------------------------------
# Declarando as variáveis q vamos usar
.data
.align 0

continue: .asciiz "\nPressione <ENTER> para continuar\n"
	
title:	.asciiz	"\nEscolha a opção\n"
op_1:	.asciiz " 1 - soma\n"
op_2:	.asciiz " 2 - subtrai\n"
op_3:	.asciiz " 3 - multiplica\n"
op_4: 	.asciiz " 4 - divide\n"
op_5:	.asciiz	" 5 - potencia\n"
op_6:	.asciiz " 6 - raiz_q\n"
op_7:	.asciiz " 7 - tabuada\n"

op_0:	.asciiz " 0 - quit\n"
	
error:	.asciiz "Opcao invalida!!\n"
error2: .asciiz "Numero invalido!!\n"
error3: .asciiz "Raiz de numero negativo!!\n"

newline:	.asciiz "\n"
#-------------------------------------------------------------------------------------------------
.text
.globl main

main:
	#impressão do menu
	addi $v0, $zero, 4	#código da syscall (impressão de string)
	
	la $a0, title
	syscall
	
	la $a0, op_1
	syscall
	
	la $a0, op_2
	syscall
	
	la $a0, op_3
	syscall
	
	la $a0, op_4
	syscall
	
	la $a0, op_5
	syscall
	
	la $a0, op_6
	syscall
	
	la $a0, op_7
	syscall
	
	la $a0, op_0
	syscall
#-------------------------------------------------------------------------------------------------
ler_op: 	#Ler um dos operadores escolhidos
	#código p/ ler inteiro que for digitado
	addi $v0, $zero, 5
	syscall
	
	add $t9, $v0, $zero 	# O $t9 vai receber o valor digitado e armazenar ele
	
	beq $t9, $zero, quit	# Se o valor digitado for IGUAL a 0, ele vai encerrar o programa
	
	bltz   $t9, invalid_op # Se o valor digitado for menor que zero, vai dar o erro de "op negativa"
	
	addi $t8, $zero, 8
	ble $t8, $t9, invalid_op   #Se o valor digitado for "op maior que 7" vai dar erro tambem
#-------------------------------------------------------------------------------------------------
ler_arg:#leitura do primeiro argumento digitado
	addi $v0, $zero, 5  #código para ler inteiro
	syscall
	add $t0, $v0, $zero #armazenar primeio argumento
	
	#verificação se a opção é maior que 6 --Comparação--
	#opções maiores que 6 só exigem um argumento
	addi $t8, $zero, 5
	blt $t8, $t9, exec_op
#Se for necessário apenas um, executa direto, se não, chama o segundo argumento
	
ler_arg2: 	#leitura do segundo argumento, se necessário
	addi $v0, $zero, 5 
	syscall
	
	j exec_op
#-------------------------------------------------------------------------------------------------
exec_op:#preparação para chamada das funções do menu

	#argumentos dos procedimentos
	add $a1, $v0, $zero
	add $a0, $t0, $zero
	
	addi $t8, $zero, 1
	beq  $t8, $t9, exec_soma # se operação for 1, soma
	
	addi $t8, $zero, 2
	beq  $t8, $t9, exec_subtr #se operação for 2, subtração
	
	addi $t8, $zero,3
	beq $t8, $t9, exec_multi #se operação for 3, multiplica
	
	addi $t8, $zero,4
	beq $t8, $t9, exec_divi #se operação for 4, divide
	
	addi $t8, $zero, 5
	beq $t8, $t9, exec_expo #se operação for 5, potencia
	
	addi $t8, $zero, 6
	beq  $t8, $t9, exec_raiz # se operação for 6, raiz
	
	addi $t8, $zero, 7
	beq  $t8, $t9, exec_tabuada # se operação for 7, tabuada
#-------------------------------------------------------------------------------------------------
exec_soma:		#Execução da soma
	jal soma 	#vai pular pra função soma, e executar ela
	
	j print_result #Vai pular pro laço e executar a impressão do resultado

soma: #soma dois valores
	add $v0, $a0, $a1
	
	jr $ra		#volta pro inicio da execução
#-------------------------------------------------------------------------------------------------
exec_subtr:
	jal subtr #vai pular pra função subtração, e executar ela

	j print_result #Vai pular pro laço e executar a impressão do resultado

subtr: #subtrai 2 valores
	sub $v0, $a0, $a1

	jr $ra		#volta pro inicio da execução
#-------------------------------------------------------------------------------------------------
exec_multi:
	addi $t8, $zero, 32768
	ble $t8, $a0, invalid_op2   #a0 maior que 16bit+
	addi $t8, $zero, -32769
	bge $t8, $a0, invalid_op2   #a0 menor que 16bits-
	addi $t8, $zero, 32768
	
	ble $t8, $a1, invalid_op2   #a1 maior que 16bit+
	addi $t8, $zero, -32769
	bge $t8, $a1, invalid_op2   #a1 menor que 16bits-

	jal multi #vai pular pra função multiplicação, e executar ela

	j print_result #Vai pular pro laço e executar a impressão do resultado

multi: #multiplica 2 valores de 16bits
	mult $a0, $a1
	mflo $v0

	jr $ra		#volta pro inicio da execução
#-------------------------------------------------------------------------------------------------
exec_divi:
	addi $t8, $zero, 32768
	ble $t8, $a0, invalid_op2   #a0 maior que 16bit+
	addi $t8, $zero, -32769
	bge $t8, $a0, invalid_op2   #a0 menor que 16bits-
	addi $t8, $zero, 32768
	
	ble $t8, $a1, invalid_op2   #a1 maior que 16bit+
	addi $t8, $zero, -32769
	bge $t8, $a1, invalid_op2   #a1 menor que 16bits-

	jal divi	#vai pular pra função divisão, e executar ela

	j print_result	#Vai pular pro laço e executar a impressão do resultado

divi: #divide 2 valores de 16bits
	div $a0, $a1
	mflo $v0

	jr $ra		#volta pro inicio da execução
#-------------------------------------------------------------------------------------------------
exec_expo:
	add $v0, $a0, $zero	#atribuir zero ao registrador $v0
	addi $v0, $zero, 1	#atribuir 1 ao registrador $v0
	addi $s0, $zero, 1	#atribuir 1 ao registrador $s0
	ble $a1, $zero, invalid_op2   #a1 menor que zero então vai dar erro
	jal expo_for		#vai pular pra função e executar ela

	j print_result		#Vai pular pro laço e executar a impressão do resultado

expo_for:			# a função de como funciona a potencia
	ble $a1, $zero, expo

	mul $v0, $v0, $a0
	sub $a1, $a1, $s0

	j expo_for

expo:
	jr $ra
#-------------------------------------------------------------------------------------------------
# RAIZ
# v0 = raiz(a0)
#
# Retorna a raiz quadrada do inteiro positivo em $a0
#
# Argumento:
#	$a0 - Inteiro positivo para tirar a raiz quadrada.
#
# Resultado:
#	$v0 - O piso da raiz quadrada calculada, como um inteiro.
#
# Registradores locais:
#	$v0: Número x sendo testado para ver se é a raiz quadrada de n.
#	$t0: Raiz de x.
#------------------------------------------------------------------------------------------
exec_raiz:
	blt $a0,$zero, invalid_op3

	jal raiz
	j print_result

raiz:	
	li	$v0, 0			# x = 0

raiz_loop:	
	mul	$t0, $v0, $v0		# t0 = x*x
	bgt	$t0, $a0, raiz_end	# if (x*x > n) vai para raiz_end --comparação--
	addi	$v0, $v0, 1		# x = x + 1
	j	raiz_loop		# vai para raiz_loop
	
raiz_end:
	addi	$v0, $v0, -1		# x = x - 1
	jr	$ra			#volta pro inicio da execução
#-------------------------------------------------------------------------------------------------
# TABUADA
#
# Printa a tabuada do inteiro $a0
#
# Argumento:
#	$a0 - Inteiro positivo.
#
# Resultado:
#	Nenhum.
#
# Registradores locais:
#	$t0: Número (x) para imprimir a tabuada.
#	$t1: Contador (i) até 10.
#	$t2: Auxiliar com o valor de 10.
#	
#	$a0: n = i * x.
#------------------------------------------------------------------------------------------
exec_tabuada:
	jal tabuada
	j print_continue

tabuada:
	move	$t0, $a0	# salva x em t0
	li	$t1, 1		# i = 1
	li 	$t2, 10		# maxValue = 10
	
	# imprime uma nova linha
	la	$a0, newline
	li	$v0, 4
	syscall

tabuada_loop:
	
	bgt	$t1, $t2, tabuada_end	# se contador for maior que 10, vai para end
	
	mul	$a0, $t0, $t1	# n = i * x
	addi	$t1, $t1, 1 	# i = i + 1
	
	li	$v0, 1		# imprime n
	syscall
	
	# imprime uma nova linha
	la	$a0, newline
	li	$v0, 4
	syscall
	
	j	tabuada_loop	# vai para tabuada_loop
	
tabuada_end:
	jr	$ra
#-------------------------------------------------------------------------------------------------
print_result:
	#impressão do resultado de uma função
	add $a0, $v0, $zero
	addi $v0, $zero, 1
	syscall
#-------------------------------------------------------------------------------------------------
print_continue:		# Quando a função for executada corretamente ela vai jogar pra cá
	la $a0, continue
	addi $v0, $zero, 4
	syscall		# Aqui vai limpar os registradores, pra poder usar eles novamente
	
	addi $v0, $zero, 12
	syscall
	
	j main		# E então vai jogar pra main para imprimir o menu novamente
#-------------------------------------------------------------------------------------------------
#Operadores dos possiveis erros listados
invalid_op: 	#tratamento de opções inválidas
	la $a0, error
	addi $v0, $zero, 4
	syscall
	
	j print_continue
	
invalid_op2: 	#tratamento de input inválidos
	la $a0, error2
	addi $v0, $zero, 4
	syscall
	
	j print_continue

invalid_op3: 	#tratamento de raiz negativa
	la $a0, error3
	addi $v0, $zero, 4
	syscall
	
	j print_continue
#-------------------------------------------------------------------------------------------------
print_newline:		#Imprimir o pulo da linha em branco
	la $a0, newline
	addi $v0, $zero, 4
	syscall
	
	jr $ra

quit:		#fim do programa
	addi $v0, $zero, 10
	syscall
