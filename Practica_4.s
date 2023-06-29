# Autor: Eduardo González Gutiérrez
# Alu: alu0101461588
# Fecha última modificacion: 28 de abril de 2023
# Comentarios: Las subrutinas funcioann correctamente, sin embargo, en los tests de subrutinas por separados, no terminan de funcionar todas, y si se le pasa al test 
#              la subrutia "print_vector", da un error que no he conseguido descubrir y que impide que se sigan ejecutando los test de subrutinas por separado al resto
#              de las funciones.       

size = 4     # bytes que ocupa cada elemento
maxdim = 40  # dimension maxima que puede tener un vector
  .data
v1:         .space 160
v2:         .space 160  
n1:         .word 0 # numero eltos vector 1. Inicialmente suponemos vacios
n2:         .word 0 # numero eltos vector 2. Inicialmente suponemos vacios
space:      .asciiz " "
newline:    .asciiz "\n"
title:      .asciiz "\nPractica 4 de Principios de Computadores. Subrutinas.\n"
menu:       .ascii  "\n(1) Cambiar dimension de un vector\n(2) Cambiar un elemento de un vector\n"
            .ascii  "(3) Invertir un vector\n(4) Calcular el producto escalar de dos vectores\n"
            .asciiz "(0) Salir\n\nElija opcion: ";
cabvec:     .asciiz "\nVector con dimension "
error_op:   .asciiz "\nError: opcion incorrecta.\n"
elige_vec:  .asciiz "\nElija vector para realizar la operacion (1) para v1 (2) para v2: "
elige_elto: .asciiz "\nElija el indice del elemento a cambiar: "
newval:     .asciiz "\nIntroduce nuevo valor para el elemento elegido: "
newdim:     .asciiz "\nIntroduzca nueva dimension para el vector (1-40): "
error_dim:  .asciiz "\nError: Dimension incorrecta.\n"
error_ind:  .asciiz "\nError: Indice incorrecto.\n"
error_d_dim:    .asciiz "\nError: Los vectores tienen distinta dimension.\n"
msg_prodesc:    .asciiz "\nEl producto escalar de los vectores es: "
msg_fin:    .asciiz "\nFIN DEL PROGRAMA."


  .text

