# Clase S1 · Plan final de clase

## Tesis de la sesion
No se trata de la herramienta. Se trata de entender el problema, elegir bien la visualizacion y comunicar la informacion de forma clara.

## Hilo conductor
Trabajamos con un solo caso y un solo dataset durante toda la sesion.

Caso:

> Una organizacion internacional quiere entender como ha cambiado el desarrollo humano entre 1952 y 2007, que regiones avanzan mas lento y donde deberia mirar primero.

Dataset eje:
- Gapminder

Pregunta guia:
- Como ha cambiado el desarrollo humano?
- Hay relacion entre economia y calidad de vida?
- Que paises o regiones estan mas arriba o mas abajo?
- Como se distribuyen los resultados?
- Como contar esa historia sin confundir al lector?

---

## Estructura completa de la clase

### 1. Punto de partida: el caso
No arrancamos con definiciones.
Arrancamos con la pregunta del caso.

Objetivo:
- enganchar desde una situacion concreta
- mostrar el dataset
- anticipar las preguntas visuales que vamos a responder

Mensajes clave:
- primero entendemos el problema
- despues decidimos como verlo
- luego lo construimos

### 2. Introduccion natural a BI
BI aparece como consecuencia del problema.

Objetivo:
- explicar BI en lenguaje simple
- mostrar que visualizacion es una parte del flujo

Mensajes clave:
- BI convierte datos en decisiones
- flujo: datos -> transformacion -> visualizacion -> decision
- un dashboard no es el comienzo; es una consecuencia

### 3. Ecosistema de herramientas
Contexto rapido, sin volverlo clase de catalogo.

Objetivo:
- ubicar herramientas plug and play y herramientas de codigo
- preparar el paso hacia R y Python

Mensajes clave:
- Power BI, Tableau, Looker Studio sirven para ciertos contextos
- Python y R dan mas flexibilidad
- hoy resolvemos el mismo problema con dos enfoques

### 4. Principios de visualizacion clara
Todo sigue sobre el mismo caso.

Objetivo:
- decidir que grafico sirve para cada pregunta
- introducir familias visuales
- explicar gramatica minima del grafico
- discutir buenas y malas practicas
- introducir storytelling con graficas

Subbloques:
- eleccion del grafico segun la pregunta
- gramatica minima: ejes, variables, color, tamano
- 4 casos malos y 1 bueno
- contar historias con graficas

### 5. Transicion a practica
Frase puente:

> Ya sabemos que queremos mostrar y como deberia verse. Ahora lo vamos a construir.

### 6. Parte practica 1: R + Shiny
Debe ser tan paso a paso como Python.

Objetivo:
- mostrar como resolver la misma historia en R
- comparar base R, ggplot2 y plotly
- pasar de visualizacion a app con Shiny
- hacer mini actividad guiada

Secuencia:
- cargar librerias y datos
- explorar dataset
- correlation en base R, ggplot2 y plotly
- ranking en base R, ggplot2 y plotly
- distribution en base R, ggplot2 y plotly
- change over time en base R, ggplot2 y plotly
- part-to-whole en base R, ggplot2 y plotly
- puente a Shiny
- estructura UI + Server
- correr app_demo.R
- mini actividad de cambios pequenos

### 7. Parte practica 2: Python + Streamlit
Misma profundidad.

Objetivo:
- mostrar como resolver la misma historia en Python
- comparar matplotlib, seaborn y plotly
- pasar de visualizacion a app con Streamlit
- hacer mini actividad guiada

Secuencia:
- cargar librerias y datos
- explorar dataset
- correlation en matplotlib, seaborn y plotly
- ranking en matplotlib, seaborn y plotly
- distribution en matplotlib, seaborn y plotly
- change over time en matplotlib, seaborn y plotly
- part-to-whole en matplotlib, seaborn y plotly
- puente a Streamlit
- estructura de app
- correr app_demo.py
- mini actividad de cambios pequenos

### 8. Comparacion final
Objetivo:
- comparar resultados y experiencia de uso
- reforzar criterio de eleccion

Mensajes clave:
- misma pregunta, mismo dataset, distintos ecosistemas
- la herramienta correcta depende del contexto
- no compiten; responden a necesidades distintas

### 9. Cierre
Objetivo:
- cerrar con idea fuerte
- conectar con proyecto final

Mensaje final:
- no se trata de la herramienta, sino de entender el problema y comunicar bien la informacion

---

## Actividades

### Actividad de lectura visual
Antes de programar:
- dar preguntas del caso
- pedir familia visual
- pedir grafico recomendado

### Actividad de critica
Usar 4 graficos malos y 1 bueno:
- que confunde?
- que corregirian?
- que conclusion cuenta mejor la historia?

### Actividad en R
- cambiar titulo
- cambiar color
- cambiar variable del ranking
- cambiar input del app

### Actividad en Python
- cambiar titulo
- cambiar color
- cambiar variable del ranking
- cambiar filtro o pestaña del app

---

## Resultado esperado
Al final de la sesion, el estudiante deberia poder:
- entender BI como flujo
- identificar familias visuales utiles
- justificar graficos segun pregunta
- reconocer buenas y malas practicas
- ver como la misma historia se resuelve en R y Python
- modificar ejemplos guiados sin empezar desde cero
- salir con una idea inicial de proyecto
