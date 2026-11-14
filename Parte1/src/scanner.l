%{
#include <stdio.h>
#include <stdlib.h>
#include "../include/semantica.h"
#include "y.tab.h"

extern int hayErrores;
extern int errorLexico;
%}

LETRA [a-zA-Z]
DIGITO [0-9]

IDENTIFICADOR {LETRA}({LETRA}|{DIGITO})*
CONSTANTE {DIGITO}+

%%

"inicio" {
    printf("Token: INICIO\n");
    return INICIO;
}

"fin" {
    printf("Token: FIN\n");
    return FIN;
}

"leer" {
    printf("Token: LEER\n");
    return LEER;
}

"escribir" {
    printf("Token: ESCRIBIR\n");
    return ESCRIBIR;
}

{IDENTIFICADOR} {
    if (yyleng > 32) {
        printf("Error lexico: identificador demasiado largo\n");
        hayErrores = 1;
        errorLexico = 1;
        return ERROR_LEXICO;
    }

    yylval.lexema = (char *) malloc(yyleng + 1);
    if (yylval.lexema == NULL) {
        printf("Error: no se pudo reservar memoria\n");
        exit(1);
    }

    snprintf(yylval.lexema, yyleng + 1, "%s", yytext);
    return IDENTIFICADOR;
}

{CONSTANTE} {
    yylval.lexema = (char *) malloc(yyleng + 1);
    if (yylval.lexema == NULL) {
        printf("Error: no se pudo reservar memoria\n");
        exit(1);
    }

    snprintf(yylval.lexema, yyleng + 1, "%s", yytext);
    return CONSTANTE;
}

"+" { return SUMA; }
"-" { return RESTA; }
":=" { return ASIGNACION; }
"(" { return PAREN_IZQUIERDO; }
")" { return PAREN_DERECHO; }
"," { return COMA; }
";" { return PUNTO_Y_COMA; }

[ \t\n]+ ;

. {
    printf("Error lexico: %s\n", yytext);
    hayErrores = 1;
    errorLexico = 1;
    return ERROR_LEXICO;
}

%%

/*
Ejemplos de programas Micro:

Caso 1: inicio leer (a,b); cc := a + (b-2); escribir (cc, a+4); fin

Caso 2: inicio leer (a,b); cc := a + @ 2; escribir (cc); fin

Caso 3: inicio leer (a,b); cc := a + ; escribir (cc); fin

*/
