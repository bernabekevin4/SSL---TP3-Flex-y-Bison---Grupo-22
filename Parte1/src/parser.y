%{
#include <stdio.h>

int yylex(void);
void yyerror(char *);
%}

%token INICIO FIN LEER ESCRIBIR /* Palabras reservadas */
%token IDENTIFICADOR CONSTANTE
%token SUMA RESTA ASIGNACION
%token PAREN_IZQUIERDO PAREN_DERECHO COMA PUNTO_Y_COMA
%token ERROR_LEXICO

%%

programa:
    INICIO lista_sentencias FIN {
        printf("Programa sintacticamente correcto\n");
    }
    ;

lista_sentencias:
    lista_sentencias sentencia PUNTO_Y_COMA
    |
    sentencia PUNTO_Y_COMA
    ;

sentencia:
    IDENTIFICADOR ASIGNACION expresion
    | 
    LEER PAREN_IZQUIERDO listaIdentificadores PAREN_DERECHO
    |
    ESCRIBIR PAREN_IZQUIERDO listaExpresiones PAREN_DERECHO
    ;

listaIdentificadores: 
    IDENTIFICADOR COMA listaIdentificadores 
    |
    IDENTIFICADOR
    ;

listaExpresiones:
    expresion COMA listaExpresiones
    |
    expresion
    ;

expresion:
    expresion SUMA termino
    |
    expresion RESTA termino
    |
    termino
    ;

termino:
    IDENTIFICADOR
    |
    CONSTANTE
    |
    PAREN_IZQUIERDO expresion PAREN_DERECHO
    ;

%%

int main() {
    yyparse();
    return 0;
}

void yyerror(char *s) {
    printf("Error sintactico: %s\n", s);
}
int yywrap() {
    return 1;
}