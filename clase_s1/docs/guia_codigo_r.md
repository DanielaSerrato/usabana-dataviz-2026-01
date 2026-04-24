# Guía de código · R

Esta guía explica, en lenguaje simple, qué hace cada parte del material de R de la clase.

Archivos que acompaña:
- `clase_s1/notebooks/r_visual_vocabulary_gapminder.Rmd`
- `clase_s1/shiny/app_demo.R`

La lógica es paralela a Python:
- `R Markdown` para enseñar paso a paso
- `Shiny` para cerrar con app

---

## 1. Qué hace el archivo `.Rmd`

El archivo `r_visual_vocabulary_gapminder.Rmd` sirve para clase.

La secuencia es:
1. cargar librerías
2. cargar datos
3. plantear el caso
4. resolver una misma pregunta visual con varias librerías o enfoques
5. conectar eso con Shiny

No está hecho para producción.
Está hecho para enseñar.

---

## 2. Librerías de R

### `library(ggplot2)`
Es la librería principal de visualización en R.

Se usa porque:
- organiza el gráfico por capas
- hace visible la gramática del gráfico
- es muy fuerte para docencia

### `library(dplyr)`
Sirve para manipular datos.

Se usa para:
- filtrar
- seleccionar columnas
- agrupar
- resumir
- ordenar

### `library(gapminder)`
Trae el dataset `gapminder`.

### `library(plotly)`
Sirve para hacer visualizaciones interactivas.

### `library(scales)`
Ayuda a formatear ejes y números, por ejemplo moneda.

---

## 3. Dónde se cargan los datos en R

Cuando ves:

```r
df <- gapminder
```

eso significa:
- tomar el dataset `gapminder`
- guardarlo en una variable llamada `df`

Luego aparece algo como:

```r
year_selected <- 2007
df_2007 <- df %>% filter(year == year_selected)
```

Eso significa:
- definir el año de análisis
- crear una tabla filtrada con solo ese año

`df` = todos los años  
`df_2007` = solo un corte del año 2007

---

## 4. Qué significa cada parte en `ggplot2`

Ejemplo:

```r
ggplot(df_2007, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point(alpha = 0.7)
```

### `ggplot(df_2007, ...)`
Le dice al gráfico de dónde salen los datos.

### `aes(...)`
Quiere decir `aesthetics`, o sea, cómo conectas variables con atributos visuales.

### `x = gdpPercap`
La columna `gdpPercap` va en el eje X.

### `y = lifeExp`
La columna `lifeExp` va en el eje Y.

### `color = continent`
El color depende del continente.

### `size = pop`
El tamaño depende de la población.

### `geom_point()`
Dice qué geometría usar.
En este caso, puntos.

### `alpha = 0.7`
Controla transparencia.

---

## 5. Dónde se cambian colores en R

### En Base R

```r
plot(..., col = "steelblue")
barplot(..., col = "darkcyan")
hist(..., col = "tomato")
```

### En ggplot2

#### Color fijo

```r
geom_col(fill = "#2F8373")
```

#### Color según categoría

```r
aes(color = continent)
```

#### Relleno según categoría

```r
aes(fill = continent)
```

### En Plotly

```r
color = ~continent
```

Si preguntas “dónde cambio el color”, en R normalmente buscas:
- `col =`
- `fill =`
- `color =`

---

## 6. Dónde se cambian títulos y etiquetas en R

### En Base R

```r
main = "Mi título"
xlab = "Texto eje X"
ylab = "Texto eje Y"
```

### En ggplot2

```r
labs(
  title = "Mi título",
  x = "Texto eje X",
  y = "Texto eje Y"
)
```

### En Plotly

```r
layout(
  title = "Mi título",
  xaxis = list(title = "Texto eje X"),
  yaxis = list(title = "Texto eje Y")
)
```

---

## 7. Qué hace `dplyr` en el código

Cuando ves algo así:

```r
ranking <- df_2007 %>%
  select(country, lifeExp) %>%
  arrange(desc(lifeExp)) %>%
  slice_head(n = 15)
```

significa:

### `%>%`
“Toma esto y luego haz esto otro”.

Es una forma encadenada de leer el proceso.

