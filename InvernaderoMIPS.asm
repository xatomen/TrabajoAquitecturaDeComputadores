.data
	num1: .word 5	#número 1
	num2: .word 7	#número 2
	num3: .word	#número 3 para guardar resultado
.text

main:

li $v0, 10
syscall