// ============= LICENCIA =============
// MIT License
// Copyright (c) 2025 Alexander Montero Vargas
// Consulta el archivo LICENSE para más detalles.
// =======================================

.global _start

// _______________________________________________________
// Function: _start
// Descripción: Punto de entrada principal del programa
// Params: Ninguno
// Returns: Código de salida 0 al sistema operativo
// _______________________________________________________
_start:
    MOV R2, #0x1000     // Dirección base del arreglo
	MOV R5, #3          // Valor constante escogido

    BL init_index       // R0 = 0
    BL init_array       // Llena el arreglo
    BL init_index       // R0 = 0
    BL comparador       // Funcion de comparador

    // syscall exit (Linux ABI)
    MOV R7, #1          // syscall número 1: exit
    MOV R0, #0          // código de salida
    SVC #0

return:
    MOV PC, LR



// _____________________________________________________
// FUNCION: init_index
// Descripción: Inicializa el contador de índice
// Salida: R0 = 0
// _____________________________________________________
init_index:
    MOV R0, #0
    B return


// _______________________________________________________
// Function: init_array
// Descripción: Inicializa un arreglo en memoria con valores del 1 al 10
// Params:
//   R0: registro - Índice actual del arreglo
//   R2: registro - Dirección base del arreglo en memoria
// Returns: Ninguno - Modifica memoria directamente
// _______________________________________________________
init_array:
init_loop:
    CMP R0, #10
    BGE return
    ADD R1, R0, #1          // R1 = 0x1 + índice
    STRB R1, [R2, R0]       // Guardar byte en memoria
    ADD R0, R0, #1
    B init_loop

// _______________________________________________________
// Function: comparador
// Descripción: Procesa cada elemento del arreglo comparándolo con R5
// Params:
//   R0: registro - Índice del arreglo
//   R2: registro - Dirección base del arreglo
//   R5: registro - Valor de comparación
// Returns: Ninguno - Modifica el arreglo en memoria
// _______________________________________________________
comparador:
loop_mi:
    CMP R0, #10             //Comparador IF del arreglo i<=10
    BGE return

    LDRB R1, [R2, R0]       // Cargar item de arreglo
    CMP R1,R5               // Verifica si es igual a la constante
	BEQ es_igual			
	B no_igual

es_igual:
	MUL R1, R1, R5          //array[ i ]=array[i]*y
	B siguiente
	
no_igual:
	ADD R1, R1, R5          //array[ i ]=array[i]+
	B siguiente
	
siguiente:
	STRB R1,[R2,R0]
	ADD R0, R0, #1
    B loop_mi