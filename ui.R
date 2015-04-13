library(shiny)
#ui.r

shinyUI(fluidPage(
    
    titlePanel(
        h3("GDP Historic Levels by Country",align="center"),
        ),
    sidebarLayout(
        sidebarPanel(
            helpText("The following drop-down is a list of countries to be displayed."),
            helpText("Please pick one."),
            br(),
            helpText(em("The source of the dataset is taken from the UNdata site")),
            br(),
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