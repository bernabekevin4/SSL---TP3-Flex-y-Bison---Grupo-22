
%{
#include <stdio.h>
#include <stdlib.h>
#include "../include/semantica.h"

int yylex(void);
void yyerror(char *);

int hayErrores = 0;
int errorLexico = 0;
%}

%union {
    char *lexema;
    REG_EXPRESION expresion;
    REG_OPERACION operacion;
}

%token INICIO FIN LEER ESCRIBIR
%token <lexema> IDENTIFICADOR CONSTANTE
%token SUMA RESTA ASIGNACION
%token PAREN_IZQUIERDO PAREN_DERECHO COMA PUNTO_Y_COMA
%token ERROR_LEXICO

%type <expresion> identificador expresion termino
%type <operacion> operadorAditivo

%%

programa:
    INICIO {
        Comenzar();
    }
    lista_sentencias FIN {
        Terminar();

        if (!hayErrores) {
            printf("Programa compilado correctamente\n");
        } else {
            printf("Programa finalizado con errores\n");
        }
    }
    ;

lista_sentencias:
    lista_sentencias sentencia PUNTO_Y_COMA
    |
    sentencia PUNTO_Y_COMA
    |
    lista_sentencias error PUNTO_Y_COMA
    |
    error PUNTO_Y_COMA
    ;

sentencia:
    identificador ASIGNACION expresion {
        Asignar($1, $3);
    }
    |
    LEER PAREN_IZQUIERDO listaIdentificadores PAREN_DERECHO
    |
    ESCRIBIR PAREN_IZQUIERDO listaExpresiones PAREN_DERECHO
    ;

listaIdentificadores:
    identificador {
        LeerID($1);
    }
    |
    listaIdentificadores COMA identificador {
        LeerID($3);
    }
    ;

listaExpresiones:
    expresion {
        EscribirExp($1);
    }
    |
    listaExpresiones COMA expresion {
        EscribirExp($3);
    }
    ;

identificador:
    IDENTIFICADOR {
        $$ = ProcesarID($1);
        free($1);
    }
    ;

expresion:
    expresion operadorAditivo termino {
        $$ = GenInfijo($1, $2, $3);
    }
    |
    termino {
        $$ = $1;
    }
    ;

termino:
    identificador {
        $$ = $1;
    }
    |
    CONSTANTE {
        $$ = ProcesarCte($1);
        free($1);
    }
    |
    PAREN_IZQUIERDO expresion PAREN_DERECHO {
        $$ = $2;
    }
    ;

operadorAditivo:
    SUMA {
        $$ = ProcesarOp(SUMA);
    }
    |
    RESTA {
        $$ = ProcesarOp(RESTA);
    }
    ;

%%

int main() {
    yyparse();
    return 0;
}

void yyerror(char *s) {
    if (!errorLexico) {
        printf("Error sintactico: %s\n", s);
    }

    errorLexico = 0;
    hayErrores = 1;
}

int yywrap() {
    return 1;
}
