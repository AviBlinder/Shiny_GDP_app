library(shiny)
#ui.r
curYear <- as.numeric(format(Sys.time(), "%Y"))

shinyUI(fluidPage(
    
    titlePanel(
        h2("GDP Historic Levels by Country",align="left"),
        ),
    sidebarLayout(
        sidebarPanel(
            br(),
            sliderInput("rangeslider", label = h4("Period's Range"), min = 1970, 
                        max = curYear, value = c(1970, curYear)),
        
            helpText("The following drop-down is a list of countries to be displayed."),
            helpText("Please pick one or more."),
            br(),
            helpText(em("The source of the dataset is taken from the UNdata site")),
            a(href = "http://data.un.org/Default.aspx", strong("Dataset site",align = "center",style = "color:blue")),
            br(),
            br(),
            uiOutput("choose_country") # this is coming from renderUI in server.r
            ),    
        mainPanel(
            plotOutput("plot")
                )
    )
))