# Parte 1 - Compilador del lenguaje Micro

## Descripción

Esta parte del Trabajo Práctico 3 consiste en implementar un compilador para el lenguaje Micro utilizando **Flex y Bison**.

El programa realiza análisis léxico, sintáctico y semántico. Además, genera instrucciones de código intermedio a partir de los programas fuente escritos en Micro.

## Estructura del proyecto

```text
Parte1/
├── include/
│   └── semantica.h
├── pruebas/
├── src/
│   ├── scanner.l
│   ├── parser.y
│   └── semantica.c
└── README.md
```

- **include/**: contiene los archivos de encabezado.
- **pruebas/**: contiene programas fuente utilizados para verificar el funcionamiento del compilador.
- **src/**: contiene los archivos fuente de Flex, Bison y las rutinas semánticas.

## Herramientas utilizadas

Para compilar y ejecutar el proyecto se necesitan:

- GCC.
- Flex.
- Bison.

## Compilación

Abrir una terminal dentro de la carpeta `Parte1/src` y ejecutar los siguientes comandos:

```bash
bison -yd parser.y
flex scanner.l
gcc y.tab.c lex.yy.c semantica.c -o ejecutable.exe
```

El último comando genera el ejecutable `ejecutable.exe` dentro de la carpeta `src`.

## Ejecución

Desde la misma terminal, ejecutar:

```bash
./ejecutable.exe
```

Luego se puede ingresar un programa escrito en Micro para analizarlo.

Para finalizar la entrada, utilizar `Ctrl + C`.

## Características implementadas

### Análisis léxico

Realizado mediante Flex. Reconoce:

- Palabras reservadas: `inicio`, `fin`, `leer` y `escribir`.
- Identificadores.
- Constantes enteras.
- Operadores: `+`, `-` y `:=`.
- Delimitadores: paréntesis, comas y punto y coma.

También detecta caracteres no reconocidos e identificadores que superan los 32 caracteres permitidos.

### Análisis sintáctico

Realizado mediante Bison. Verifica que los programas respeten la gramática del lenguaje Micro.

Se reconocen las siguientes construcciones:

- Sentencias de asignación.
- Sentencias de lectura.
- Sentencias de escritura.
- Expresiones aritméticas con suma, resta y paréntesis.

También se implementa recuperación ante errores sintácticos utilizando el mecanismo de recuperación de Bison.

### Análisis semántico y generación de código intermedio

Las rutinas semánticas se encuentran implementadas en `semantica.c` y sus declaraciones en `semantica.h`.

Entre sus funcionalidades se encuentran:

- Administración de la tabla de símbolos.
- Procesamiento de identificadores y constantes.
- Procesamiento de operadores.
- Generación de operaciones aritméticas mediante variables temporales.
- Generación de instrucciones de asignación, lectura y escritura.

Las instrucciones generadas utilizan operaciones como `Declare`, `Read`, `Write`, `ADD`, `SUBS`, `Store` y `Stop`.

## Ejemplo de entrada

```text
inicio
leer(a,b);
cc := a + (b-2);
escribir(cc, a+4);
fin
```

El compilador reconoce el programa y genera instrucciones de código intermedio, incluyendo las declaraciones de variables y temporales necesarias.

## Pruebas

Los casos de prueba se encuentran organizados en la carpeta `pruebas/`.

Se contemplan programas correctos y situaciones de error para verificar el análisis léxico y sintáctico, así como la recuperación ante errores.
