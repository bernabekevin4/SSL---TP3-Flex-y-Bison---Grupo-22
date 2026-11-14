
#ifndef SEMANTICA_H
#define SEMANTICA_H

#define TAMLEX 33

/* Registro semantico de una expresion */
typedef struct {
    int clase;
    char nombre[TAMLEX];
    int valor;
} REG_EXPRESION;

/* Registro semantico de una operacion */
typedef struct {
    int operador;
} REG_OPERACION;

/* Rutinas semanticas */
void Comenzar(void);
void Terminar(void);

REG_EXPRESION ProcesarID(const char *nombre);
REG_EXPRESION ProcesarCte(const char *valor);
REG_OPERACION ProcesarOp(int operador);

REG_EXPRESION GenInfijo(REG_EXPRESION izquierda,
                        REG_OPERACION operacion,
                        REG_EXPRESION derecha);

void Asignar(REG_EXPRESION identificador, REG_EXPRESION expresion);
void LeerID(REG_EXPRESION identificador);
void EscribirExp(REG_EXPRESION expresion);

#endif
