library(shiny)

# Confined aquifer Well function 
wellf<-function(u) {
    u<-
    if ((u<=1) & (u>0)) {
        C1<-exp(-0.5772)  
        wu<-log(C1/u)+0.9713*u-0.1742*u*u
        return(wu)
        
    } else {
        wu<-1/(u*exp(u))*(u+0.3637)/(u+1.282)
        return(wu)
        
    }
    stop
}

# Hardcoded storage value
stor<-1e-4

shinyServer(
    function(input, output) {
        # Timeseries creation
        tseries = reactive({seq(0,input$duration,by=input$duration/100)+1e-12})
        
        # Parameter u
        u = reactive({input$radius^2*stor/(4*input$trans*input$duration/24)})
        u.t = reactive({input$radius^2*stor/(4*input$trans*tseries()/24)})
        
        # Final drawdown
        output$ddnf <- renderPrint({input$rate/(4*pi*input$trans)*wellf(u())})
        
        # Drawdown timeseries
        ddn.ts =  reactive({input$rate/(4*pi*input$trans)*sapply(u.t(),FUN=wellf)})
        
        # Plot drawdown over time at specified location
        output$ddn.g <- renderPlot({
            plot(tseries(),ddn.ts(),xlab="Time in hours",ylab="Drawdown in meters",
                 ty="l",lwd=2,col="blue")
        })
        
    }
)