#server.r
library(shiny)
library(ggplot2)

gdp <- readRDS("./data//gdp.rds")

countries <- as.character(unique(gdp$Country.or.Area))

shinyServer(function(input, output) {
    
    output$choose_country <- renderUI({
        
    selectizeInput("country_selection", "Choose a country:",
                choices = countries,
                selected = "United States"
                )
    })  
        
    #output the plot
    output$plot <- renderPlot({
    
        #get the subset of choosen country
        country_plot <- subset(gdp,Country.or.Area == input$country_selection)
        
        #get min. and max years of data
        Yrange <- range(country_plot$Year)
        #calc mid point
        mid <- round((min(country_plot$Year)+max(country_plot$Year))/2,0)
        
 #       plot(country_plot$Year,country_plot$Value,ylab = "GDP in US $",type="l",col="blue",
 #        xlab=input$country_selection,xlim=Yrange)        

        title <- paste("Historic GDP information for",input$country_selection)
 
        ggplot(data = country_plot,aes(x = Year,y = Value)) + 
        geom_line(colour = "darkgreen",size=2)  +
        scale_x_continuous(limits = Yrange) +
        theme_bw(base_size = 16, base_family = "Helvetica") +
        ggtitle (title ) +
        xlab("Year") +
        ylab ("GDP in US $" ) 
    })
})