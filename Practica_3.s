# Esqueleto PR3
# Nombre y Apellidos: Eduardo González Gutiérrez
# Alu: alu0101461588
# Fecha ultima modificacion: 13 de abril de 2023

maximoElementos=400 # numero de enteros maximo reservado para la matriz 1600 bytes
size=4 # bytes que ocupa un entero
    .data
mat:   .word   100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119
       .word   120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139
       .word   140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159
       .word   160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179
       .word   180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199
       .word   200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219
       .word   220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239
       .word   240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259
       .word   260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279
       .word   280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299
       .word   300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319
       .word   320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339
       .word   340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359
       .word   360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379
       .word   380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399
       .word   400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419
       .word   420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439
       .word   440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459
       .word   460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479
       .word   480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499
       
nfil:   .word   20 # nuemro de filas de la matriz
ncol:   .word   10 # numero de columnas de la matriz

titulo:     .asciiz "\nPráctica PR3 de Principios de Computadores. Manejo de Matrices.\n"
msg_matriz: .asciiz "\nLa matriz es "
msg_x:      .asciiz "x"
separador:  .asciiz "  " # separador entre numeros
newline:    .asciiz "\n"
menu:       .ascii  "\n(1) Cambiar dimensiones\n(2) Intercambiar dos elemento\n"
            .ascii  "(3) Suma elementos del perimetro\n(4) Calcula max y min de la diagonal\n"
            .asciiz "(0) Salir\n\nElija opcion: "
error_op:   .asciiz "\nError: opcion incorrecta.\n"
msg_nfilas: .asciiz "Introduzca numero de filas: "
msg_ncols:  .asciiz "Introduzca numero de columnas: "
error_nfilas:   .asciiz "\nError: dimension incorrecta. Numero de fila incorrecto.\n"
error_ncols:    .asciiz "\nError: dimension incorrecta. Numero de columna incorrecto.\n"
error_dime:     .asciiz "\nError: dimension incorrecta. Excede el maximo numero de elementos (400).\n"
msg_i:      .asciiz "Introduzca fila del primer elemento a cambiar: "
msg_j:      .asciiz "Introduzca columna del primer elemento a cambiar: "
msg_r:      .asciiz "Introduzca fila del segundo elemento a cambiar: "
msg_s:      .asciiz "Introduzca columna del segundo elemento a cambiar: "
msg_suma:   .asciiz "\n\nSuma de los elementos del perímetro: "
msg_max:    .asciiz "\nEl máximo de la diagonal principal es "
msg_min:    .asciiz " y el mínimo "
msg_fin:    .asciiz "\nFin del programa.\n"
strIndice1:	.asciiz	"Indice de la primera columna a intercambiar: "
strIndice2:	.asciiz	"Indice de la segunda columna a intercambiar: "


    .text

