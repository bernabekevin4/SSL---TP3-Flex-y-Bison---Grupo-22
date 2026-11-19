# Parte 2: Compilador Micro en C

Esta carpeta contiene el desarrollo correspondiente a la segunda parte del Trabajo Práctico N.º 3 de Sintaxis y Semántica de los Lenguajes.

## Organización del proyecto

```text
Parte2/
└── compiladorMicro/
    └── Archivos del compilador Micro
```

## Descripción

En esta parte del trabajo práctico se analiza y utiliza una implementación en lenguaje C de un compilador para el lenguaje Micro, proporcionada como material de referencia por la cátedra.

El objetivo es estudiar su funcionamiento y observar cómo procesa programas fuente, reconoce instrucciones y detecta errores durante el análisis.

## Casos de prueba

Se utilizan tres programas fuente para comprobar distintos comportamientos del compilador:

1. **Programa correcto:** verifica el procesamiento de instrucciones de entrada, asignación, expresiones aritméticas y salida.
2. **Error sintáctico y situación semántica:** presenta una sentencia sin el punto y coma correspondiente y utiliza una variable sin asignarle previamente un valor.
3. **Error léxico:** incorpora un carácter no válido (`@`) para comprobar su detección.

## Ejecución

El compilador recibe como argumento el archivo fuente que se desea analizar.

En sistemas Linux:

```bash
./micro nombre_archivo.m
```

En Windows, utilizando PowerShell, el ejecutable puede invocarse de la siguiente manera:

```powershell
.\micro.exe nombre_archivo.m
```

Los resultados de las ejecuciones y el análisis de cada caso se encuentran documentados en el informe de la Parte 2.
