
	.data

f1:	.word	3
c1:	.word	3
mat1:
	.double	-24.889, 96.682, 48.902,
	.double	22.859, 38.792, -50.634,
	.double	23.377, 22.515, -53.737

f2:	.word	5
c2:	.word	8
mat2:	.double	17.398, -64.737, 87.92, -43.583, -65.409,
	.double	-6.281, -26.854, -72.804, 42.372, -92.196,
	.double	94.358, -12.407, -35.939, -37.41, 57.646,
	.double	19.794, 42.452, 63.236, -91.322, -26.431,
	.double	-42.45, -53.94, 91.52, -14.213, -95.806,
	.double	24.553, 37.837, -41.701, -50.17, -95.97,
	.double	89.555, -32.748, -30.354, -62.494, 8.403,
	.double	-82.708, -77.973, 40.233, 6.65, -51.236

f3:	.word	9
c3:	.word	4
mat3:	.double	-35.67, -17.962, 64.583, -76.465, 57.848, 34.164, 64.766, 35.301, -62.31,
	.double	71.197, -81.711, -11.21, 69.955, 18.382, 12.366, 48.926, -38.619, -79.318,
	.double	-71.465, 77.42, 89.622, 12.849, 51.772, 88.375, 59.922, 20.576, 6.546,
	.double	-3.769, 48.463, -28.636, 55.664, 41.943, -5.08, 18.262, 49.093, -93.235

strTitulo:	.asciiz	"\nEleva matriz\n"
strIntroMatriz:	.asciiz	"\nIntroduce matriz a elevar (1, 2 o 3), 0 para salir): "
strMalMatiz:	.asciiz	"Numero de matriz incorrecto.\n"
strIntroExpo:	.asciiz	"Introduce exponente entero: "
strTermina:	.asciiz	"\nTermina el programa\n"


	.text

# Funcion que eleva un valor a otro
# $f12: numero en doble presicion
# $a0: entero para elevar
eleva:
  addi $sp,$sp,-8
  sw $s2,0($sp)
  sw $ra,4($sp)

  li $s2,1 # Iterador
  li.d $f14,0.0 # Registro para almacenar el resultado
  
  beq $a0,0,cero

  cero:
    li.d $f14,1.0
    j buclefin

  mul.d $f14,$f12,$f12 # Primera potencia

  bucle:
    mul.d $f14,$f14,$f12
    add $s2,$s2,1 # Incrementamos el iterador
    beq $s2,$a0,buclefin
    j bucle
  buclefin:

  mov.d $f12,$f14 # Valor de retorno de la funcion

  lw $s2,0($sp)
  lw $ra,4($sp)
  addi $sp,$sp,8

  jr $ra
eleva_fin:


# Funcion que realiza una potencia
# $a0: direccion base matriz
# $a1: numero de filas 
# $a2: numero de columnas
# $a3: entero 
potencia:
  addi $sp,$sp,-32 # Reservamos espacio en la pila
  sw $s0,0($sp)
  sw $s1,4($sp)
  sw $s2,8($sp)
  sw $s3,12($sp)
  sw $s5,16($sp)
  sw $s6,20($sp)
  s.d $f14,24($sp)
  sw $ra,28($sp)

  move $s0,$a0 # $s0 = direccion base matriz
  move $s1,$a1 # $s1 = numero de filas
  move $s2,$a2 # $s1 = numero de columnas
  move $s3,$a3 # $s3 = entero n
  
  li.d $f14,0.0 # Suma total
  li $s5,0 # Iterador bucle

  mul $s6,$s1,$s2 # dimension matriz para condicion de parada

  buclematriz:
    l.d $f12,0($s0) # Cargo el elemento de la matriz
    move $a0,$s3 # Cargo el entero para elevar
    jal eleva 
    
    add.d $f14,$f14,$f12 # Sumo al valor acumulado
    add $s0,$s0,4 # Avanzamos al siguinete elemento de la matriz
    add $s5,$s5,1 # Incrementamos el contador
    beq $s5,$s6,finbuclematriz # Condicion de parada
    j buclematriz
  finbuclematriz:

  mov.d $f12,$f14 # Valor de retorno de la funcion

  lw $s0,0($sp)
  lw $s1,4($sp)
  lw $s2,8($sp)
  lw $s3,12($sp)
  lw $s5,16($sp)
  lw $s6,20($sp)
  l.d $f14,24($sp)
  lw $ra,28($sp)
  addi $sp,$sp,32

  jr $ra

potencia_fin:



#     int numMat; -> $s0
#     int n; -> $s2
main:
#   std::cout << "\nEleva matriz\n";

	li	$v0,4
	la	$a0,strTitulo
	syscall

#   while(true) {
while_true:
#     std::cout << "\nIntroduce matriz a elevar (1, 2 o 3), 0 para salir): ";
	li	$v0,4
	la	$a0,strIntroMatriz
	syscall

#     int numMat; -> $s0
#     std::cin >> numMat;
	li	$v0,5
	syscall
	move	$s0,$v0
#     if (numMat == 0) break;
	beqz	$s0,while_true_fin
#     if ((numMat < 0) || (numMat > 3)) {
if_mat_mal:
	bltz	$s0,if_mat_mal_then
	ble	$s0,3,if_mat_mal_fin
if_mat_mal_then:
#       std::cout << "Numero de matriz incorrecto.\n";
	li	$v0,4
	la	$a0,strMalMatiz
	syscall
#       continue;
	b	while_true
#     }
if_mat_mal_fin:

#     std::cout << "Introduce exponente entero: ";
	li	$v0,4
	la	$a0,strIntroExpo
	syscall

#     int n; -> $s2
#     std::cin >> n;
	li	$v0,5
	syscall
	move	$s2,$v0

#
# Invocar la función con los datos de la matriz seleccionada y entero introducido
#
# Imprimir el `double` devuelto por la función (sin texto previo ni salto de linea)
#

	b	while_true
while_true_fin:
	li	$v0,4
	la	$a0,strTermina
	syscall

	li	$v0,10
	syscall