main:
  lw $a1,nfil # Numero de filas
  lw $a2,ncol # Numero de columnas
  la $s0,mat # Direccion base de la matriz

  li $v0,4        
  la $a0, titulo # std::cout << \nPráctica PR3 de Principios de Computadores. Manejo de Matrices.\n""
  syscall

  principio:
    li $v0,4        
    la $a0, msg_matriz # std::cout << "La matriz es "
    syscall  

	  li $v0,1
	  move $a0, $a1 # std::cout << nfil;
	  syscall 

    li $v0,4        
    la $a0, msg_x # std::cout << "x"
    syscall  

	  li $v0,1
	  move $a0, $a2 # std::cout << ncol;
	  syscall 

	  li $v0,4
	  la $a0, newline # std::endl;
	  syscall 

    # A continuación se imprime la matriz:
    imprimir_matriz:
	    add	$s1, $zero, $s0 # Cargamos la direccion base de la matriz en $s1
	    li	$t0, 0 # Iterador_filas

      while1:
	      slt	$t5, $t0, $a1 # if (i < nfil) continua
	      beq	$t5, $zero, fin_imprimir_matriz # Se finaliza la impresión de la matriz
	
	      li	$t1, 0 # Iterador_columnas 
	
        while2:
	        slt	$t4, $t1, $a2 # if (j < ncol) continue
	        beq	$t4, $zero, fin_while2	# Se finaliza la impresión de la matriz

	        mul	$t3, $t0, $a2 # $t3 = iterador_filas * ncol
	        add	$t3, $t3, $t1 # $t3 += j

	        mul	$s3, $t3, 4			
	        add	$t3, $s3, $s1	# Se calcula la direccion del elemento $t3 = dir mat[i,j]

	        li	$v0, 1
	        lw	$a0, 0($t3) # Se obtiene dicho elemento y se imprime
	        syscall
	
	        li	$v0, 4
	        la	$a0, separador # Se imprime un separador entre elementos de la matriz std::cout << "    ";
	        syscall
	
	        addi	$t1, $t1, 1 # iterador_columnas++
	        j	while2 # Se ejecuta el bucle de nuevo hasta que se cumpla la primera condicion
        fin_while2:
	    
        li	$v0, 4
	      la	$a0, newline # Se imprime un salto de linea. std::cout << std::endl;
	      syscall
	
	      addi	$t0, $t0, 1 # iterador_filas++
	      j	while1	# Se ejecuta el bucle de nuevo hasta que se cumpla la primera condicion
			
    fin_imprimir_matriz:	

  # Se imprime el menu y se almacena la opcion elegida
  imprimir_menu:
    # $s1 opcion menu
    
    li $v0,4        
    la $a0, menu # std::cout << "menu "
    syscall  

    li $v0,5 
    syscall                                              
    move $s1, $v0 # std::cin >> s1

  Switch:
    beq, $s1, 0, case0 # Opcion que finaliza el programa
    beq, $s1, 1, case1 # Opcion que redimensiona la matriz
    beq, $s1, 2, case2 # Opcion que intercambia dos elementos de la matriz
    beq, $s1, 3, case3 # Opcion que suma los elementos del perimetro
    beq, $s1, 4, case4 # Opcion que calcula el maximo y minimo de la diagonal
    beq, $s1, 5, case5 

    # Comprobamos que la opcion introducida es valida
    blt $s1, $zero error_opcion # opcion < 0
    bgt $s1, 5 error_opcion # opcion > 4


  case0:
    li $v0,4            
    la $a0,msg_fin # cout << "Fin programa";     
    syscall 

    li $v0, 10  # Se finaliza el programa
    syscall


  case1:    
    # $t7 = numero filas para redimensionar
    # $t8 = numero columnas para redimensionar

    li $v0,4        
    la $a0, msg_nfilas  # std::cout << "Introduzca el numero de filas: " << std::endl;
    syscall  

    li $v0,5    
    syscall 
    move $t7, $v0 # std::cin >> $t7
      
    bge $zero, $t7 error_nfils # if (0 >= nfils) error

    li $v0,4       
    la $a0,msg_ncols # std::cout << "Introduzca el numero de columnas: " << std::endl;
    syscall 
      
    li $v0,5    
    syscall                
    move $t8, $v0 # std::cin >> $t8

    bge $zero,$t8 error_ncolum # if (0 >= ncols) error

    mul $t3, $t7, $t8
    bgt $t3,400, error_dimension # if (dimension > 400) error

    # Una vez se comprube que son válidos, actualiza los valores de las filas y las columnas 
    move $a1, $t7 
    move $a2, $t8
    sw $a1,nfil
    sw $a2,ncol

    j principio # Vuelve al inicio para imprimir la nueva matriz


  case2:
    # $t4 filas primer elemento
    # $t5 columnas primer elemento
    # $t6 filas segundo elemento
    # $t7 columnas segundo elemento
    # $t8 direccion de memoria primer elementoa intercambiar
    # $t9 direccion de memoria segundo elemento a intercambiar

    li $v0,4       
    la $a0,msg_i # std::cout << "Introduzca fila del primer elemento a cambiar: " << std::endl;
    syscall 

    li $v0,5
    syscall
    move $t4,$v0 # std::cin >> t4

    bge $t4,$a1,error_nfils # if (fila > nfilas) error
    blt $t4, 0, error_nfils # if (0 > fila) error

    li $v0,4       
    la $a0,msg_j # std::cout << "Introduzca columna del primer elemento a cambiar: " << std::endl;
    syscall 

    li $v0,5
    syscall
    move $t5,$v0 # std::cin >> t5

    bge $t5,$a2,error_ncolum # if (columna > ncols) error
    blt $t5,0,error_ncolum # if (0 >= ncols) error

    li $v0,4       
    la $a0,msg_r # std::cout << "Introduzca fila del segundo elemento a cambiar: " << std::endl;
    syscall 

    li $v0,5
    syscall
    move $t6,$v0 # std::cin >> t6

    bge $t6,$a1,error_nfils # if (fila > nfilas) error
    blt $t6,0,error_nfils # if (0 >= nfils) error

    li $v0,4       
    la $a0,msg_s # std::cout << "Introduzca columna del segundo elemento a cambiar: " << std::endl;
    syscall 

    li $v0,5
    syscall
    move $t7,$v0 # std::cin >> t7

    bge $t7,$a2,error_ncolum # if (columna > ncols) error
    blt $t7,0,error_ncolum # if (0 >= ncols) error
    
    # Calculamos direccion de primer elemento
    mul $t4, $t4, $a2 # t4 = fila primer elemento * ncol
    addu $t4, $t4, $t5 # t4 = t4 + columna primer elemento
    mul $t4, $t4, 4 # t4 = t4 * 4 (cada elemento es de 4 bytes)
    addu $t8, $s0, $t4 # Dirección del primer elemento
    lw $t4, 0($t8) # Cargar el elemento 1 en $t4

    # Calculamos direccion de segundo elemento
    mul $t6, $t6, $a2 # t6 = fila segundo elemento * ncol
    add $t6, $t6, $t7 # t6 = t6 + columna segundo elemento
    mul $t6, $t6, 4 # t6 = t6 * 4 (cada elemento es de 4 bytes)
    add $t9, $s0, $t6 # Dirección del segundo elemento
    lw $t6, 0($t9) # Cargar el elemento 2 en $t6

    # Intercambiar los elementos
    # Elemento 1 -> $t6
    # Elemento 2 -> $t4
    sw $t6, 0($t8)
    sw $t4, 0($t9)

    j principio # Se vuelve al principio para imprimir la matriz


  case3:
    # Inicializar la variable de suma
    li $t9, 0 # $t0 es el registro que usaremos para la suma

    # Recorrer la primera fila de la matriz y sumar sus elementos
    li $t1, 0 # $t1 es el registro que usaremos para el índice de columnas
    la $s0,mat # cargamos en $s0 la direccion base de la matriz
    primera_fila:
      lw $t2, ($s0)  # Cargar el elemento de la matriz en $t2
      add $t9, $t9, $t2   # Sumar el elemento al acumulador
      addi $s0, $s0, 4    # Mover el puntero a la siguiente columna
      addi $t1, $t1, 1    # Incrementar el índice de columna
      bne $t1, $a2, primera_fila  # Repetir hasta que hayamos recorrido toda la fila

    ble $a1,1,resultado # Si solo hay una fila, muestra directamente el resultado

    # Sumar los elementos de la primera columna
    la $s0,mat # Cargamos la direccion base de la matriz
    li $t1,0 # registro para contar las filas que recorremos
    primera_columna:
      lw $t3, 0($s0)         # Cargamos el elemento de la matriz
      add $t9, $t9, $t3      # Sumamos el elemento al contador en $t9
      mul $t0,$a2,4          # Calculamos la direccion del primer elemento de la siguinete fila
      add $s0, $s0, $t0       # Incrementamos la dirección base
      addi $t1, $t1, 1       # Incrementamos el índice de la columna en 1
      bne $t1, $a1, primera_columna  # Salimos del bucle cuando se haya recorrido toda la columna

    bgt $a2,1,fin_restar_primer_elemento # Si solo hay una columna, muestra directamente el resultado
    
    # Si la matriz tiene una unica columna, eliminamos el primer elemento de la suma total
    restar_primer_elemento:
      la $s0,mat # Cargamos la direccion base de la matriz
      lw $t3,0($s0) # Obtenemos el elemento
      sub $t9,$t9,$t3 # Se lo restamos a la suma acumulada
      j resultado # Saltamos a imprimir el resultado
    fin_restar_primer_elemento:

    # Calculamos la direccion del primer elemento de la ultima fila y lo almacenamos en $t0
    la $s0,mat
    sub $t0,$a1,1
    mul $t0,$t0,4
    mul $t0,$t0,$a2
    add $t0, $s0, $t0

    # Sumar los elementos de la ultima fila
    li $t1, 0 # $t1 es el registro que usaremos para el índice de columnas
    la $s0,mat # cargamos la direccion base de la matriz
    ultima_fila:
      lw $t3, 0($t0)     # Cargamos el elemento en $t3
      add $t9, $t9, $t3  # Lo sumamos a la suma acumulada
      addi $t0, $t0, 4   # Movemos la direccion base a la direccion del siguiente elemento
      addi $t1, $t1, 1   # Incrementamos el contador de columnas
      bne $t1, $a2, ultima_fila  # if (contador de columnas != ncol) ultima_fila

    # Nos posicionamos en el primer elemento de la ultima columna
    la $s0,mat
    sub $t1,$a2,1 
    mul $t1,$t1,4
    add $s0,$s0,$t1 

    # Sumar los elementos de la ultima columna
    li $t1,0 # Contador de filas
    ultima_columna:
      lw $t3, 0($s0) # Carga el valor de la última columna en $t3
      add $t9, $t9, $t3 # Suma el valor de la última columna a la variable de suma
      mul $t3,$a2,4
      add $s0,$s0,$t3 # Nos posicionamos en el siguinete elemento de la columna
      add $t1, $t1, 1 # Aumentamos el contador de filas
      bne $t1, $a1, ultima_columna # Salimos del bucle cuando el indice de filas recorridas sea igual al numero de filas de la matriz

    # Obtenemos los valores correspondientes a las posiciones de las esquinas de la matriz, los sumamos y se los restamos al resultado de la suma total del perimetro
    # Elemento fila 1, columna 1
    la $s0,mat # Cargamos la direccion base de la matriz
    lw $t3, 0($s0) # Obtenemos el primer elemento de la matriz
    sub $t9,$t9,$t3 # Se lo restamos al total

    # Elemento nfil, columna 1
    la $s0,mat # Cargamos la direccion base de la matriz
    li $t1,0 # Contador de columnas
    sub $t8,$a1,1 # Condicion para finalizar el bucle
    for_segundo_elemento:
      mul $t7,$a2,4
      add $s0,$s0,$t7 # Calculamos la direccion del elemento
      lw $t3, 0($s0) # Obtenemos el elemento
      add $t1,$t1,1 # Incremento el contador
      bne $t1,$t8,for_segundo_elemento # Repetir hasta que no se hayan recorrido todas las filas
    sub $t9,$t9,$t3 # Se lo restamos al total

    # Elemento fila 1, ncol
    la $s0,mat # Cargamos la direccion base de la matriz
    sub $t7,$a2,1 
    mul $t7,$t7,4
    add $s0,$s0,$t7 # Calculamos la direccion del elemento
    lw $t3, 0($s0) # Obtenemos el elemento
    sub $t9,$t9,$t3 # Se lo restamos al total

    # Elemento nfil, ncol
    la $s0,mat # Cargamos la direccion base de la matriz
    li $t1,0 # Contador
    mul $t8, $a2, 4 # Calculo para avanzar de filas

    sub $t7,$a2,1 
    mul $t7,$t7,4
    add $s0,$s0,$t7 # Calculamos la direccion del primer elemento de la columna

    for_cuarto_elemento:
      lw $t3,0($s0) # Obtenemos el elemento
      add $s0,$s0,$t8 # Pasamos al elemento de la siguiente fila
      add $t1,$t1,1 # Aumentamos el contador
      bne $t1, $a1, for_cuarto_elemento # Se repite hasta haber recorrido todas las filas
    sub $t9,$t9,$t3 # Se lo restamos al total

    resultado:
      li $v0,4       
      la $a0,msg_suma # std::cout << "La suma de los elementos del perimetro es de: " << std::endl;
      syscall 

      li $v0, 1
      move $a0, $t9 # std::cout << $t9
      syscall

      la $s0,mat # Restablecemos la direccion base de la matriz para que a la hora de impirmirla no se vea afectada

    j principio


  case4:
    la $s0,mat # Cargamos la direcciion base de la matriz
    li $t7,0 # maximo o minimo de fil y col

    lw $t8,0($s0) # Inicializo el valor del minimo con el primer elemento de la matriz
    lw $t9,0($s0) # Inicializo el valor del maximo con el primer elemento de la matriz

    # Calculamos el maximo de las filas o columnas
    move $t7,$a1
    min_max:
      bge $a2,$t7,fin_min_max
      move $t7,$a2
    fin_min_max:

    # Los elementos de la diagonal siempre estan a 4*(ncol + 1)
    add $t2,$a2,1 
    mul $t2,$t2,4

    # Bucle for para recorrer la diagonal e ir comprobando los valores maximos y minimos
    li $t5,0 # Iterador bucle
    for:
      lw $t3, ($s0)           # Carga el elemento en $t3
      
      # Comprobamos si el elemento cargado en $t3 es menor que el anterior 
      comprobar_min:
        bgt $t3,$t8,fin_comprobar_min
        move $t8,$t3
      fin_comprobar_min:
      
      # Comprobamos si el elemento cargado en $t3 es mayor que el anterior
      comprobar_max:
        blt $t3,$t9,fin_comprobar_max
        move $t9,$t3
      fin_comprobar_max:

      add $s0,$s0,$t2 # Avanzamos al siguiente elemento con el calculo hecho previamente
      add $t5,$t5,1 # Incrementamos el iterador del bucle
      bne $t5,$t7, for # Mientras el iterador del bucle sea distinto del minimo entre filas y columnas, itera

    li $v0,4       
    la $a0,msg_max # std::cout << "El maximo de la diagonal es: " << std::endl;
    syscall 

    li $v0, 1
    move $a0, $t9 # std::cout << $t8
    syscall

    li $v0,4       
    la $a0,msg_min # std::cout << "El minimo de la diagonal es: " << std::endl;
    syscall 

    li $v0, 1
    move $a0, $t8 # std::cout << $t8
    syscall
    
    la $s0,mat
    j principio



  case5:

    la $t3,mat # Cargamos en $t3 la direccion base de la matriz para la primera columna
    la $t4,mat # Cargamos en $t4 la direccion base de la matriz para la segunda columna
   
    li $v0,4       
    la $a0,strIndice1 # std::cout << "Indice de la primera columna a intercambiar: " << std::endl;
    syscall 

    li $v0,5
    syscall
    move $t6,$v0 # std::cin >> t6

    li $v0,4       
    la $a0,strIndice2 # std::cout << "Indice de la segunda columna a intercambiar: " << std::endl;
    syscall 

    li $v0,5
    syscall
    move $t7,$v0 # std::cin >> t7


    bgt $t7,$a2,error_ncolum # Si las columnas son mayores que el numero de columnas salta a error
    bgt $t6,$a2,error_ncolum # Si las columnas son mayores que el numero de columnas salta a error
    blt $t7,$zero,error_ncolum # Si las columnas son menores que 1 salta a error
    blt $t6,$zero,error_ncolum # Si las columnas son menores que 1 salta a error


    li $t1,0 # Contador de filas
    
    mul $t6,$t6,4 # Accedemos al primer elemento de la primera columna
    add $t3,$t3,$t6 # Nos pocisionamos en el primer elemento elemento de la columna
    mul $t7,$t7,4 # Accedemos al elemento de la segunda columnas
    add $t4,$t4,$t7 # Nos poscionamos en el elemento
    
    bucle1:
      beq $t1,$a1,fin_bucle1
      
      # Obtenemos elemento columna 1
      lw $t8,0($t3) # Cargamos el elemento en $t8
      
      # Obtenemos elemento columna 2
      lw $t9,0($t4) # Cargamos el elemento en $t9

      # Intercambiamos
      sw $t9,0($t3)
      sw $t8,0($t4)

      mul $t5,$a2,4 # ncol * size
      add $t3,$t3,$t5 # Pasamos a la siguinete fila de la primera columna
      add $t4,$t4,$t5 # Pasamos a la siguinete fila de la segunda columna

      add $t1,$t1,1 # Incrementamos contador filas
      j bucle1
    fin_bucle1:
    j principio


  # Gestion de errores
  Errores:
    # Error de opcion del menu incorrecta
    error_opcion:
      li $v0,4
      la $a0, error_op # std::cout << "Opcion incorrecta"
      syscall
      j imprimir_menu

    # Error de filas incorrectas
    error_nfils: 
      li $v0,4            
      la $a0, error_nfilas # std::cout << "\nError: dimension incorrecta. Numero de fila incorrecto.\n"
      syscall 
      j principio

    # Error de columnas incorrectas
    error_ncolum:                                      
      li $v0,4            
      la $a0, error_ncols # std::cout << "\nError: dimension incorrecta. Numero de columna incorrecto.\n"
      syscall 
      j principio
    
    # Error de dimension de la matriz incorrecta
    error_dimension:
      li $v0,4            
      la $a0, error_dime # std::cout << "\nError: dimension incorrecta. Excede el maximo numero de elementos (400).\n"
      syscall 
      j principio
