# =========================
# LIBRERÍAS
# =========================

# Carga Shiny → permite crear aplicaciones web interactivas en R
library(shiny)

# Carga ggplot2 → para construir gráficos profesionales
library(ggplot2)

# Carga dplyr → para manipulación y transformación de datos
library(dplyr)

# Carga gapminder → dataset de ejemplo con información de países
# incluye esperanza de vida, PIB per cápita y población
library(gapminder)

# Carga scales → ayuda a formatear ejes (por ejemplo dólares)
library(scales)


# =========================
# UI = USER INTERFACE
# (Lo que el usuario ve)
# =========================

ui <- fluidPage(

  # Título principal de la aplicación
  titlePanel("Desarrollo Humano Global · Shiny by Dani"),

  # Layout principal:
  # izquierda = filtros
  # derecha = gráficos
  sidebarLayout(

    # =========================
    # PANEL IZQUIERDO (Filtros)
    # =========================
    sidebarPanel(

      # Subtítulo
      h4("Filtros del caso"),

      # -------------------------
      # Filtro 1: Continentes
      # -------------------------

      selectInput(

        # nombre interno del input
        inputId  = "continente",

        # nombre visible para el usuario
        label    = "Continentes",

        # opciones disponibles
        # toma automáticamente los continentes del dataset
        choices  = levels(gapminder$continent),

        # selecciona todos por defecto
        selected = levels(gapminder$continent),

        # permite seleccionar varios al tiempo
        multiple = TRUE
      ),

      # -------------------------
      # Filtro 2: Año
      # -------------------------

      sliderInput(

        # nombre interno
        inputId = "anio",

        # nombre visible
        label   = "Año",

        # valor mínimo del slider
        min     = min(gapminder$year),

        # valor máximo
        max     = max(gapminder$year),

        # valor inicial
        value   = 2007,

        # saltos de 5 años
        step    = 5,

        # evita separar miles
        sep     = ""
      ),

      # -------------------------
      # Filtro 3: Indicador ranking
      # -------------------------

      selectInput(

        inputId = "indicador_ranking",

        label   = "Indicador para ranking",

        # izquierda = texto bonito
        # derecha = nombre real de la columna
        choices = c(
          "Esperanza de vida" = "lifeExp",
          "PIB per cápita"    = "gdpPercap",
          "Población"         = "pop"
        )
      ),

      # Línea separadora visual
      hr(),

      # Texto explicativo del caso de negocio
      helpText(
        "Caso S1: una organización internacional quiere entender cómo ha cambiado",
        "el desarrollo humano y qué regiones debería mirar primero."
      )
    ),

    # =========================
    # PANEL DERECHO (Resultados)
    # =========================

    mainPanel(

      # Tabs = pestañas
      tabsetPanel(

        # -------------------------
        # TAB 1 → Scatter plot
        # -------------------------
        tabPanel(
          "Correlación",
          br(), # salto de línea
          plotOutput("scatter", height = "460px")
        ),

        # -------------------------
        # TAB 2 → Línea de tiempo
        # -------------------------
        tabPanel(
          "Cambio en el tiempo",
          br(),
          plotOutput("linea", height = "460px")
        ),

        # -------------------------
        # TAB 3 → Ranking
        # -------------------------
        tabPanel(
          "Ranking",
          br(),
          plotOutput("ranking", height = "460px")
        ),

        # -------------------------
        # TAB 4 → Boxplot
        # -------------------------
        tabPanel(
          "Distribución",
          br(),
          plotOutput("boxplot", height = "460px")
        ),

        # -------------------------
        # TAB 5 → Tabla
        # -------------------------
        tabPanel(
          "Tabla",
          br(),
          tableOutput("tabla")
        )
      )
    )
  )
)


# =========================
# SERVER
# (La lógica detrás)
# =========================