main:
  addi $sp,$sp,-8 # Reservamos espacio en la pila para dos valores
  sw $s2,0($sp) # Almacenamos el numero de elementos del vector 1 en la pila
  sw $s3,4($sp) # Almacenamos el numero de elementos del vector 2 en la pila
  li $s2,40 # Numero de elementos del vector 1
  li $s3,40 # Numero de elementos del vector 2

  li $v0,4        
  la $a0, title # std::cout << "\nPractica 4 de Principios de Computadores. Subrutinas.\n"
  syscall

  # Rellenamos el vector 1 con 40 elementos
  li $t1,0 # Contador de posiciones vectores
  li.s $f20,10.0 # Primer valor vector
  la $a0,v1 # Direccion base vector1

  rellenar1:
    beq $t1,40,fin_rellenar1
    mul $t2,$t1,4
    add $t2,$t2,$a0
    mtc1 $t1,$f4
    cvt.s.w $f4,$f4
    add.s $f4,$f4,$f20
    s.s $f4,0($t2)
    add $t1,1
    j rellenar1
  fin_rellenar1:

  # Rellenamos el vector 2 con 40 elementos
  li $t1,0 # Contador de posiciones vectores
  li.s $f20,40.0 # Primer valor vector
  la $a0,v2 # Direccion base vector2

  rellenar2:
    beq $t1,40,fin_rellenar2
    mul $t2,$t1,4
    add $t2,$t2,$a0
    mtc1 $t1,$f4
    cvt.s.w $f4,$f4
    sub.s $f4,$f20,$f4
    s.s $f4,0($t2)
    add $t1,1
    j rellenar2
  fin_rellenar2:

  # Comienzo del programa 
  principio:
    # Imprime vector 1
    primer_vector:
      li $v0,4        
      la $a0, cabvec # std::cout << "vector con dimension: " << std::endl;
      syscall

      move $a1,$s2 # Cargamos el numero de elementos del vector

      li $v0,1
	    move $a0, $a1 # std::cout << dimension vector 1;
	    syscall 

      la $a0, newline # std::cout << std::endl;
      li $v0, 4
      syscall

      la $a0, v1 # $a0 direccion base del vector1
      move $a1,$s2 # Cargamos el numero de elementos del vector 1
      la $a2,space # Cargamos cadena "space"
      jal print_vec # Salto a funcion que imprime el vector

      la $a0, newline # std::cout << std::endl;
      li $v0, 4
      syscall

    # Imprime vector 2
    segundo_vector:
      li $v0,4        
      la $a0, cabvec # std::cout << "vector con dimension: " << std::endl;
      syscall

      move $a1,$s3 # Cargamos el numero de elementos del vector

      li $v0,1
	    move $a0, $a1 # std::cout << dimension vector 2;
	    syscall 

      la $a0, newline # std::cout << std::endl;
      li $v0, 4
      syscall

      la $a0, v2 # $a0 direccion base del vector2
      move $a1,$s3 # Cargamos el numero de elementos del vector 2
      la $a2,space # Cargamos la cadena "space"
      jal print_vec # Salto a funcion que imprime el vector

      la $a0, newline # std::cout << std::endl;
      li $v0, 4
      syscall


    menu_opciones:
      li $v0,4        
      la $a0, menu # std::cout << menu << std::endl;
      syscall

      li $v0,5 
      syscall 
      move $t0, $v0 # std::cin >> $t0

      bltz $t0, error_opcion # Si es menor que 0, va a error_opcion
      bgt $t0, 5, error_opcion # Si es mayor que 4, va a error_opcion
      beq $t0, 0, case0 # case0 Finaliza programa
      beq $t0, 1, case1 # case1 Cambiar dimension
      beq $t0, 2, case2 # case2 Cambiar elemento vector
      beq $t0, 3, case3 # case3 Invertir vector
      beq $t0, 4, case4 # case4 Producto escalar
      beq $t0, 5, case5 # case4 Modificacion

  Switch:
    case0:
      la $a0, msg_fin # std::cout << "Fin Programa"
      li $v0, 4
      syscall

      li $v0, 10 # Finaliza el programa
      syscall


    case1:
      # $t1: vector elegido
      # $s4: nueva dimension vector

      la $a0, elige_vec # std::cout << "\nElija vector para realizar la operacion (1) para v1 (2) para v2: ";
      li $v0, 4
      syscall

      li $v0,5 
      syscall 
      move $t1, $v0 # std::cin >> $t1

      bgt $t1,2,error_opcion # Si el vector elegido es mayor que 2, salta a error_opcion
      blt $t1,1,error_opcion # Si el vector elegido el menor que 1, salta a error_opcion

      la $a0, newdim # std::cout << "\nIntroduzca una nueva dimension para el vector elegido: ";
      li $v0, 4
      syscall

      li $v0,5 
      syscall 
      move $s4, $v0 # std::cin >> $s4
      
      bgt $s4,40,error_dimension # Si la dimension es mayor que 40 error_dimension
      ble $s4,0,error_dimension # Si la dimension es menor que 0 error_dimension

      beq $t1,1,vector_1 # Si opcion elegida es 1, va a vector_1
      beq $t1,2,vector_2 # Si opcion elegida es 2, va a vector_2

      vector_1:
        move $s2,$s4 # Actualizamos el valor de la dimension del vector 1 ($s2 == $s4)
        la $a0,v1 # $a0 = direccion base vector1
        j principio # Salta al principio para imprimir los vectores modificados
 
      vector_2:
        move $s3,$s4 # Actualizamos el valor de la dimension del vector 1 ($s3 == $s4)
        la $a0,v2 # $a0 = direccion base vector2
        j principio # Salta al principio para imprimir los vectores modificados


    case2:
      # $s4: vector sobre el que vamos a realizar la operacion
      # $s6: indice del elemento a cambiar
      # $f20: elemento para sustituir

      li $v0,4        
      la $a0, elige_vec # std::cout << "Elige el vector sobre el que realizar la operacion  " << std::endl;
      syscall

      li $v0,5 
      syscall 
      move $s4, $v0 # std::cin >> $s4

      blt $s4,1,error_opcion # Si el vector elegido el menor que 1, error_opcion
      bgt $s4,2,error_opcion # Si el vector elegido es mayor que 2, error_opcion

      beq $s4,1,opcion1 # si el vector elegido es el 1 saltamos a opcion1
      beq $s4,2,opcion2 # si el vector elegido es el 2 saltamos a opcion2

      opcion1:
        li $v0,4        
        la $a0, elige_elto # std::cout << "Elige el indice del elemento a cambiar  " << std::endl;
        syscall

        li $v0,5 
        syscall 
        move $s6, $v0 # std::cin >> $s6

        bge $s6,$s2,error_indice # Si el indice introducido es mayor que 40, salta a error_indice
        blt $s6,0,error_indice # Si el indice introducido es menor que 0, salta a error_indice

        li $v0,4        
        la $a0, newval # std::cout << "Introduzca un nuevo valor para cambiar  " << std::endl;
        syscall

        li $v0,6 
        syscall 
        mov.s $f20, $f0 # std::cin >> $f20

        la $a0,v1  # Cargamos la direccion base del vector 1
        move $a1,$s6 # $a1 = indice del elemento a cambiar
        mov.s $f12,$f20 # $a2 = nuevo valor
        jal change_elto # Salta a funcion "change_elto"
        la $a0,v1 # Restaura la direccion base del vector 1
        j principio # Salta al comienzo
      
      opcion2:
        li $v0,4        
        la $a0, elige_elto # std::cout << "Elige el indice del elemento a cambiar  " << std::endl;
        syscall

        li $v0,5 
        syscall 
        move $s6, $v0 # std::cin >> $s6

        bge $s6,$s3,error_indice # Si el indice introducido es mayor que 40, salta a error_indice
        blt $s6,0,error_indice # Si el indice introducido es menor que 0, salta a error_indice

        li $v0,4        
        la $a0, newval # std::cout << "Introduzca un nuevo valor para cambiar  " << std::endl;
        syscall

        li $v0,6 
        syscall 
        mov.s $f20, $f0 # std::cin >> $f20
      
        la $a0,v2 # Cargamos la direccion base del vector 2
        move $a1,$s6 # $a1 = indice del elemento a cambiar
        mov.s $f12,$f20 # $a2 = nuevo valor
        jal change_elto # Salta a funcion "change_elto"
        la $a0,v2 # Restaura la direccion base del vector 2
        j principio # Salta al comienzo


    case3:
      # $t1: vector elegido

      la $a0, elige_vec # std::cout << "\nElija vector para realizar la operacion (1) para v1 (2) para v2: ";
      li $v0, 4
      syscall
    
      li $v0,5 
      syscall 
      move $t1, $v0 # std::cin >> $t1

      bgt $t1,2,error_opcion # Si el vector elegido es mayor que 2, error_opcion
      blt $t1,1,error_opcion # Si el vector elegido es menor que 1, error_opcion

      beq $t1,1,vector_uno # Si el vector elegido es el uno, salta a "vector_uno"
      beq $t1,2,vector_dos # Si el vector elegido es el dos, salta a "vector_dos"

      vector_uno:
        la $a0,v1 # Cargamos la direccion base del vector 1
        move $a1,$s2 # Cargamos el numero de elementos del vector 1
        jal mirror # Invocamos a funcion mirror
        j principio # Saltamos al principio
      vector_dos:
        la $a0,v2 # Cargamos la direccion base del vector 2
        move $a1,$s3 # Cargamos el numero de elementos del vector 2
        jal mirror # Invocamos a funcion mirror
        j principio # Saltamos al principio


    case4:
      bne $s2,$s3,error_dimension_producto # Si las dimensiones no son iguales salta, error_dimension_producto
      
      la $a0, msg_prodesc # std::cout << "\nEl producto escalar de los vectores es: ";
      li $v0, 4
      syscall

      la $a0,v1 # Cargamos la direccion base del vector1
      la $a1,v2 # Cargamos la direccion base del vector2
      move $a2,$s2 # Cargamos el numero de elementos de cualquier vector (puesto que ambos tienen la misma dimension)

      jal prod_esc # LLamamos a la funcion prod_esc
      
      li $v0, 2
      mov.s $f12,$f0 # std::cout << resultado producto escalar;
      syscall

      j principio # Saltamos al principio

  lw $s2,0($sp) # Restauramos el registro $s2 de la pila
  lw $s3,4($sp) # Restauramos el registro $s3 de la pila
  addi $sp,$sp,8 # Restauramos la pila



    case5:

      li $v0,4        
      la $a0, elige_vec # std::cout << "Elige el vector sobre el que realizar la operacion  " << std::endl;
      syscall

      li $v0,5 
      syscall 
      move $s4, $v0 # std::cin >> $s4

      blt $s4,1,error_opcion # Si el vector elegido el menor que 1, error_opcion
      bgt $s4,2,error_opcion # Si el vector elegido es mayor que 2, error_opcion

      beq $s4,1,opcion_1_vector # si el vector elegido es el 1 saltamos a opcion1
      beq $s4,2,opcion_2_vector # si el vector elegido es el 2 saltamos a opcion2

      opcion_1_vector:
        la $a0,v1 # Cargamos la direccion base del vector1
        move $a1,$s2 # Cargamos numero elementos vector1
        jal sel_dir_rec # Llamamos a funcion
        j principio

      opcion_2_vector:
        la $a0,v2 # Cargamos la direccion base del vector1
        move $a1,$s3 # Cargamos numero elementos vector1
        jal sel_dir_rec # Llamamos a funcion
        j principio


  Errores:
    # Error opcion incorrecta
    error_opcion:
      la $a0, error_op # std::cout << "\nError: opcion incorrecta.\n";
      li $v0, 4 
      syscall
      j principio

    # Error dimension incorrecta
    error_dimension:
      la $a0, error_dim # std::cout << "\nError: Dimension incorrecta.\n";
      li $v0, 4
      syscall
      j principio
    
    # Error indice incorrecto
    error_indice:
      la $a0, error_ind # std::cout << "\nError: Indice incorrecto.\n";
      li $v0, 4
      syscall
      j principio
    
    # Error vectores con dimension incorrecta para calcular el producto escalar
    error_dimension_producto:
      la $a0, error_d_dim # std::cout << "\nError: Los vectores tienen distinta dimension.\n";
      li $v0, 4
      syscall
      j principio