### `select(country, lifeExp)`
Escoge solo esas columnas.

### `arrange(desc(lifeExp))`
Ordena de mayor a menor.

### `slice_head(n = 15)`
Se queda con las primeras 15 filas.

O sea:
- elige columnas
- ordena
- corta el top 15

---

## 8. Qué hace cada familia visual en el `.Rmd`

### Correlation
Pregunta:
`¿Hay relación entre PIB per cápita y esperanza de vida?`

Sirve para comparar dos variables numéricas.

### Ranking
Pregunta:
`¿Qué países están arriba y abajo?`

Sirve para ordenar y priorizar.

### Distribution
Pregunta:
`¿Cómo se distribuye la esperanza de vida?`

Sirve para ver forma, dispersión y outliers.

### Change over Time
Pregunta:
`¿Cómo cambia la esperanza de vida a través del tiempo?`

Sirve para tendencias.

---

## 9. Qué hace `app_demo.R`

Ese archivo ya no es para comparar librerías.

Es para mostrar la app final en Shiny.

Entonces:

`Rmd = enseñar`

`Shiny = aplicar`

---

## 10. Explicación de `app_demo.R`

El archivo tiene dos grandes partes:
- `ui`
- `server`

Esa es la idea clave de Shiny.

---

## 11. Qué significa la parte `ui`

### `ui <- fluidPage(...)`
Es la página principal de la app.

### `titlePanel(...)`
Pone el título arriba.

### `sidebarLayout(...)`
Divide la pantalla en:
- barra lateral
- panel principal

### `sidebarPanel(...)`
Contiene los filtros del usuario.

### `selectInput(...)`
Crea un selector.

Ejemplo:

```r
selectInput(
  inputId = "continente",
  label = "Continentes",
  choices = levels(gapminder$continent),
  selected = levels(gapminder$continent),
  multiple = TRUE
)
```

Eso significa:
- `inputId`: nombre interno del filtro
- `label`: texto que ve el usuario
- `choices`: opciones disponibles
- `selected`: opciones que arrancan seleccionadas
- `multiple = TRUE`: se pueden elegir varias

### `sliderInput(...)`
Crea el control para mover el año.

### `tabsetPanel(...)`
Crea pestañas.

### `plotOutput(...)`
Reserva un espacio para un gráfico.

### `tableOutput(...)`
Reserva un espacio para una tabla.

---

## 12. Qué significa la parte `server`

### `server <- function(input, output) { ... }`
Es el motor de la app.

### `input`
Contiene lo que eligió el usuario.

Ejemplos:
- `input$continente`
- `input$anio`
- `input$indicador_ranking`

### `output`
Es lo que la app va a mostrar.

Ejemplos:
- `output$scatter`
- `output$ranking`
- `output$tabla`

---

## 13. Qué significa `reactive`

Ejemplo:

```r
datos_filtrados <- reactive({
  gapminder %>%
    filter(continent %in% input$continente, year == input$anio)
})
```

Eso significa:
- crear un objeto que se recalcula
- cada vez que cambian los filtros

Es la pieza central de Shiny.

No es una tabla fija.
Es una tabla viva.

---

## 14. Qué significa `renderPlot`

Ejemplo:

```r
output$scatter <- renderPlot({
  ggplot(...)
})
```

Eso significa:
- construir un gráfico
- conectarlo con una salida de la UI

Si en la UI existe:

```r
plotOutput("scatter")
```

y en el server existe:

```r
output$scatter <- renderPlot(...)
```

entonces esos dos nombres se conectan.

---

## 15. Dónde pueden cambiar cosas los estudiantes

Cambios seguros:
- el título de la app
- el nombre de una pestaña
- el color de un gráfico
- el valor inicial del slider
- el indicador usado para el ranking
- el texto de `helpText`

Cambios un poco más avanzados:
- agregar un filtro nuevo
- cambiar un `plotOutput` por otro tipo de salida
- modificar la variable del eje

---

## 16. Cómo explicarlo en clase

Una forma simple:

`Con el R Markdown pensamos y comparamos.`

`Con Shiny envolvemos ese análisis en una app.`

Y la idea más importante:

`UI es lo que el usuario ve.`

`Server es lo que la app hace.`