server <- function(input, output) {

  # ==================================================
  # REACTIVE 1 → Datos filtrados por continente y año
  # ==================================================

  datos_filtrados <- reactive({

    # req() evita errores si no hay selección
    req(input$continente)

    gapminder %>%

      # filtra:
      # solo continentes seleccionados
      # solo el año seleccionado
      filter(
        continent %in% input$continente,
        year == input$anio
      )
  })


  # ==================================================
  # REACTIVE 2 → Serie de tiempo
  # ==================================================

  serie_tiempo <- reactive({

    gapminder %>%

      # filtra continentes seleccionados
      filter(continent %in% input$continente) %>%

      # agrupa por año y continente
      group_by(year, continent) %>%

      # calcula promedio de esperanza de vida
      summarise(
        lifeExp = mean(lifeExp),

        # evita warnings
        .groups = "drop"
      )
  })


  # ==================================================
  # GRÁFICO 1 → Scatter Plot
  # ==================================================

  output$scatter <- renderPlot({

    ggplot(

      # usa los datos filtrados
      datos_filtrados(),

      # mapeo de variables
      aes(
        x = gdpPercap,   # eje X
        y = lifeExp,     # eje Y
        size = pop,      # tamaño burbuja
        color = continent # color por continente
      )
    ) +

      # crea puntos
      geom_point(alpha = 0.7) +

      # eje X logarítmico y en dólares
      scale_x_log10(labels = dollar) +

      # tamaño de burbujas
      scale_size(
        range = c(2, 15),
        guide = "none"
      ) +

      # títulos
      labs(
        title = paste(
          "Correlación entre PIB per cápita y esperanza de vida ·",
          input$anio
        ),
        x = "PIB per cápita (USD, escala logarítmica)",
        y = "Esperanza de vida (años)",
        color = "Continente"
      ) +

      # estilo visual limpio
      theme_minimal(base_size = 14) +

      # leyenda abajo
      theme(legend.position = "bottom")
  })


  # ==================================================
  # GRÁFICO 2 → Línea de tiempo
  # ==================================================

  output$linea <- renderPlot({

    ggplot(
      serie_tiempo(),

      aes(
        x = year,
        y = lifeExp,
        color = continent
      )
    ) +

      geom_line(linewidth = 1.2) +
      geom_point(size = 2) +

      labs(
        title = "Cambio en el tiempo: esperanza de vida promedio por continente",
        x = "Año",
        y = "Esperanza de vida promedio",
        color = "Continente"
      ) +

      theme_minimal(base_size = 14)
  })


  # ==================================================
  # GRÁFICO 3 → Ranking Top 10
  # ==================================================

  output$ranking <- renderPlot({

    # crea tabla temporal ranking
    ranking <- datos_filtrados() %>%

      # selecciona país + indicador elegido
      select(
        country,
        !!sym(input$indicador_ranking)
      ) %>%

      # orden descendente
      arrange(
        desc(.data[[input$indicador_ranking]])
      ) %>%

      # top 10
      slice_head(n = 10)

    ggplot(
      ranking,

      aes(
        # reorder ordena las barras
        x = reorder(
          country,
          .data[[input$indicador_ranking]]
        ),

        y = .data[[input$indicador_ranking]]
      )
    ) +

      geom_col(fill = "#2F8373") +

      # barras horizontales
      coord_flip() +

      labs(
        title = "Top 10 según el indicador seleccionado",
        x = "País",
        y = input$indicador_ranking
      ) +

      theme_minimal(base_size = 14)
  })


  # ==================================================
  # GRÁFICO 4 → Boxplot
  # ==================================================

  output$boxplot <- renderPlot({

    ggplot(
      datos_filtrados(),

      aes(
        x = continent,
        y = lifeExp,
        fill = continent
      )
    ) +

      geom_boxplot(
        alpha = 0.7,
        show.legend = FALSE
      ) +

      labs(
        title = "Distribución de esperanza de vida por continente",
        x = "Continente",
        y = "Esperanza de vida (años)"
      ) +

      theme_minimal(base_size = 14)
  })


  # ==================================================
  # TABLA FINAL
  # ==================================================

  output$tabla <- renderTable({

    datos_filtrados() %>%

      # columnas seleccionadas
      select(
        country,
        continent,
        year,
        lifeExp,
        gdpPercap,
        pop
      ) %>%

      # orden descendente
      arrange(desc(lifeExp)) %>%

      # renombrar columnas
      rename(
        "País"            = country,
        "Continente"      = continent,
        "Año"             = year,
        "Esp. de vida"    = lifeExp,
        "PIB per cápita"  = gdpPercap,
        "Población"       = pop
      )

  },

  # estilo de tabla
  striped = TRUE,
  hover = TRUE,
  bordered = TRUE
  )
}


# =========================
# EJECUTAR LA APP
# =========================

# Lanza la aplicación Shiny
shinyApp(ui = ui, server = server)
