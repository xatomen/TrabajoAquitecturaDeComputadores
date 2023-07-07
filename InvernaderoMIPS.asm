.data
	variable1: .word
	variable2: .word
	humedad_inicial: .word
	SectoresInverdadero: .word 0,0,0,0,0
.text

main:

	#Cargamos las variables en registros
	move $s0, variable1
	move $s1, variable2
	move $s2, humedad_inicial
	move $s3, SectoresInverdadero

	#For utilizado para cargar los valores iniciales en el arreglo
	li $t0, 0	#Cargamos en el registro $t0 un "i" iniciado en 0
	li $t1, 5	#Cargamos en el registro $t1 un "n" que indica el tamaño del arreglo, en este caso 5
	for1:
		beq $t0, $t1, endfor1	#Si i es igual a n, salimos del for
		sll $t2, $t0, 2			#Calculamos el desplazamiento y lo guardamos en el registro $t2
		add $t3, $t2, $s3		#En el registro $t3 guardamos la dirección de memoria de la casilla a acceder
		#Hacer random
		#Hacer el sw para guardar el random en el arreglo
		addi $t0, $t0, 1		#Incrementamos la "variable i" en 1
		j for1					#Saltamos a la etiqueta for1
	endfor1:

	#For utilizado para mostrar por pantalla los valores del arreglo
	li $t0, 0	#Cargamos en el registro $t0 un "i" iniciado en 0
	li $t1, 5	#Cargamos en el registro $t1 un "n" que indica el tamaño del arreglo, en este caso 5
	for2:
		beq $t0, $t1, endfor1	#Si i es igual a n, salimos del for
		sll $t2, $t0, 2			#Calculamos el desplazamiento y lo guardamos en el registro $t2
		add $t3, $t2, $s3		#En el registro $t3 guardamos la dirección de memoria de la casilla a acceder
		#Hacer el lw
		#Imprimir en pantalla
		addi $t0, $t0, 1		#Incrementamos la "variable i" en 1
		j for1					#Saltamos a la etiqueta for1
	endfor2:

	while:
		#For utilizado para "regar" las plantas
		li $t0, 0	#Cargamos en el registro $t0 un "i" iniciado en 0
		li $t1, 5	#Cargamos en el registro $t1 un "n" que indica el tamaño del arreglo, en este caso 5
		for3:
			addi $sp, $sp, -4		#Hacemos "espacio" para el parámetro de la función regar
			jal regar				#Invocamos la función regar
			#Recuperar valor retornado
			sll $t2, $t0, 2			#Calculamos el desplazamiento y lo guardamos en el registro $t2
			add $t3, $t2, $s3		#En el registro $t3 guardamos la dirección de memoria de la casilla a acceder
			#Hacer la suma
			#Insertar la suma en el campo
			addi $t0, $t0, 1		#Incrementamos la "variable i" en 1
			j for3					#Saltamos a la etiqueta for4
		endfor3:

		#For utilizado para imprimir cada sector
		li $t0, 0	#Cargamos en el registro $t0 un "i" iniciado en 0
		li $t1, 5	#Cargamos en el registro $t1 un "n" que indica el tamaño del arreglo, en este caso 5
		for4:
			sll $t2, $t0, 2			#Calculamos el desplazamiento y lo guardamos en el registro $t2
			add $t3, $t2, $s3		#En el registro $t3 guardamos la dirección de memoria de la casilla a acceder
			#Imprimir
			addi $t0, $t0, 1		#Incrementamos la "variable i" en 1
			j for4					#Saltamos a la etiqueta for5
		endfor4:

		#For utilizado para "deshidratar" las plantas
		li $t0, 0	#Cargamos en el registro $t0 un "i" iniciado en 0
		li $t1, 5	#Cargamos en el registro $t1 un "n" que indica el tamaño del arreglo, en este caso 5
		for5:
			addi $sp, $sp, -8		#Hacemos "espacio" para los parámetros de la función deshidratar
			jal deshidratar			#Invocamos la función deshidratar
			#Recuperar valor retornado
			sll $t2, $t0, 2			#Calculamos el desplazamiento y lo guardamos en el registro $t2
			add $t3, $t2, $s3		#En el registro $t3 guardamos la dirección de memoria de la casilla a acceder
			#Hacer la resta
			#Insertar la resta en el campo
			addi $t0, $t0, 1		#Incrementamos la "variable i" en 1
			j for5					#Saltamos a la etiqueta for5
		endfor5:

		#For utilizado para imprimir cada sector
		li $t0, 0	#Cargamos en el registro $t0 un "i" iniciado en 0
		li $t1, 5	#Cargamos en el registro $t1 un "n" que indica el tamaño del arreglo, en este caso 5
		for6:
			sll $t2, $t0, 2			#Calculamos el desplazamiento y lo guardamos en el registro $t2
			add $t3, $t2, $s3		#En el registro $t3 guardamos la dirección de memoria de la casilla a acceder
			#Imprimir
			addi $t0, $t0, 1		#Incrementamos la "variable i" en 1
			j for6					#Saltamos a la etiqueta for6
		endfor6:


		j while		#Saltamos a la etiqueta while
	endwhile:

li $v0, 10	#Termnamos la ejecución del programa
syscall

#FALTA HACER QUE SEA EN UN RANGO!!!!!!!!!!!

regar:
	#Establecemos la semilla
	li $v0, 40
	li $a0, 1
	syscall

	#Generamos número aleatorio
	li $v0, 40
	syscall

	addi $sp, $sp, 4	#Recuperamos el espacio utilizado en el stack
	jr $ra				#Retornamos volviendo a la dirección de llamada a la función +4

deshidratacion:
	#Establecemos la semilla
	li $v0, 40
	li $a0, 1
	syscall

	#Generamos número aleatorio
	li $v0, 40
	syscall

	addi $sp, $sp, 8	#Recuperamos el espacio utilizado en el stack
	jr $ra				#Retornamos volviendo a la dirección de llamada a la función +4