# -------------------------------------------------------------- FUNCIONES ------------------------------------------------------------

  # FUNCION PRINT_VEC
  # $a0: direccion base vector
  # $a1: numero elementos vector
  # $a2: cadena space
  print_vec:
    addi $sp,$sp,-4 # Reservamos espacio en la pila para un elemento
    li $s4, 0 # Inicializamos contador de elementos para la condicion del bucle
    sw $s4, 0($sp) # Guardar registro $s4 (contador) en la pila
    move $t4,$a0 # Cargamos la direccion base del vector en $t4
    
    bucle:
      bge $s4,$a1,fin_bucle # if (contador >= dimension) fin_bucle 

      l.s $f12,0($t4) # imprimimos el elemento
      li $v0,2
      syscall

      move $a0,$a2 # std::cout << " "
      li $v0,4
      syscall

      add $t4,$t4,4 # Avanzamos al siguiente elemento del vector
      add $s4,$s4,1 # Incrementamos contador ($s4++)
      j bucle # Iteramos 
    fin_bucle:
    
    lw $s4, 0($sp) # Restauramos el registro $s4
    addi $sp,$sp,4 # Restauramos la pila
    jr $ra # Retornamos de la funcion 
  print_vec_fin:


  # FUNCION CHANGE_ELTO
  # $a0: direccion base vector
  # $a1: indice del elemento a modificar
  # $a2: nuevo valor
  change_elto:
    move $t4,$a0 # $t4 = direccion base vector
    mul $t1, $a1, 4 # $t1 = índice * 4
    add $t4, $t4, $t1 # $t4 = dirección del elemento a cambiar
    s.s $f12, ($t4) # Guardamos el nuevo valor en la dirección calculada
    jr $ra # Volvemos a la rutina que invoco la funcion
  change_elto_fin:


  # FUNCION MIRROR
  # $a0: dirección base del vector
  # $a1: número de elementos del vector
  mirror:
    addi $sp,$sp,-4 # Reservamos espacio en la pila para dos elementos
    sw $ra, 0($sp) # Guardamos la direccion de retorno de la funcion en la pila

    sub $a2,$a1,1 # numero elementos - 1 ($a2 = indice ultimo elemento)
    li $a1,0 # Indice primer elemento inicializado a 0
    
    bucle_mirror:
      bge $a1,$a2,fin_bucle_mirror # Si el contador de elementos es menor que 1 finaliza el bucle 
      jal swap # Llamamos a la funcion swap

      add $a1,$a1,1 # Avanzamos al indice del siguiente elemento por la izquierda
      sub $a2,$a2,1 # Avanzamos al indice del siguiente elemento por la derecha 
      j bucle_mirror # Iteramos en el bucle
    fin_bucle_mirror:

    lw $ra, 0($sp) # Restauramos direccion de retorno de la funcion
    addi $sp,$sp,4 # Restauramos la pila
    jr $ra # Retornamos a la funcion invocante
  mirror_fin:


  # SWAP
  # $a0: direccion base vector
  # $a1: indice primer elemento
  # $a2: indice segundo elemento
  swap:
    mul $t5,$a1,4 
    add $t0,$a0,$t5 # Direccion de memoria del primer elemento

    mul $t5,$a2,4
    add $t1,$a0,$t5 # Direccion de memoria del segundo elemento

    l.s $f5, 0($t0) # Cargamos primer elemento
    l.s $f6, 0($t1) # Cargamos segundo elemento
    
    s.s $f5, 0($t1) # Guardamos primer elemento en segunda direccion
    s.s $f6, 0($t0) # Guardamos segundo elemento en primera direccion

    jr $ra # Retornamos a la funcion invocante (mirror)
  swap_fin:


  # PROD_ESC
  # $a0: direccion base primer vector
  # $a1: direccion base segundo vector
  # $a2: numero elementos vectores
  prod_esc:
    addi $sp,$sp,-8 # Reservamos espacio en la pila para dos elementos
    li $s4, 0 # Inicializamos el contador de elementos del vector
    sw $s4, 0($sp) # Guardamos el registro $s4 en la pila
    sw $ra, 4($sp) # Guardamos la direccion de retorno de funcion en la pila

    sub $a2,$a2,1 # Numero de elementos - 1 para iteracion del bucle ($a2 = nelementos - 1)
    li.s $f14,0.0 # Inicializamos el acumulador del producto escalar

    bucle_producto:
      bgt $s4,$a2,bucle_producto_fin # Si el contador de elementos es mayor que el numero de elementos, finaliza el bucle

      l.s $f12,($a0) # Obtenemos elemento del vector1
      l.s $f13,($a1) # Obtenemos elemento del vector2
      
      jal mult_add # Llamamos a funcion mult_add

      mov.s $f14,$f0 # Actualizamos el acumulador retornado de la funcion mult_add
      
      add $a0,$a0,4 # Avanzamos al siguiente elemento del primer vector
      add $a1,$a1,4 # Avanzamos al siguiente elemento del segundo vector
      add $s4,$s4,1 # Incremenetamos el contador de elementos

      j bucle_producto # Iteramos el bucle
    bucle_producto_fin:

    mov.s $f0,$f14 # Cargamos el acumulador al registro de retorno de funcion $f0
    lw $s4, 0($sp) # Restauramos registro $s4
    lw $ra, 4($sp) # Restauramos direccion retorno de funcion
    addi $sp,$sp,8 # Restauramos la pila 
    jr $ra # Retornamos a la funcion invocante
  prod_esc_fin:


  # MULT_ADD
  # $f12: primer valor
  # $f13: segundo valor
  # $f14: acumulador
  mult_add:
    mul.s $f15,$f12,$f13 # Multiplicamos los elementos
    add.s $f14,$f14,$f15 # Sumamos al acumulador
    mov.s $f0,$f14 # Retornamos el acumulador cargandolo en $f0
    jr $ra # Retornamos a la funcion invocante
  mult_add_fin:


  # MODIFICACION
  # $a0: dir base vector
  # $a1: numero elementos vector
  sel_dir_rec:
    move $s5,$a0 # Cargamos la direccion base del vector
    move $s4,$a0 # Cargamos de nuevo la direccion base del vector
    li $s7,0 # Indice1
    li $s6,1 # Indice2    


    addi $sp,$sp,-16 # Reservamos espacio en la pila para elementos
    sw $s5, 0($sp) # Guardamos el registro $s3 en la pila
    sw $s4, 4($sp) # Guardamos el registro $s4 en la pila
    sw $s7, 8($sp) # Guardamos el registro $s7 en la pila
    sw $s6, 12($sp) # Guardamos el registro $s6 en la pila
    sw $ra, 16($sp) # Guardamos la direccion de retorno de funcion en la pila
    

    lw $t1,0($s5) # Obtenemos primer elemento del vector
    ble $a1,1,sel_dir_rec_fin # Caso base

    loop:
      add $s4,$s4,1 # Avanzamos la siguiente elemento el vector
      add $s6,$s6,1 # Incrementamos el indice2
      lw $t2,0($s4) # Cargamos el siguiente valor del vector
      bge $t2,$t1,loop # Si el valor actual es mayor que el primer valor, vuelve al bucle 
      
      move $a1,$s7 # Movemos al registro a1 el valor del indice 1 para llmara a swap
      move $a2,$s6 # MOvemos al registro a2 el valor del indice 2 para llamar a swap 
      jal swap # Llamada a funcion swap ($a0 = dir base, a1 = indice1, $a2 = indice2)
    fin_loop:
    
    add $s5,$s5,1 # Avanzamos al siguiente elemento del vector 
    add $s7,$s7,1 # Incrementamos el indice1
    sub $a1,$a1,1 # Decrementamos el numero de elementos del vector
    jal sel_dir_rec
  sel_dir_rec_fin:
    
  lw $s5, 0($sp) # Restauramos registro $s4
  lw $s4, 4($sp) # Restauramos direccion retorno de funcion
  lw $s7, 8($sp) # Restauramos registro $s4
  lw $s6, 12($sp) # Restauramos direccion retorno de funcion  
  lw $ra, 16($sp) # Restauramos direccion retorno de funcion
  addi $sp,$sp,16
  jr $ra # Volvemos al llamador



