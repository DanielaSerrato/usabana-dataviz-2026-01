# Script de instalacion de paquetes para los ejemplos de R
# Corre este archivo una sola vez antes de usar el Rmd o la app Shiny.

paquetes_necesarios <- c(
  "shiny",      # apps web en R
  "ggplot2",    # visualizacion
  "dplyr",      # transformacion de datos
  "gapminder",  # dataset de ejemplo
  "plotly",     # graficos interactivos
  "scales",     # formato de ejes y etiquetas
  "rmarkdown",  # abrir y ejecutar archivos .Rmd
  "knitr"       # soporte para notebooks y render
)

paquetes_faltantes <- paquetes_necesarios[
  !paquetes_necesarios %in% installed.packages()[, "Package"]
]

if (length(paquetes_faltantes) > 0) {
  message("Instalando: ", paste(paquetes_faltantes, collapse = ", "))
  install.packages(paquetes_faltantes)
} else {
  message("Todos los paquetes ya estan instalados.")
}

invisible(lapply(paquetes_necesarios, library, character.only = TRUE))
message("Instalacion completa. Ya puedes abrir el Rmd o correr app_demo.R.")
