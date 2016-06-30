
getDataFrame <- function(directory, filesType = "csv") {
  
  
    # creates a list of files
    filesList <- list.files(directory, full.names = TRUE)
    
    listData <- lapply(filesList, fread,
                       header = T,
                       sep = ',',
                       na.strings = c("", "NA"),
                       stringsAsFactors = TRUE,
                       encoding = "Latin-1")

    # combine temporary lists into a single dataframe
    dataFrame <- do.call(rbind, listData)

    # free memory
    rm(listData, filesList)

    dataFrame
}

getUniqueRecords <- function(dataset, nRecords = "all") {
  
  uniqueCountTable <- as.data.frame(table(dataset))
  
  uniqueCountAndSortDesc <- uniqueCountTable[order(uniqueCountTable$Freq, 
                                                   decreasing = TRUE),]

  if (nRecords == "all") {
    uniqueCountAndSortDesc
  } else {
    head(uniqueCountAndSortDesc, nRecords)
  }
}


hourlyVsJobsChart <- function(dataFrame, 
                           xCol = NULL, 
                           yCol = NULL,
                           xLable = NULL,
                           yLable = NULL,
                           title = NULL) {
  
  print('in Scatterplot area')
  
  # alpha = 1/10, use it in geom_point for large data set
  g <- ggplot(dataFrame, aes(get(xCol), get(yCol))) +
    geom_point(na.rm = TRUE, colour = "red", size = 3) +
    scale_x_continuous(name=xLable) + 
    scale_y_continuous(name=yLable) + 
    # Reduce line spacing and use bold text
    ggtitle(title) + 
    theme(plot.title = element_text(lineheight=.8, face="bold"))
  
  g
  
}


uniqueCountriesChart <- function(dataset, 
                                 nCountries, 
                                 xLable = NULL,
                                 yLable = NULL, 
                                 title) {
  
  uniqueCountAndSortDesc <- getUniqueRecords(dataset, nCountries)
  
  uniqueCountriesList = vector()
  counter <- 1
  for( i in 1:nCountries) {
    for (j in 1:uniqueCountAndSortDesc[[2]][i]) {
      
      uniqueCountriesList[counter] <- as.vector(uniqueCountAndSortDesc[[1]][i])
      counter <- counter + 1
    }
  }
  
  ucDF <- as.data.frame(uniqueCountriesList)
  names(ucDF) <- "Country"
  
  g <- ggplot(mapping = aes(Country), data = ucDF) + 
    geom_bar(width=1, color="blue", fill="steelblue") + 
    scale_x_discrete(name=xLable) + 
    scale_y_continuous(name=yLable) +
    theme_minimal() + 
    ggtitle(title) + 
    theme(
      axis.text.x = element_text(angle = 60, vjust=.5),
      plot.title = element_text(lineheight=.8, face="bold")
    )
  g
}


trim <- function (x) gsub("^\\s+|\\s+$", "", x)

specify_decimal <- function(x, k) format(round(x, k), nsmall=k)