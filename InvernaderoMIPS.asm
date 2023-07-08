.data
	variable1: .word
	variable2: .word
	humedad_inicial: .word
	SectoresInverdadero: .word 0,0,0,0,0
	newline: .asciiz "\n"
.text

#AGREGAR SALTOS DE LINEA PARA CADA FOR!!!!!!!!!!!!!
#O ALMENOS UNA SEPARACION!!!!!!!!!!!

#EN V0 NO SE GUARDA EL RANDOM!!! VER EN DONDE SE GUARDA

main:

	#Cargamos las variables en registros
	lw $s0, variable1
	lw $s1, variable2
	lw $s2, humedad_inicial
	la $s3, SectoresInverdadero     #Es load adress porque estamos cargando la dirección de memoria

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
		beq $t0, $t1, endfor2	#Si i es igual a n, salimos del for
		sll $t2, $t0, 2			#Calculamos el desplazamiento y lo guardamos en el registro $t2
		add $t3, $t2, $s3		#En el registro $t3 guardamos la dirección de memoria de la casilla a acceder
		
        lw $t4, 0($t3)          #Guardamos en $t4 el valor que contiene la casilla del arreglo
        move $a0, $t4           #Guardamos en el registro $a0 el valor a imprimir
        li $v0, 1               #Cargamos en $v0 el código para imprimir
        syscall                 #Imprimimos

		addi $t0, $t0, 1		#Incrementamos la "variable i" en 1
		j for2					#Saltamos a la etiqueta for1
	endfor2:

	#Salto de linea
	li $v0, 4        # Carga el valor 4 en $v0, que corresponde a la llamada del sistema para imprimir una cadena
	la $a0, newline  # Carga la dirección de la etiqueta "newline" en $a0
	syscall          # Realiza la llamada del sistema

	while:
		#For utilizado para "regar" las plantas
		li $t0, 0	#Cargamos en el registro $t0 un "i" iniciado en 0
		li $t1, 5	#Cargamos en el registro $t1 un "n" que indica el tamaño del arreglo, en este caso 5
		for3:
            beq $t0, $t1, endfor3	#Si i es igual a n, salimos del for
			addi $sp, $sp, -4		#Hacemos "espacio" para el parámetro de la función regar
			jal regar				#Invocamos la función regar
			move $t5, $v0           #Recuperar valor retornado

            sll $t2, $t0, 2			#Calculamos el desplazamiento y lo guardamos en el registro $t2
            add $t3, $t2, $s3		#En el registro $t3 guardamos la dirección de memoria de la casilla a acceder
            lw $t4, 0($t3)          #Guardamos en $t4 el valor que contiene la casilla del arreglo
            if1:
                slti $t7, $t4, 30       #Si el valor de la casilla es menor que 30, entonces $t7 = 1
                beq $t7, $zero, endif1  #Si la casilla es mayor que 30, entonces no realizamos el regado y saltamos a endif1

                add $t6, $t4, $t5       #Guardamos en $t6 el valor de la suma entre el valor retornado al regar y el valor que contiene la casilla
                sw $t6, 0($t3)          #Guardamos el valor de final de la casilla, dentro de la casilla correspondiente
            endif1:
                
			addi $t0, $t0, 1		#Incrementamos la "variable i" en 1
			j for3					#Saltamos a la etiqueta for4
		endfor3:

		#For utilizado para imprimir cada sector
		li $t0, 0	#Cargamos en el registro $t0 un "i" iniciado en 0
		li $t1, 5	#Cargamos en el registro $t1 un "n" que indica el tamaño del arreglo, en este caso 5
		for4:
            beq $t0, $t1, endfor4	#Si i es igual a n, salimos del for
			sll $t2, $t0, 2			#Calculamos el desplazamiento y lo guardamos en el registro $t2
			add $t3, $t2, $s3		#En el registro $t3 guardamos la dirección de memoria de la casilla a acceder

            lw $t4, 0($t3)          #Guardamos en $t4 el valor que contiene la casilla del arreglo
            move $a0, $t4           #Guardamos en el registro $a0 el valor a imprimir
            li $v0, 1               #Cargamos en $v0 el código para imprimir
            syscall                 #Imprimimos

			addi $t0, $t0, 1		#Incrementamos la "variable i" en 1
			j for4					#Saltamos a la etiqueta for5
		endfor4:

		#Salto de linea
		li $v0, 4        # Carga el valor 4 en $v0, que corresponde a la llamada del sistema para imprimir una cadena
		la $a0, newline  # Carga la dirección de la etiqueta "newline" en $a0
		syscall          # Realiza la llamada del sistema

		#For utilizado para "deshidratar" las plantas
		li $t0, 0	#Cargamos en el registro $t0 un "i" iniciado en 0
		li $t1, 5	#Cargamos en el registro $t1 un "n" que indica el tamaño del arreglo, en este caso 5
		for5:
            beq $t0, $t1, endfor5	#Si i es igual a n, salimos del for
			addi $sp, $sp, -8		#Hacemos "espacio" para los parámetros de la función deshidratar
			jal deshidratar			#Invocamos la función deshidratar
			move $t5, $v0           #Recuperar valor retornado

			sll $t2, $t0, 2			#Calculamos el desplazamiento y lo guardamos en el registro $t2
			add $t3, $t2, $s3		#En el registro $t3 guardamos la dirección de memoria de la casilla a acceder
			sub $t6, $t4, $t5       #Guardamos en $t6 el valor de la resta entre el valor retornado al deshidratar y el valor que contiene la casilla
            sw $t6, 0($t3)          #Guardamos el valor de final de la casilla, dentro de la casilla correspondiente

			addi $t0, $t0, 1		#Incrementamos la "variable i" en 1
			j for5					#Saltamos a la etiqueta for5
		endfor5:

		#For utilizado para imprimir cada sector
		li $t0, 0	#Cargamos en el registro $t0 un "i" iniciado en 0
		li $t1, 5	#Cargamos en el registro $t1 un "n" que indica el tamaño del arreglo, en este caso 5
		for6:
            beq $t0, $t1, endfor6	#Si i es igual a n, salimos del for
			sll $t2, $t0, 2			#Calculamos el desplazamiento y lo guardamos en el registro $t2
			add $t3, $t2, $s3		#En el registro $t3 guardamos la dirección de memoria de la casilla a acceder
			
            lw $t4, 0($t3)          #Guardamos en $t4 el valor que contiene la casilla del arreglo
            move $a0, $t4           #Guardamos en el registro $a0 el valor a imprimir
            li $v0, 1               #Cargamos en $v0 el código para imprimir
            syscall                 #Imprimimos
            
			addi $t0, $t0, 1		#Incrementamos la "variable i" en 1
			j for6					#Saltamos a la etiqueta for6
		endfor6:

		#Salto de linea
		li $v0, 4        # Carga el valor 4 en $v0, que corresponde a la llamada del sistema para imprimir una cadena
		la $a0, newline  # Carga la dirección de la etiqueta "newline" en $a0
		syscall          # Realiza la llamada del sistema

		j while		#Saltamos a la etiqueta while
	endwhile:

li $v0, 10	#Termnamos la ejecución del programa
syscall

#FALTA HACER QUE SEA EN UN RANGO!!!!!!!!!!!
#QUITAR EL IMPRIMIR DENTRO DE LAS FUNCIONES AL FINAL!!!!!!!!!!!!!!!!

regar:
	
	#li $a1, 40			#Rango superior
	#li $v0, 42			#Cargamos en $v0 el código para generar el número aleatorio con un límite superior
	#syscall				#Obtenemos el número aleatorio y lo guardamos en el registro $v0
    
	# seed the random number generator

	# get the time
	li	$v0, 30		# get time in milliseconds (as a 64-bit value)
	syscall

	move	$t8, $a0	# save the lower 32-bits of time

	# seed the random generator (just once)
	li	$a0, 1		# random generator id (will be used later)
	move 	$a1, $t8	# seed from time
	li	$v0, 40		# seed random number generator syscall
	syscall

	li $a0, 1
	li $a1, 30
	li $v0, 42
	syscall


    move $t4, $a0       #Guardamos el número aleatorio en el registro $t4

    move $v0, $t4       #Guardamos en el registro $v0 el valor a retornar, es decir, el valor aleatorio generado
	addi $sp, $sp, 4	#Recuperamos el espacio utilizado en el stack
	jr $ra				#Retornamos volviendo a la dirección de llamada a la función +4

deshidratar:
	# seed the random number generator

	# get the time
	li	$v0, 30		# get time in milliseconds (as a 64-bit value)
	syscall

	move	$t8, $a0	# save the lower 32-bits of time

	# seed the random generator (just once)
	li	$a0, 1		# random generator id (will be used later)
	move 	$a1, $t8	# seed from time
	li	$v0, 40		# seed random number generator syscall
	syscall

	li $a0, 1
	li $a1, 30
	li $v0, 42
	syscall

    move $t4, $a0       #Guardamos el número aleatorio en el registro $t4
    
    move $v0, $t4       #Guardamos en el registro $v0 el valor a retornar, es decir, el valor aleatorio generado
	addi $sp, $sp, 8	#Recuperamos el espacio utilizado en el stack
	jr $ra				#Retornamos volviendo a la dirección de llamada a la función +4