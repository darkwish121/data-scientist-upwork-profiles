library(shiny)
library(shinyjs)

shinyUI(fluidPage(
  theme = "style.css",
  # Application title
  titlePanel("Data Scientists profiles Insights"),
  tags$head(
    tags$script(src = "custom.js", type = "text/javascript")
  ),
  sidebarPanel(
    useShinyjs(),
    uiOutput("uniqueCountriesControls"),
    tags$small("Default top 20 countries listed"),
    tags$br(),
    tags$br(),
    uiOutput("uniqueCountriesOptions"),
    tags$hr(),
    uiOutput("hourlyRatesStats"),
    tags$hr(),
    tags$h3("Filter Profiles"),
    tags$hr(),
    uiOutput("hourlyRatesOptions"),
    tags$hr(),
    uiOutput("nJobsOptions"),
    tags$hr(),
    uiOutput("jobSuccessRateOptions"),
    tags$hr(),
    uiOutput("nHoursWorkedOptions"),
    tags$hr(),
    uiOutput("nRatingsOptions"),
    tags$hr(),
    uiOutput("availabilityOptions"),
    tags$hr(),
    uiOutput("TermsOptions"),
    tags$hr(),
    tags$span("Please change filters to produce results", class="warning", id="filterWarning"),
    tags$br(),
    actionButton("submitFilters", "Submit", class = "btn-primary")
  ),
  mainPanel(
    uiOutput("totalProfiles"),
    tags$hr(),
    plotOutput("uniqueCountriesChart", width = "100%", height = "600px"),
    tags$hr(),
    uiOutput('hourlyRatesChartContainer'),
    tags$br(),
    tags$div(id = 'dataChunkHeading', class = 'heading',
             tags$hr(),
             tags$h3('Users Profiles'),
             actionButton("toggleDataChunk", "Hide Profiles", class = "btn-primary")
    ),
    dataTableOutput('dataChunk')
    
    
  )
))