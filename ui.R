library(shiny)

# Define UI for dataset viewer application
shinyUI(
    pageWithSidebar(
        # Application title
        headerPanel("Compute Aquifer Drawdown Due to Pumping"),
        
        sidebarPanel(
            p("This app computes how much the groundwater level will drop at
              a given distance from a pumping well. The user inputs the pumping rate 
              from the well, the transmissivity (how permeable the aquifer is)
              the distance from the well and how long the well was pumped."),
            p("It also outputs a graph showing the water level drop over time"),
            h3('Input Parameters'),
            numericInput('rate', 'Pumping rate m3/day',200,min = 0.5, max = 1000, step = 5),
            numericInput('radius', 'Distance from pumping well (meters)', 5, min = 0.5, max = 1000, step = 5),
            numericInput('trans', 'Transmissivity m2/day', 300),
            numericInput('duration', 'Pumping time (hours)', 6,min=2,max=72,step=1)
#            submitButton('Submit')
        ),
        mainPanel(
            h3('Drawdown Results'),
            h4('Drawdown at the end of pumping at specified distance from pumping well'),
            verbatimTextOutput("ddnf"),
            h4('Drawdown over time at specified distance '),
            plotOutput('ddn.g')
        )
    )
)
