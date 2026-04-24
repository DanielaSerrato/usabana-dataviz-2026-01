# Clase S1 · Plan de clase con storytelling unico

## Dataset eje
Gapminder

## Historia de negocio / narrativa docente
Trabajamos como equipo de analitica para una organizacion internacional que necesita responder una pregunta simple pero poderosa:

> Como ha cambiado el desarrollo humano entre 1952 y 2007, que regiones avanzan mas lento y donde deberiamos mirar primero?

La idea de la clase es mostrar que:
- primero definimos la pregunta
- despues elegimos la familia visual adecuada
- luego construimos esa respuesta con Python
- y finalmente mostramos que la misma logica se puede resolver con R

## Variables del dataset que sostienen la historia
- `country`
- `continent`
- `year`
- `lifeExp`
- `gdpPercap`
- `pop`

## Familias visuales que si se cubren con este dataset
- `Deviation`
  Ejemplo: esperanza de vida de un pais frente al promedio global.
- `Correlation`
  Ejemplo: PIB per capita vs esperanza de vida.
- `Ranking`
  Ejemplo: top paises por esperanza de vida o por PIB per capita.
- `Distribution`
  Ejemplo: histograma y boxplot de esperanza de vida.
- `Change over Time`
  Ejemplo: evolucion de esperanza de vida o PIB per capita por continente.
- `Part-to-Whole`
  Ejemplo: proporcion de poblacion por continente en un ano.
- `Magnitude`
  Ejemplo: poblacion total por continente o por pais.
- `Spatial`
  Ejemplo: mapa por pais con color o tamano.

## Familia que se menciona pero no se practica fuerte
- `Flow`
  Se presenta como categoria especializada. Se explica que no es la mejor familia para Gapminder y se deja como extension futura.

## Estructura sugerida por bloques

### 2:00-2:30 · Marco inicial
- Presentacion de la clase
- Que es BI y para que sirve
- Presentacion del caso narrativo
- Presentacion del dataset

### 2:30-3:30 · Vocabulario visual
- Visual vocabulary: que quiero mostrar y que grafico conviene
- Recorrer las familias principales que si vamos a usar hoy
- Mostrar ejemplos simples con el mismo dataset

### 3:30-4:00 · Decision visual y mini practica de lectura
- Elegir graficos segun pregunta
- Actividad corta: dar casos y pedir categoria visual + grafico recomendado

### 4:30-5:30 · Python
- Panorama rapido de librerias: matplotlib, seaborn, plotly
- Mismo dataset, mismas preguntas, distintos enfoques
- Streamlit como capa de app
- Mini actividad guiada: cambiar titulo, color, eje o filtro

### 5:30-6:30 · R
- Panorama rapido de ggplot2 y plotly en R
- Misma historia, mismas preguntas
- Shiny como capa de app
- Mini actividad guiada: cambiar input, titulo, variable o salida

### 6:30-7:15 · Comparacion
- Python vs R
- Cuando usar Streamlit
- Cuando usar Shiny
- Como decidir por contexto

### 7:15-8:00 · Proyecto y cierre
- Conectar el storytelling de hoy con el proyecto final
- Actividad corta de idea inicial
- Recap
- Tarea para la proxima clase

## Mini actividades sugeridas

### Actividad Python
- Cambiar el color del grafico
- Cambiar la variable del eje X o Y
- Cambiar el titulo para que diga una conclusion
- Cambiar el filtro de continente o ano

### Actividad R
- Cambiar el input del selector
- Cambiar el titulo del output
- Cambiar la variable graficada
- Cambiar una salida de grafico a tabla o viceversa

## Mensaje pedagogico central
No estamos ensenando "muchas herramientas por mostrar muchas herramientas".
Estamos ensenando una secuencia de pensamiento:

`pregunta -> familia visual -> grafico -> libreria -> app`

## Resultado esperado
Al final de S1 el estudiante deberia poder:
- reconocer varias familias visuales
- justificar un grafico segun una pregunta
- entender que Python y R pueden resolver el mismo problema
- perderle el miedo a editar una app ya preparada
- salir con una idea inicial de proyecto
