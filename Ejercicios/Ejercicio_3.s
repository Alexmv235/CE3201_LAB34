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
    // Inicializar direcciones de memoria
    MOV R0, #0
    MOV R1, #0x1000     // Dirección de lectura del teclado
    MOV R2, #0x2000     // Dirección del contador VGA
    MOV R3, #0          // Valor inicial del contador
    STR R3, [R2]        // Inicializar contador en 0

    // Valores de prueba para simulación (5 iteraciones)
    MOV R4, #0xE048     // Flecha arriba
    STR R4, [R1]        // Primera prueba: arriba
    BL vga_controller
    
    MOV R4, #0xE050     // Flecha abajo
    STR R4, [R1]    // Segunda prueba: abajo
    BL vga_controller
    
    MOV R4, #0xE048     // Flecha arriba
    STR R4, [R1]    // Tercera prueba: arriba
    BL vga_controller

    MOV R4, #0xE048     // Flecha arriba
    STR R4, [R1]    // Tercera prueba: arriba
    BL vga_controller
    
    MOV R4, #0xFFFF     // Tecla inválida
    STR R4, [R1]   // Cuarta prueba: inválida
    BL vga_controller
    
    MOV R4, #0xE050     // Flecha abajo
    STR R4, [R1]   // Quinta prueba: abajo
    BL vga_controller

    // Salir del programa
    MOV R7, #1          // syscall número 1: exit
    MOV R0, #0          // código de salida
    SVC #0



// _____________________________________________________
// FUNCION: vga_controller
// Descripción: Controlador de teclado VGA
// Params:
//   R1: registro - Dirección de lectura del teclado
//   R2: registro - Dirección del contador VGA
//   R3: registro - Valor actual del contador
// Returns: Ninguno - Modifica memoria directamente
// _____________________________________________________

vga_controller:
    LDR R4, [R1]    // Cargar valor de tecla actual
    LDR R3, [R2]        // Cargar valor actual
    
    // Comparar con flecha arriba
    MOV R0, #0xE048
    CMP R4, R0
    BEQ incrementar

    // Comparar con flecha abajo
    MOV R0, #0xE050
    CMP R4, R0
    BEQ decrementar
    
    B retrun

incrementar:
    
    ADD R3, R3, #1      // Incrementar
    B retrun

decrementar:
    SUB R3, R3, #1      // Decrementar
    
    B retrun

retrun:
    STR R3, [R2]        // Guardar nuevo valor
    MOV PC, LR