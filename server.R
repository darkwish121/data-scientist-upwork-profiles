library(shiny)
library(shinyFiles)
suppressPackageStartupMessages(library(googleVis))
library(data.table)
library(ggplot2)
library(stringr)
suppressPackageStartupMessages(library(bit64))
require(RJSONIO)
source("helpers.R")


dataFrame <- getDataFrame("data/")


shinyServer(function(input, output, session) {
  
  countrySpecificRowsReactive <- reactive({
    
    selectedCountry <- input$uniqueCountries
    if (! is.null(selectedCountry)) {
      if (selectedCountry == "All") {
        countrySpecificRows <- dataFrame
      } else {
        countrySpecificRows <- dataFrame[dataFrame$Country == selectedCountry, ]
      }
      countrySpecificRows
    }
  })
  
  output$uniqueCountriesChart <- renderPlot({
    
    ucPlot <- uniqueCountriesChart(dataFrame$Country, 10, "Countries", 
                                   "Number of Profiles","Top 10 Countries")
    ucPlot
  })
  
  
  observeEvent(input$uniqueCountries, {

    selectedCountry <- input$uniqueCountries
    
    countrySpecificRowsDF = countrySpecificRowsReactive()
    
    # total profiles
    totalProfilesSelected <- nrow(countrySpecificRowsDF)
    output$totalProfiles <- renderUI({
      HTML(paste0("<h4 class='col-centered'>", totalProfilesSelected, " Profile(s) selected.", "</h4>"))
    })
    
    hourlyRates <- countrySpecificRowsDF[["Hourly Rates"]]
    nJobs <- countrySpecificRowsDF[["Number of Jobs"]]
    
    dataDF <- data.frame(nJobs, hourlyRates)

    # draw hourly rates vs number of jobs chart
    
    # create div to render charts
    output$hourlyRatesChartContainer <- renderUI({

        plotOutput("hourlyRatesChart", width = "100%", height = "600px")
    })

    # render chart
    output[["hourlyRatesChart"]] <- renderPlot({
      hourlyVsJobsChart(dataDF, "nJobs", "hourlyRates", "Number of Jobs", 
                  "Hourly Rates", 
                  "Number of Jobs VS Hourly Rates")
    })
    
    # hourly rates operations
    output$hourlyRatesStats <- renderUI({
      
      minHR <- min(hourlyRates)
      maxHR <- max(hourlyRates)
      meanHR <- round(mean(hourlyRates), 2)
      
      HTML(paste0('<p class="">Min hourly rate in ', selectedCountry, " is: ", minHR, "</p>",
                  '<p class="">Max hourly rate in ', selectedCountry, " is: ", maxHR, "</p>",
                  '<p class="">Mean of hourly rate in ', selectedCountry, " is: ", meanHR, "</p>"))
      
    })
    
    # chunks of profiles
    
    output$dataChunk <- renderDataTable({

      headData <- countrySpecificRowsDF
      headData <- lapply(headData, function(x) {
        gsub("[^[:alnum:]///' ,/.~:_]", "", x)
      })

      as.data.frame(headData)
    })
    show('dataChunkHeading')
    

  })
  
  
  # submit form chart options
  observeEvent(input$submitFilters, {
    
    selectedCountry      <- input$uniqueCountries
    hourlyRatesRange     <- input$nHourlyRates
    jobSuccessRateRange  <- input$nJobSuccessRate
    nJobsRange           <- input$nJobs
    hoursWorkedRange     <- input$hoursWorked
    ratingsRange         <- input$ratings
    availabilityOpt      <- input$availability
    termsOpt             <- input$terms
    
    
    hourlyRatesRangeMin <- hourlyRatesRange[[1]]
    hourlyRatesRangeMax <- hourlyRatesRange[[2]]
    
    
    jobSuccessRateRangeMin <- jobSuccessRateRange[[1]]
    jobSuccessRateRangeMax <- jobSuccessRateRange[[2]]
    
    nJobsRangeMin <- nJobsRange[[1]]
    nJobsRangeMax <- nJobsRange[[2]]
    
    hoursWorkedRangeMin <- hoursWorkedRange[[1]]
    hoursWorkedRangeMax <- hoursWorkedRange[[2]]
      
    
    ratingsRangeMin <- ratingsRange[[1]]
    ratingsRangeMax <- ratingsRange[[2]]
    
    countrySpecificRowsDF = countrySpecificRowsReactive()
    
    if (termsOpt == "All") {
    
      filteredSubset <- countrySpecificRowsDF[ which(
                                  countrySpecificRowsDF[["Hourly Rates"]] >= hourlyRatesRangeMin
                                & countrySpecificRowsDF[["Hourly Rates"]] <= hourlyRatesRangeMax
                                & countrySpecificRowsDF[["Job Success Rate"]] >= jobSuccessRateRangeMin
                                & countrySpecificRowsDF[["Job Success Rate"]] <= jobSuccessRateRangeMax
                                & countrySpecificRowsDF[["Number of Jobs"]] >= nJobsRangeMin
                                & countrySpecificRowsDF[["Number of Jobs"]] <= nJobsRangeMax
                                & countrySpecificRowsDF[["Hours Worked"]] >= hoursWorkedRangeMin
                                & countrySpecificRowsDF[["Hours Worked"]] <= hoursWorkedRangeMax
                                & countrySpecificRowsDF[["Ratings"]] >= ratingsRangeMin
                                & countrySpecificRowsDF[["Ratings"]] <= ratingsRangeMax
                                & countrySpecificRowsDF[["Availability"]] == availabilityOpt), ]

    } else {
      
      filteredSubset <- countrySpecificRowsDF[ which(
                              countrySpecificRowsDF[["Hourly Rates"]] >= hourlyRatesRangeMin
                              & countrySpecificRowsDF[["Hourly Rates"]] <= hourlyRatesRangeMax
                              & countrySpecificRowsDF[["Job Success Rate"]] >= jobSuccessRateRangeMin
                              & countrySpecificRowsDF[["Job Success Rate"]] <= jobSuccessRateRangeMax
                              & countrySpecificRowsDF[["Number of Jobs"]] >= nJobsRangeMin
                              & countrySpecificRowsDF[["Number of Jobs"]] <= nJobsRangeMax
                              & countrySpecificRowsDF[["Hours Worked"]] >= hoursWorkedRangeMin
                              & countrySpecificRowsDF[["Hours Worked"]] <= hoursWorkedRangeMax
                              & countrySpecificRowsDF[["Ratings"]] >= ratingsRangeMin
                              & countrySpecificRowsDF[["Ratings"]] <= ratingsRangeMax
                              & countrySpecificRowsDF[["Availability"]] == availabilityOpt
                              & countrySpecificRowsDF[["Terms"]] == termsOpt), ]
      
    }
    
    if(nrow(filteredSubset) > 0) {
  
      hourlyRates <- filteredSubset[["Hourly Rates"]]
      nJobs <- filteredSubset[["Number of Jobs"]]
      
      hourlyRatesDF <- data.frame(nJobs, hourlyRates)
  
      # render chart
      output[["hourlyRatesChart"]] <- renderPlot({
        hourlyVsJobsChart(hourlyRatesDF, "nJobs", "hourlyRates", "Number of Jobs", 
                    "Hourly Rates", 
                    "Number of Jobs VS Hourly Rates")
      })
      
      
      # total profiles
      totalProfilesSelected <- nrow(hourlyRatesDF)
      
      output$totalProfiles <- renderUI({
        HTML(paste0("<h4 class='col-centered'>", totalProfilesSelected, " Profile(s) selected.", "</h4>"))
      })
      
      # chunks of profiles
      
      output$dataChunk <- renderDataTable({
        
        headData <- filteredSubset
        headData <- lapply(headData, function(x) {
          gsub("[^[:alnum:]///' .,/~:_]", "", x)
        })
        
        as.data.frame(headData)
      })
      show('dataChunkHeading')
      hide("filterWarning")
    } else {
      show('filterWarning')
    }
  })
  
    
  
  # side bar
  
  # show unique countries
  observeEvent(input$nUniqueCountries, { 
    
    nUniqueCountries <- input$nUniqueCountries
    
    uniqueCountAndSortDesc <- getUniqueRecords(dataFrame$Country, nUniqueCountries)
    uniqueCountries        <- as.vector(uniqueCountAndSortDesc$dataset)
    
    output$uniqueCountriesControls <- renderUI({
      
      selectInput("uniqueCountries", "Choose a country", c("All", uniqueCountries))
      
    })  
  })
  
  output$uniqueCountriesOptions <- renderUI({
    
    uniqueCountAndSortDesc <- getUniqueRecords(dataFrame$Country)
    uniqueCountries <- as.vector(uniqueCountAndSortDesc$dataset)
    
    sliderInput("nUniqueCountries", 
                "number of countries to list",
                value = 20,
                min = 1,
                max = length(uniqueCountries))
    
  })
  
  # profiles filter options
  
  output$hourlyRatesOptions <- renderUI({
    
    countrySpecificRowsDF = countrySpecificRowsReactive()
    
    if (! is.null(countrySpecificRowsDF)) {
    
      maxHourlyRate <- max(countrySpecificRowsDF[["Hourly Rates"]])
      sliderInput("nHourlyRates",
                  "Hourly Rates",
                  value = c(0, maxHourlyRate),
                  min = 0,
                  max = maxHourlyRate)
    }
  })
  
  output$jobSuccessRateOptions <- renderUI({
    
      sliderInput("nJobSuccessRate",
                  "Job Success Rate",
                  value = c(0, 1),
                  min = 0,
                  max = 1)
  })
  
  output$nJobsOptions <- renderUI({
    
    countrySpecificRowsDF = countrySpecificRowsReactive()
    
    if (! is.null(countrySpecificRowsDF)) {
      
      maxJobNumber <- max(countrySpecificRowsDF[["Number of Jobs"]])
      sliderInput("nJobs",
                  "Number of Jobs",
                  value = c(0, maxJobNumber),
                  min = 0,
                  max = maxJobNumber)
    }
  })
  
  output$nHoursWorkedOptions <- renderUI({
    
    countrySpecificRowsDF = countrySpecificRowsReactive()
    
    if (! is.null(countrySpecificRowsDF)) {
      
      maxHoursWorked <- round(max(countrySpecificRowsDF[["Hours Worked"]]))
      sliderInput("hoursWorked",
                  "Hours Worked",
                  value = c(0, maxHoursWorked),
                  min = 0,
                  max = maxHoursWorked)
    }
  })
  
  output$nRatingsOptions <- renderUI({
    
      sliderInput("ratings",
                  "Rating",
                  value = c(0, 5),
                  min = 0,
                  max = 5,
                  step = 0.1)
  })
  
  output$availabilityOptions <- renderUI({
    
    availabilityVector <- c("As Needed - Open to Offers",
                            "More than 30 hrs/week",
                            "Less than 30 hrs/week")
    
    selectInput("availability",
                "Availability",
                availabilityVector)
  })
  
  output$TermsOptions <- renderUI({
    
    termsVector <- c("All",
                            "R, statistics",
                            "SAS",
                            "Hadoop",
                            "matlab",
                            "octave",
                            "mathematica",
                            "julia")
    
    selectInput("terms",
                "Searched Against",
                termsVector)
  })
  
  hide("filterWarning")
})