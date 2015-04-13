#server.r
library(shiny)
library(ggplot2)

gdp <- readRDS("./data//gdp.rds")

countries <- as.character(unique(gdp$Country.or.Area))

shinyServer(function(input, output) {
    
    output$choose_country <- renderUI({
        
   # selectizeInput("country_selection", 
        checkboxGroupInput("country_selection",
                h4("Choose a country:"),
                choices = countries,
                selected = "United States"
                )
    })  
    
    
    #output the plot
    output$plot <- renderPlot({
        
        if (!(is.numeric(input$rangeslider[1])) || is.na(input$rangeslider[1])){
            input$rangeslider[1] <- min(gdp$Year)
        }

        if (!(is.numeric(input$rangeslider[2]))){
            input$rangeslider[1] <- max(gdp$Year)
        }
        
        #get the subset of choosen country and range of years
        country_plot <- subset(gdp,Country.or.Area %in% input$country_selection & 
                                   Year >= input$rangeslider[1] & Year <= input$rangeslider[2] )
        names(country_plot)[1] <- "Country"
        
        #get min. and max years of data
        Yrange <- range(country_plot$Year)        

#        title <- paste("Historic GDP information for",input$country_selection)
         title <- paste("Historic Gross Domestic Product (GDP) ")
 
        ggplot(data = country_plot,aes(x = Year,y = Value)) + 
        geom_line(aes(colour=Country)) +
        scale_x_continuous(limits = Yrange) +
        theme_bw(base_size = 16, base_family = "Helvetica") +
        ggtitle (title ) +
        xlab("Period") +
        ylab ("GDP in US $" ) 
    })
})