library(shiny)

#Create unit conversion functions
lbs_to_kg <- function(lbs) {0.453592 * lbs}
ft_in_to_cm <- function(feet,inches) {(feet * 12 + inches) * 2.54}

#Create the BMI calculation function
BMI <- function(Height,Weight) {
  #Calculate BMI = Weight (in kg) / Height (in meters) squared
  round(x = Weight/((Height*0.01)^2), digits = 1)
}

#Table describing weight status for each BMI level
tableBMIStatus <- data.frame(rbind(
  c('Below 18.5', 'Underweight'),
  c('18.5 - 24.9',	'Normal'),
  c('25.0 - 29.9',	'Overweight'),
  c('30.0 and Above',	'Obese')
  ))
colnames(tableBMIStatus) <- c('BMI', 'Weight Status')


shinyServer(
  function(input, output){
    #Output height and weight in Metric units
    output$inputHeight<-renderText({input$inputHeight})
    output$inputWeight<-renderText({input$inputWeight})
    
    #Output height and weight in English units
    output$inputHeightFt<-renderText({input$inputHeightFt})
    output$inputHeightIn<-renderText({input$inputHeightIn})
    output$inputWeightLbs<-renderText({input$inputWeightLbs})
    
    #Output BMI
    output$BMI_Metric <-renderText({BMI(input$inputHeight,input$inputWeight)})
    output$BMI_English <-renderText({BMI(ft_in_to_cm(input$inputHeightFt, input$inputHeightIn),lbs_to_kg(input$inputWeightLbs))})
    
    #Output the currently used unit of measure
    output$inputUnit <- renderText({input$inputUnit})
    
    #Output the BMI status table
    output$tableBMIStatus = renderDataTable({tableBMIStatus}, options = list(searching = F, paging = F, info = F))
  }
)