# Guía de código · Python

Esta guía explica, en lenguaje simple, qué hace cada parte del material de Python de la clase.

Archivos que acompaña:
- `clase_s1/notebooks/python_visual_vocabulary_gapminder.ipynb`
- `clase_s1/streamlit/app_demo.py`

La idea es separar dos momentos:
- `Notebook`: para enseñar visualización paso a paso
- `Streamlit`: para convertir el análisis en app

---

## 1. Qué hace el notebook de Python

El notebook está pensado para mostrar el mismo problema con varias librerías.

Orden pedagógico:
1. cargar datos
2. entender el caso
3. escoger una familia visual
4. mostrar cómo se ve con `matplotlib`
5. mostrar cómo se ve con `seaborn`
6. mostrar cómo se ve con `plotly`

Eso ayuda a que el estudiante compare:
- sintaxis
- estética
- interactividad
- facilidad de uso

---

## 2. Librerías del notebook

### `import pandas as pd`
Sirve para trabajar con tablas de datos.

Piensa en `pandas` como la herramienta principal para:
- filtrar filas
- seleccionar columnas
- agrupar
- calcular promedios

### `import matplotlib.pyplot as plt`
Es la librería base para hacer gráficos en Python.

Se usa cuando quieres mostrar:
- la estructura básica de un gráfico
- cómo se controlan ejes, títulos y etiquetas

### `import seaborn as sns`
Es una capa más amigable sobre `matplotlib`.

Se usa porque:
- deja gráficos más bonitos con menos código
- es muy buena para visualización estadística

### `import plotly.express as px`
Sirve para gráficos interactivos.

Se usa porque:
- permite hover
- es ideal para dashboards y apps
- conecta muy bien con Streamlit

---

## 3. Dónde se cargan los datos en el notebook

En el notebook aparece algo como esto:

```python
df = px.data.gapminder().copy()
```

Esto significa:
- `px.data.gapminder()` trae el dataset
- `copy()` hace una copia para trabajar sin modificar el original

La variable `df` es la tabla principal.

Cuando luego ves:

```python
df_2007 = df[df['year'] == year_selected].copy()
```

eso significa:
- tomar solo las filas del año seleccionado
- guardar ese subconjunto en otra tabla

`df` = todos los años  
`df_2007` = solo una foto del año 2007

---

## 4. Qué significa cada parte de un gráfico

Ejemplo típico:

```python
sns.scatterplot(
    data=df_2007,
    x='gdpPercap',
    y='lifeExp',
    hue='continent',
    size='pop'
)
```

### `data=df_2007`
Le dice al gráfico de dónde salen los datos.

### `x='gdpPercap'`
Le dice qué columna va en el eje X.

### `y='lifeExp'`
Le dice qué columna va en el eje Y.

### `hue='continent'`
Le dice que el color depende del continente.

Eso sirve para separar grupos visualmente.

### `size='pop'`
Le dice que el tamaño de los puntos depende de la población.

Eso agrega una tercera dimensión visual.

---

## 5. Dónde se cambian los colores

En Python los colores pueden aparecer de varias formas.

### En matplotlib

```python
ax.scatter(..., color='steelblue')
```

o

```python
ax.barh(..., color='#2F8373')
```

### En seaborn

```python
sns.barplot(..., color='#2F8373')
```

o usando `hue` para que el color dependa de una categoría.

### En plotly

```python
px.bar(..., color='continent')
```

o con una escala manual:

```python
color_continuous_scale=['#D96C4F', '#EBD9C8', '#2E7D6D']
```

Si preguntas “dónde cambio el color”, la respuesta suele ser:
- en el argumento `color=`
- en el argumento `hue=`
- o en una paleta / escala de color

---

## 6. Dónde se cambian títulos y etiquetas

### En matplotlib

```python
ax.set_title('Mi título')
ax.set_xlabel('Texto eje X')
ax.set_ylabel('Texto eje Y')
```

### En seaborn
Como usa `matplotlib` por debajo, muchas veces también cambias el título con `ax.set_title(...)`

### En plotly

```python
px.scatter(..., title='Mi título')
```

o

```python
labels={'lifeExp': 'Esperanza de vida'}
```

Eso sirve para traducir nombres técnicos a nombres más legibles.

---

## 7. Qué hace cada familia visual en el notebook

### Correlation
Pregunta:
`¿Hay relación entre PIB per cápita y esperanza de vida?`

Gráfico:
- scatter plot

Por qué sirve:
- compara dos variables numéricas

### Ranking
Pregunta:
`¿Qué países están arriba o abajo?`

Gráfico:
- barras ordenadas

Por qué sirve:
- el orden importa más que la forma

### Distribution
Pregunta:
`¿Cómo se distribuye la esperanza de vida?`

Gráfico:
- histograma
- boxplot

Por qué sirve:
- muestra dispersión, concentración y posibles outliers

### Change over Time
Pregunta:
`¿Cómo cambia la esperanza de vida en el tiempo?`

Gráfico:
- línea

Por qué sirve:
- el tiempo pide secuencia

---

## 8. Qué hace el archivo `app_demo.py`

Ese archivo ya no compara librerías.

Su función es distinta:
- tomar una solución visual ya elegida
- volverla una app interactiva

O sea:

`notebook = entender y comparar`

`streamlit = explorar y usar`

---

## 9. Explicación de `app_demo.py`

### `st.set_page_config(...)`
Configura cosas generales de la app:
- nombre de la pestaña
- ícono
- ancho del layout

### `st.title(...)` y `st.caption(...)`
Ponen el título principal y una bajada.

### `@st.cache_data`
Hace que la carga de datos no se repita cada vez que se mueve un filtro.

Eso mejora velocidad.

### `def cargar_datos():`
Define una función para traer el dataset.

### `st.sidebar.*`
Todo lo que aparece en la barra lateral son controles del usuario.

Ejemplos:
- multiselect
- slider
- selectbox

### `df_filtrado = ...`
Aquí conectas los filtros con los datos.

Este bloque es clave, porque dice:
- qué filas entran
- qué filas se excluyen

### `st.columns(...)`
Divide la pantalla en columnas.

### `metric(...)`
Muestra un KPI corto arriba.

### `st.tabs(...)`
Divide la app por pestañas temáticas.

### `px.scatter(...)`, `px.line(...)`, `px.bar(...)`, `px.histogram(...)`, `px.pie(...)`
Son los gráficos ya listos para la app.

### `st.plotly_chart(...)`
Le dice a Streamlit que muestre el gráfico de Plotly.

### `st.dataframe(...)`
Muestra la tabla final.

---

## 10. Qué pueden cambiar los estudiantes sin dañar todo

Cambios seguros:
- el título
- el color de una barra o un scatter
- el año inicial
- el indicador del ranking
- el nombre de una pestaña
- el texto de una métrica

Cambios un poco más avanzados:
- agregar un filtro nuevo
- cambiar el gráfico de composición
- cambiar la variable del eje

---

## 11. Cómo explicar esto en clase

Una forma simple de decirlo:

`En el notebook usamos Python para pensar y comparar.`

`En Streamlit usamos Python para entregar una app que otra persona puede explorar.`

Eso hace que los estudiantes entiendan que Streamlit no compite con las librerías.
Las usa.
