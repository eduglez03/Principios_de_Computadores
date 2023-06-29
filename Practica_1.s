# Autor: Eduardo González Gutiérrez
# Correo electrónico: alu0101461588@ull.edu.es
# Fecha: 7 de marzo de 2023

# -------------------------------------------------------------------------------------------- C++ -----------------------------------------------------------------------------------------------
##include<iostream>
##include<cmath>

#int main(void) {
#    double x,error,sen_x, termino,numerador,error_calculado,old_senx;
#    int n,denominador,signo; //iteraciones
#    std::cout << "\n\nAproximación a sen(x) (-1 <= x <= 1) con un error máximo, usando Taylor\n";
#    do {
#        do {
#        std::cout << "\n\nIntroduzca el valor de x (-1 <= x <= 1): ";
#        std::cin >> x;
#        } while ( (x < -1) || (x > 1));
#        do {
#            std::cout << "\nIntroduzca el error maximo permitido en la aproximación (0 < error < 1) (error <= 0 sale del programa): ";
#            std::cin >> error;
#        } while (error >= 1);
#        if (error <= 0) break;
#        n = 0; // iteraciones
#        numerador = x; // primer numerador del termino para n=0
#        denominador = 1; // primer denominador del termino para n=0
#        signo = 1;
#        sen_x = x; // primer termino
#        double xx = x*x; // el numerador siempre se multiplica por x^2 
#        do {
#            old_senx = sen_x;
#            n++; // incremento el termino
#            signo = -signo; // el signo se alterna
#            numerador *= xx; 
#            denominador = (2*n+1) * 2*n * denominador;
#            termino = signo * numerador / denominador; // ultimo termino
#            sen_x += termino;
#            error_calculado = fabs((sen_x - old_senx) / sen_x);
#        } while (error_calculado >= error);
#        std::cout << "\n\n\nsen(x) calculado: " << sen_x;
#        std::cout << "\nerror calculado: " << error_calculado;
#        std::cout << "\nnumero de iteraciones calculadas: " << n;
#    } while (true);
#    std::cout << "\nFin del programa\n";
#    return(0);
#}

# ------------------------------------------------------------------------------------------------ MIPS ----------------------------------------------------------------------------------------

    .data
titulo: .asciiz "\n\nAproximación a sen(x) (-1 <= x <= 1) con un error máximo, usando Taylor\n"
petx:   .asciiz "\n\nIntroduzca el valor de x (-1 <= x <= 1): "
pete:   .asciiz "\nIntroduzca el error maximo permitido en la aproximación (0 < error < 1) (error <= 0 sale del programa): "
cadsen: .asciiz "\n\n\nsen(x) calculado: "
caderr: .asciiz "\nerror calculado: "
cadite: .asciiz "\nnumero de iteraciones calculadas: "
cadfin: .asciiz "\nFin del programa\n"
    
    .text
