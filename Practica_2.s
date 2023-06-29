# NOMBRE: EDUARDO GONZÁLEZ GUTIÉRREZ
# CORREO: alu0101461588@ull.edu.es

# // En un bucle solicitar dos flotantes en doble precisión.
# // En cada iteración se calculará la distancia entre ambos
# // (distancia siempre es positiva).
# // Cuando se introduzcan dos números iguales debe detenerse el bucle.
# // Al finalizar se mostrará la pareja que ha tenido mayor distancia
# // y la distancia entre ellos.

# #include <iostream>
# #include <cmath>

# int main() {
#   std::cout << "\nDistancia flotantes\n";
#   double maxDistancia = -1.0;
#   double pareja1;
#   double pareja2;
#   double distancia;
#   do {
#     double numero1;
#     std::cout << "\nPrimer número: ";
#     std::cin >> numero1;
#     double numero2;
#     std::cout << "Segundo número: ";
#     std::cin >> numero2;


#     distancia = fabs(numero1 - numero2);
#     // std::cout << "Distancia " << distancia;
#     if (distancia > maxDistancia) {
#       maxDistancia = distancia;
#       pareja1 = numero1;
#       pareja2 = numero2;
#     }
#   } while (distancia > 0.0);

#   std::cout << "\nMayor distancia: " << maxDistancia;
#   std::cout << "\nNumero 1: " << pareja1;
#   std::cout << "\nNumero 2: " << pareja2;

#   std::cout << "\n\nTermina el programa\n";

# }

		.data
strTitulo:	.asciiz	"\nDistancia doubles\n"
strPrimer:	.asciiz	"\nPrimer número: "
strSegundo:	.asciiz	"Segundo número: "
strMayor:	.asciiz	"\nMayor distancia: "
strNumero1:	.asciiz	"\nNumero 1: "
strNumero2:	.asciiz	"\nNumero 2: "
strTermina:	.asciiz	"\n\nTermina el programa\n"


   .text

main:
  
  li.d $f20,0.0 # double pareja1 {0}
  li.d $f22,0.0 # double pareja2 {0}
  li.d $f24,0.0 # double distancia {0}
  li.d $f26,-1.0 # double maxDistancia {-1.0}
  li.d $f6,0.0 # double numero1 {0}
  li.d $f8,0.0 # double numero2 {0}
  li.d $f4,0.0 # double 0 para comprobaciones

  etiqueta_do:
  
    li $v0,4
    la $a0, strTitulo # std::cout << "\nDistancia flotantes\n";
    syscall

    li $v0,4
    la $a0, strPrimer # std::cout << "\nPrimer número: ";
    syscall

    li $v0,7
    syscall
    mov.d $f6,$f12 # std::cin >> numero1;

    li $v0,4
    la $a0, strSegundo # std::cout << "Segundo número: ";
    syscall

    li $v0,7
    syscall
    mov.d $f8,$f12 # std::cin >> numero2;

    li.d $f4,0.0 # Registro temporal para hacer la resta de numero1 - numero2
    sub.d $f4,$f6,$f8 # numero1 - numero2
    abs.d $f4,$f4 # fabs(numero1 - numero2);
    mov.d $f24,$f4 # distancia = fabs(numero1 - numero2);

    etiqueta_if:
      c.le.d $f24,$f26 # if (distancia <= maxDistancia)
        bc1t fin_etiqueta_if
      
      mov.d $f26,$f24 # maxDistancia = distancia;
      mov.d $f20,$f6 # pareja1 = numero1;
      mov.d $f22,$f8 # pareja2 = numero2;
    fin_etiqueta_if:

    etiqueta_while:
      c.lt.d $f4,$f24
        bc1t etiqueta_do
    fin_etiqueta_while:

  fin_etiqueta_do:


    li $v0,4
    la $a0, strMayor # std::cout << "\nMayor distancia: "
    syscall
   
    li $v0,3
    mov.d $f12,$f26 # std::cout << maxDistancia;
    syscall

    li $v0,4
    la $a0,strNumero1 # std::cout << "\nNumero 1: "
    syscall
   
    li $v0,3
    mov.d $f12,$f20 # std::cout << pareja1;
    syscall

    li $v0,4
    la $a0, strNumero2 # std::cout << "\nNumero 2: "
    syscall
   
    li $v0,3
    mov.d $f12,$f22 # std::cout << pareja2;
    syscall


  fin_programa:

    li $v0,4
    la $a0, strTermina # std::cout << "\n\nTermina el programa\n";
    syscall

    li $v0,10
    syscall



