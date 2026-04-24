# Guia rapida para correr los ejemplos de la clase

Esta guia es para estudiantes que quieran abrir los ejemplos de `Python + Streamlit` o `R + Shiny` fuera de clase.

Si algo no te corre, no te preocupes: casi siempre el problema es instalacion, ruta o paquetes faltantes.

---

## 1. Que necesitas tener instalado

### Opcion A · Para correr el ejemplo de Python
- Python 3.10 o superior
- VS Code o cualquier editor de texto
- Terminal o PowerShell

### Opcion B · Para correr el ejemplo de R
- R
- RStudio

No necesitas dominar Python ni R para probar los ejemplos. Solo seguir los pasos.

---

## 2. Archivos de esta clase

### Notebook de clase
- `clase_s1/notebooks/python_visual_vocabulary_gapminder.ipynb`
- `clase_s1/notebooks/r_visual_vocabulary_gapminder.Rmd`

### Python
- `clase_s1/streamlit/app_demo.py`
- `clase_s1/streamlit/requirements.txt`

### R
- `clase_s1/shiny/app_demo.R`
- `clase_s1/shiny/instalar_paquetes.R`

---

## 3. Paso a paso · Notebook de Python

### Paso 1
Abre una terminal en la carpeta:

```powershell
cd "C:\Users\Dani Serrato\Documents\Herramientas de Viz"
```

### Paso 2
Instala lo necesario si no lo tienes:

```powershell
pip install notebook jupyter pandas matplotlib seaborn plotly
```

Si `pip` no funciona, prueba:

```powershell
python -m pip install notebook jupyter pandas matplotlib seaborn plotly
```

### Paso 3
Abre Jupyter:

```powershell
jupyter notebook
```

### Paso 4
En el navegador, entra a:

`clase_s1/notebooks/python_visual_vocabulary_gapminder.ipynb`

### Paso 5
Ejecuta las celdas en orden.

---

## 4. Paso a paso · Python + Streamlit

### Paso 1
Abre una terminal en la carpeta:

```powershell
cd "C:\Users\Dani Serrato\Documents\Herramientas de Viz\clase_s1\streamlit"
```

### Paso 2
Instala las librerias necesarias:

```powershell
pip install -r requirements.txt
```

Si `pip` no funciona, prueba:

```powershell
python -m pip install -r requirements.txt
```

### Paso 3
Corre la app:

```powershell
streamlit run app_demo.py
```

Si `streamlit` no funciona, prueba:

```powershell
python -m streamlit run app_demo.py
```

### Paso 4
Se deberia abrir una pagina en el navegador.
Si no se abre sola, copia manualmente la direccion que salga en la terminal.
Normalmente es:

```text
http://localhost:8501
```

---

## 5. Paso a paso · R + Shiny

### Paso 1
Abre `RStudio`

### Paso 2
Abre el archivo:

`clase_s1/shiny/instalar_paquetes.R`

### Paso 3
Ejecuta todo el script una sola vez.
Eso instala:
- `shiny`
- `ggplot2`
- `dplyr`
- `gapminder`
- `plotly`
- `scales`
- `rmarkdown`
- `knitr`

### Paso 4
Si quieres abrir el notebook de R, no copies el archivo en la consola.

Debes abrir en RStudio el archivo:

`clase_s1/notebooks/r_visual_vocabulary_gapminder.Rmd`

y luego:
- ejecutar chunks con el boton `Run`
- o hacer clic en `Preview` / `Knit`

### Paso 5
Abre el archivo:

`clase_s1/shiny/app_demo.R`

### Paso 6
Haz clic en `Run App`

Tambien puedes correr en consola:

```r
shiny::runApp("C:/Users/Dani Serrato/Documents/Herramientas de Viz/clase_s1/shiny")
```

---

## 6. Si no te corre Python

### Error comun
`ModuleNotFoundError`

### Que significa
Te falta instalar una libreria.

### Solucion
Vuelve a correr:

```powershell
pip install -r requirements.txt
```

---

## 7. Si no te corre R

### Error comun
`there is no package called ...`

### Que significa
Falta un paquete.

### Solucion
Corre de nuevo `instalar_paquetes.R`

### Error comun 2
`Error en -title: argumento no válido para un operador unitario`

### Que significa
Intentaste pegar un archivo `.Rmd` completo dentro de la consola de R.

### Solucion
No pegues el encabezado que empieza por `---`.
Ese archivo se debe abrir en `RStudio` como notebook, no ejecutar linea por linea en consola.

---

## 8. Si la app abre pero no muestra datos

Los ejemplos usan el dataset `Gapminder`.
Si hay un problema temporal de conexion, vuelve a intentar.

En clase, la docente puede tener una copia local o ayudarte a revisar el problema.

---

## 9. Si no te abre el notebook

### Error comun
`jupyter is not recognized as an internal or external command`

### Solucion
Prueba:

```powershell
python -m notebook
```

o

```powershell
python -m jupyter notebook
```

---

## 10. Que puedes cambiar sin miedo

### En Python o en R
- El titulo de la app
- El color de un grafico
- El ano inicial
- El continente seleccionado
- El texto de una pestaña
- El indicador del ranking

La idea no es escribir una app nueva.
La idea es modificar algo pequeno y ver el efecto.

---

## 11. Si nada funciona

Envia captura de:
- el error completo
- el comando que corriste
- la ruta en la que estabas

Eso ayuda mucho mas que decir solo "no me corre".
