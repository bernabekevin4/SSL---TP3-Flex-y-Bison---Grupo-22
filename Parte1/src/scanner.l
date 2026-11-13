%{
#include <stdio.h>
#include "y.tab.h"
%}

LETRA [a-zA-Z]
DIGITO [0-9]

IDENTIFICADOR {LETRA}({LETRA}|{DIGITO})*
CONSTANTE {DIGITO}+

%%

"inicio"   { printf("Token: INICIO\n"); return INICIO; }
"fin"      { printf("Token: FIN\n"); return FIN; }
"leer"     { printf("Token: LEER\n"); return LEER; }
"escribir" { printf("Token: ESCRIBIR\n"); return ESCRIBIR; }

{IDENTIFICADOR} {
    if(yyleng > 32){
        printf("Error lexico: identificador demasiado largo\n");
        return ERROR_LEXICO;
    }

    return IDENTIFICADOR;
}

{CONSTANTE} {
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
    return ERROR_LEXICO;
}

%% 

/* 

Ejemplo de programa micro:

inicio leer (a,b); cc := a + (b-2); escribir (cc, a+4); fin
*/