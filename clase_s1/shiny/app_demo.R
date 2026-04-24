library(shiny)
library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)

ui <- fluidPage(

  titlePanel("Desarrollo Humano Global · Shiny"),

  sidebarLayout(

    sidebarPanel(
      h4("Filtros del caso"),

      selectInput(
        inputId  = "continente",
        label    = "Continentes",
        choices  = levels(gapminder$continent),
        selected = levels(gapminder$continent),
        multiple = TRUE
      ),

      sliderInput(
        inputId = "anio",
        label   = "Año",
        min     = min(gapminder$year),
        max     = max(gapminder$year),
        value   = 2007,
        step    = 5,
        sep     = ""
      ),

      selectInput(
        inputId = "indicador_ranking",
        label   = "Indicador para ranking",
        choices = c(
          "Esperanza de vida" = "lifeExp",
          "PIB per cápita"    = "gdpPercap",
          "Población"         = "pop"
        )
      ),

      hr(),
      helpText(
        "Caso S1: una organización internacional quiere entender cómo ha cambiado",
        "el desarrollo humano y qué regiones debería mirar primero."
      )
    ),

    mainPanel(
      tabsetPanel(

        tabPanel(
          "Correlación",
          br(),
          plotOutput("scatter", height = "460px")
        ),

        tabPanel(
          "Cambio en el tiempo",
          br(),
          plotOutput("linea", height = "460px")
        ),

        tabPanel(
          "Ranking",
          br(),
          plotOutput("ranking", height = "460px")
        ),

        tabPanel(
          "Distribución",
          br(),
          plotOutput("boxplot", height = "460px")
        ),

        tabPanel(
          "Tabla",
          br(),
          tableOutput("tabla")
        )
      )
    )
  )
)

server <- function(input, output) {

  datos_filtrados <- reactive({
    req(input$continente)
    gapminder %>%
      filter(
        continent %in% input$continente,
        year == input$anio
      )
  })

  serie_tiempo <- reactive({
    gapminder %>%
      filter(continent %in% input$continente) %>%
      group_by(year, continent) %>%
      summarise(lifeExp = mean(lifeExp), .groups = "drop")
  })

  output$scatter <- renderPlot({
    ggplot(
      datos_filtrados(),
      aes(x = gdpPercap, y = lifeExp, size = pop, color = continent)
    ) +
      geom_point(alpha = 0.7) +
      scale_x_log10(labels = dollar) +
      scale_size(range = c(2, 15), guide = "none") +
      labs(
        title = paste("Correlación entre PIB per cápita y esperanza de vida ·", input$anio),
        x = "PIB per cápita (USD, escala logarítmica)",
        y = "Esperanza de vida (años)",
        color = "Continente"
      ) +
      theme_minimal(base_size = 14) +
      theme(legend.position = "bottom")
  })

  output$linea <- renderPlot({
    ggplot(
      serie_tiempo(),
      aes(x = year, y = lifeExp, color = continent)
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

  output$ranking <- renderPlot({
    ranking <- datos_filtrados() %>%
      select(country, !!sym(input$indicador_ranking)) %>%
      arrange(desc(.data[[input$indicador_ranking]])) %>%
      slice_head(n = 10)

    ggplot(
      ranking,
      aes(
        x = reorder(country, .data[[input$indicador_ranking]]),
        y = .data[[input$indicador_ranking]]
      )
    ) +
      geom_col(fill = "#2F8373") +
      coord_flip() +
      labs(
        title = "Top 10 según el indicador seleccionado",
        x = "País",
        y = input$indicador_ranking
      ) +
      theme_minimal(base_size = 14)
  })

  output$boxplot <- renderPlot({
    ggplot(
      datos_filtrados(),
      aes(x = continent, y = lifeExp, fill = continent)
    ) +
      geom_boxplot(alpha = 0.7, show.legend = FALSE) +
      labs(
        title = "Distribución de esperanza de vida por continente",
        x = "Continente",
        y = "Esperanza de vida (años)"
      ) +
      theme_minimal(base_size = 14)
  })

  output$tabla <- renderTable({
    datos_filtrados() %>%
      select(country, continent, year, lifeExp, gdpPercap, pop) %>%
      arrange(desc(lifeExp)) %>%
      rename(
        "País"            = country,
        "Continente"      = continent,
        "Año"             = year,
        "Esp. de vida"    = lifeExp,
        "PIB per cápita"  = gdpPercap,
        "Población"       = pop
      )
  }, striped = TRUE, hover = TRUE, bordered = TRUE)
}

shinyApp(ui = ui, server = server)
