# Proyecto AFD: Implementación en Python, Flex y Bison

Este proyecto tiene como objetivo implementar un **Automáta Finito Determinista (AFD)** que pueda leer configuraciones y cadenas desde archivos, y evaluar si las cadenas son aceptadas o rechazadas por el autómata. La implementación se ha realizado en tres lenguajes: **Python**, **Flex**, y **Bison**.

## Descripción

El AFD está diseñado para leer un archivo de configuración (`conf.txt`) que describe el conjunto de estados, el alfabeto, el estado inicial, los estados finales y las transiciones. Luego, se evalúan una serie de cadenas (proporcionadas en el archivo `cadenas.txt`) para determinar si son aceptadas o rechazadas por el autómata.

### Archivos:

1. **`conf.txt`**: Archivo de configuración del AFD.
   - Define los **estados** del autómata, el **alfabeto**, el **estado inicial**, los **estados finales** y las **transiciones**.
   
   Ejemplo de `conf.txt`:
estados=q0,q1,q2
alfabeto=a,b
inicial=q0
finales=q2
transiciones=
q0,a,q1
q0,b,q0
q1,a,q1
q1,b,q2
q2,a,q2
q2,b,q2


2. **`cadenas.txt`**: Archivo que contiene una lista de cadenas que se evaluarán en el AFD.

Ejemplo de `cadenas.txt`:
aab
abba
bbaa
aaa
bbb
ab
ba


3. **`afd.py`**: Implementación en Python del AFD, que lee la configuración del AFD y evalúa las cadenas.

## Descripción del Código

### Funciones:

1. **`cargar_afd(conf_file)`**: 
- Lee y procesa el archivo de configuración (`conf.txt`).
- Extrae los **estados**, el **alfabeto**, el **estado inicial**, los **estados finales** y las **transiciones**.
- Devuelve una tupla con estos valores.

**Entrada**: Nombre del archivo de configuración.

**Salida**: Una tupla `(estados, alfabeto, estado_inicial, estados_finales, transiciones)`.

2. **`evaluar_cadena(afd, cadena)`**: 
- Evalúa si una cadena es aceptada o rechazada por el AFD.
- Recorre cada símbolo de la cadena y realiza las transiciones correspondientes.
- Si una transición no está definida o el símbolo no pertenece al alfabeto, la cadena es rechazada.
- Si, al final de la cadena, el autómata termina en un estado final, la cadena es aceptada.

**Entrada**: El AFD (tupla) y la cadena a evaluar.

**Salida**: `True` si la cadena es aceptada, `False` si es rechazada.

3. **`main()`**:
- Carga el AFD desde el archivo `conf.txt`.
- Lee las cadenas desde el archivo `cadenas.txt`.
- Evalúa cada cadena utilizando la función `evaluar_cadena` y muestra si la cadena es **ACEPTADA** o **RECHAZADA**.

### Ejemplo de Ejecución

1. **Archivos de Entrada**:

`conf.txt`:
estados=q0,q1,q2
alfabeto=a,b
inicial=q0
finales=q2
transiciones=
q0,a,q1
q0,b,q0
q1,a,q1
q1,b,q2
q2,a,q2
q2,b,q2


`cadenas.txt`:
aab
abba
bbaa
aaa
bbb
ab
ba


2. **Ejecución del Script en Python**:

Al ejecutar el script, el AFD evaluará las cadenas y mostrará los resultados:
Resultados de evaluación:
aab -> ACEPTADA
abba -> RECHAZADA
bbaa -> RECHAZADA
aaa -> RECHAZADA
bbb -> RECHAZADA
ab -> ACEPTADA
ba -> RECHAZADA


### Instrucciones de Uso

1. **Configurar los archivos de entrada**:
- Asegúrate de que el archivo `conf.txt` tenga la configuración correcta del AFD.
- Las cadenas a evaluar deben estar en el archivo `cadenas.txt`.

2. **Ejecutar el script en Python**:
- Para ejecutar el script, simplemente corre el siguiente comando en tu terminal:
  ```bash
  python afd.py
  ```

### Integración con Flex y Bison

En el proyecto también se ha utilizado **Flex** y **Bison** para la parte de análisis léxico y sintáctico. Aquí el AFD actúa como la máquina de evaluación que recibe cadenas analizadas y las verifica en función de las transiciones definidas.

## Requisitos

- Python 3.x
- No hay dependencias adicionales externas para esta implementación.

## Conclusión

Este proyecto combina la teoría de autómatas finitos con implementaciones prácticas en varios lenguajes. La integración entre Python, Flex y Bison permite evaluar cadenas de manera eficiente usando un AFD, además de proporcionar una base sólida para construir y analizar lenguajes formales.




