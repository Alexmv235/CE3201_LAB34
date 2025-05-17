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
	
	MOV R1, #3			// Valor#1 = 3
	BL factorial_x
	STR R0, [R2,#0]		// Salida#1 = 0x6
	
	MOV R1, #7			// Valor#2 = 7
	BL factorial_x
	STR R0, [R2,#4]		// Salida#2 = 0x13B0
	
	
	MOV R1, #10			// Valor#3 = 10
	BL factorial_x
	STR R0, [R2,#8]		// Salida#3 = 0x375F00
    
    

    // syscall exit (Linux ABI)
    MOV R7, #1           // syscall número 1: exit
    MOV R0, #0           // código de salida
    SVC #0



// _____________________________________________________
// FUNCION: facorial_x
// Descripción: Calcula el resultado del factorial de un numero X
// Params:
//      R1: registro - Numero a calcular el factorial
// Returns: 
//      R0: registro - Resultado del factorial
// _____________________________________________________
factorial_x:
    MOV R0, #1
	
loop:
	CMP R1,#1
	BEQ return
	MUL R0, R0, R1
	ADD R1, R1, #-1
    B loop

return:
    MOV PC, LR

