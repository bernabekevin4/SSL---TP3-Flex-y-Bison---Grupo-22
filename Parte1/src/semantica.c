
#include <stdio.h>
#include <string.h>
#include "../include/semantica.h"
#include "y.tab.h"

extern int hayErrores;

#define MAX_SIMBOLOS 1000

static char tablaSimbolos[MAX_SIMBOLOS][TAMLEX];
static int cantidadSimbolos = 0;
static int contadorTemporales = 0;

/* Busca un identificador en la tabla de simbolos. */
static int Buscar(const char *nombre) {
    int i;

    for (i = 0; i < cantidadSimbolos; i++) {
        if (strcmp(tablaSimbolos[i], nombre) == 0) {
            return i;
        }
    }

    return -1;
}

/* Declara un identificador si todavia no fue utilizado. */
static void Chequear(const char *nombre) {
    if (hayErrores) {
        return;
    }

    if (Buscar(nombre) == -1 && cantidadSimbolos < MAX_SIMBOLOS) {
        strcpy(tablaSimbolos[cantidadSimbolos], nombre);
        cantidadSimbolos++;

        printf("Declare %s,Integer,\n", nombre);
    }
}

/* Inicializa el analisis semantico. */
void Comenzar(void) {
    cantidadSimbolos = 0;
    contadorTemporales = 0;
}

/* Finaliza la generacion de instrucciones. */
void Terminar(void) {
    if (!hayErrores) {
        printf("Stop ,,,\n");
    }
}

/* Procesa un identificador. */
REG_EXPRESION ProcesarID(const char *nombre) {
    REG_EXPRESION registro;

    registro.clase = IDENTIFICADOR;
    strcpy(registro.nombre, nombre);
    registro.valor = 0;

    Chequear(nombre);

    return registro;
}

/* Procesa una constante entera. */
REG_EXPRESION ProcesarCte(const char *valor) {
    REG_EXPRESION registro;

    registro.clase = CONSTANTE;
    strcpy(registro.nombre, valor);
    sscanf(valor, "%d", &registro.valor);

    return registro;
}

/* Procesa un operador aditivo. */
REG_OPERACION ProcesarOp(int operador) {
    REG_OPERACION registro;

    registro.operador = operador;

    return registro;
}

/* Genera una operacion infija y devuelve su resultado. */
REG_EXPRESION GenInfijo(REG_EXPRESION izquierda,
                        REG_OPERACION operacion,
                        REG_EXPRESION derecha) {
    REG_EXPRESION resultado;
    const char *instruccion;

    /* Inicializa el registro incluso si hubo un error. */
    resultado.clase = IDENTIFICADOR;
    resultado.nombre[0] = '\0';
    resultado.valor = 0;

    if (hayErrores) {
        return resultado;
    }

    contadorTemporales++;

    snprintf(resultado.nombre, TAMLEX, "Temp&%d", contadorTemporales);

    if (operacion.operador == SUMA) {
        instruccion = "ADD";
    } else {
        instruccion = "SUBS";
    }

    Chequear(resultado.nombre);

    printf("%s %s,%s,%s\n",
           instruccion,
           izquierda.nombre,
           derecha.nombre,
           resultado.nombre);

    return resultado;
}

/* Procesa una asignacion. */
void Asignar(REG_EXPRESION identificador, REG_EXPRESION expresion) {
    if (hayErrores) {
        return;
    }

    printf("Store %s,%s,\n",
           expresion.nombre,
           identificador.nombre);
}

/* Procesa un identificador dentro de una sentencia leer. */
void LeerID(REG_EXPRESION identificador) {
    if (hayErrores) {
        return;
    }

    printf("Read %s,Integer,\n", identificador.nombre);
}

/* Procesa una expresion dentro de una sentencia escribir. */
void EscribirExp(REG_EXPRESION expresion) {
    if (hayErrores) {
        return;
    }

    printf("Write %s,Integer,\n", expresion.nombre);
}