main:

  li $v0,4
  la $a0,titulo # std::cout << "\n\nAproximación a sen(x) (-1 <= x <= 1) con un error máximo, usando Taylor\n";
  syscall

  etiqueta_do_1:
    # Se declaran los registros dentro del ámbito del bucle principal, y no como variables globales, para evitar que se reinicien los valores en cada iteración
    li.d $f24,0.0 # double x
    li.d $f4,0.0 # Temporal para calculos
    li.d $f22,0.0 # double error
    li.d $f26,0.0 # double numerador
    li.d $f8,0.0 # double xx
    li.d $f30,1.0 # double denominador{1} (primer denominador del termino para n=0)
    li.d $f6,0.0 # double old_senx
    li.d $f16,0.0 # n para iteraciones

    etiqueta_do_2:
      li $v0,4
      la $a0,petx # std::cout << "\n\nIntroduzca el valor de x (-1 <= x <= 1): ";
      syscall

      li $v0,7
      syscall
      mov.d $f24,$f0 # std::cin >> x;

      # while ( (x < -1) || (x > 1));
      li.d $f4,-1.0 # $f4 = -1.0 para comprobaciones
      c.lt.d $f24,$f4 # x < -1
       bc1t etiqueta_do_2
      li.d $f4,1.0 # $f4 = 1.0 para comprobaciones
      c.lt.d $f4,$f24 # 1 < x
       bc1t etiqueta_do_2
    fin_etiqueta_do_2:

    etiqueta_do_3:
      li $v0,4
      la $a0,pete # std::cout << "\nIntroduzca el error maximo permitido en la aproximacion (0 < error < 1) (error <= 0 sale del programa): ";
      syscall
      
      li $v0,7
      syscall
      mov.d $f22,$f0 # std::cin >> error;
      
      # while (error >= 1);
      li.d $f4,1.0 # $f4 = 1.0 para comprobaciones
      c.le.d $f4,$f22
        bc1t etiqueta_do_3
    fin_etiqueta_do_3:

    if_error_fin: # if (error <= 0) break;
      li.d $f4,0.0 # $f4 = 0.0 para comprobaciones
      c.le.d $f22,$f4
        bc1t fin_programa
    fin_if_error_fin:

    mov.d $f26,$f24 # numerador = x; // primer numerador del termino para n=0
    mov.d $f20,$f24 # sen_x = x; // primer termino
    mul.d $f8,$f24,$f24 # double xx = x*x; // el numerador siempre se multiplica por x^2 
    li.d $f18,1.0 # double signo = 1
    li.d $f16,0.0 # double n = 0

    etiqueta_do_4:

      # El registro salvado f24 a partir de aqui será empleado para almacenar old_senx
      mov.d $f24,$f20  # old_senx = senx
  
      li.d $f6,1.0 # $f6 = 1.0 para operaciones
      add.d $f16,$f16,$f6 # n++; // incremento el termino
      neg.d $f18,$f18 # signo = -signo; // el signo se alterna
      mul.d $f26,$f26,$f8 # numerador *= xx; 

      li.d $f4,2.0 # $f4 = 2.0 para comprobaciones
      mul.d $f4,$f4,$f16 # f4 = 2n
      add.d $f6,$f4,$f6 # f6 = 2n + 1
      mul.d $f4,$f4,$f6 # f4 = (2*n+1) * 2*n
      mul.d $f30,$f30,$f4 # denominador = (2*n+1) * 2*n * denominador;

      # El registro temporal f4 a partir de aqui será empleado para almacenar termino
      mul.d $f4,$f18,$f26 # termino = signo * numerador
      div.d $f4,$f4,$f30 # termino = signo * numerador / denominador
      add.d $f20,$f20,$f4 # sen_x += termino;
  
      # El registro temporal f4 a partir de aqui será reescrito para usarlo para llevar a cabo cálculos
      sub.d $f4,$f20,$f24 # f4 = sen_x - old_senx
      div.d $f4,$f4,$f20 # (sen_x - old_senx) / sen_x
      abs.d $f28,$f4 # fabs((sen_x - old_senx) / sen_x)

      c.le.d $f22,$f28 # while (error_calculado >= error);
        bc1t etiqueta_do_4
    fin_etiqueta_do_4:

    li $v0,4
    la $a0,cadsen # std::cout << "\n\n\nsen(x) calculado: " 
    syscall

    mov.d $f12,$f20
    li $v0,3 # << sen_x;
    syscall

    li $v0,4
    la $a0,caderr # std::cout << "\nerror calculado: " 
    syscall

    mov.d $f12,$f28
    li $v0,3 # << error_calculado;
    syscall

    li $v0,4
    la $a0,cadite # std::cout << "\nnumero de iteraciones calculadas: " 
    syscall

    mov.d $f12,$f16  
    li $v0,3 # << n;
    syscall

    b etiqueta_do_1

  fin_etiqueta_do_1:
  
  fin_programa:

    li $v0,4
    la $a0,cadfin # std::cout << "\nFin del programa\n";
    syscall

    li $v0,10
    syscall