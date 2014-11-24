library(shiny)

shinyUI(pageWithSidebar(
  #Application title
  headerPanel("Body Mass Index (BMI) Calculator"),
  sidebarPanel(
    h3('What are your height and weight?'),
    tabsetPanel(id = "inputUnit", position = "left",
      tabPanel("Metric Units", 
               numericInput('inputHeight', 'Height (cm)', 170, min=120, max=250, step=1),
               numericInput('inputWeight', 'Weight (kg)', 65, min=30, max=300, step=1),
               submitButton('Calculate BMI'),
               value = "Metric"
               ),
      tabPanel("English Units", 
               numericInput('inputHeightFt', 'Height (ft)', 5, min=4, max=8, step=1),
               numericInput('inputHeightIn', 'Height (in)', 7, min=0, max=11, step=1),
               numericInput('inputWeightLbs', 'Weight (lbs)', 143, min=80, max=661, step=1),
               submitButton('Calculate BMI'),
               value = "English"
      ) 
    )),
  mainPanel(
    h2('What is BMI?'),
    ("Body Mass Index (BMI) is a measure of relative weight, based on a person's height. According to the US Center for Desease Control and Prevention, BMI is a fairly reliable indicator of body fatness for most people. BMI has been shown to be correlated with direct measures of body fat, such as underwater weighing and dual energy x-ray absorptiometry (DXA). Therefore, BMI is commonly used as an inexpensive and easy-to-perform technique of screening for weight categories that may lead to health problems."),
    h2('Your Results'),
    conditionalPanel(
      condition = "input.inputUnit == 'Metric'",
      #Display BMI based on Metric inputs
      'Based on your height of', 
      textOutput('inputHeight', inline = TRUE), 
      'cm and weight of', 
      textOutput('inputWeight', inline = TRUE),
      'kg, your BMI is:',
      h4(textOutput('BMI_Metric', inline = TRUE))
    ),
    conditionalPanel(
      condition = "input.inputUnit == 'English'",
      #Display BMI based on English inputs
      'Based on your height of', 
      textOutput('inputHeightFt', inline = TRUE), 
     'ft',
      textOutput('inputHeightIn', inline = TRUE), 
      'inches and weight of', 
      textOutput('inputWeightLbs', inline = TRUE),
      'pounds, your BMI is:',
      h4(textOutput('BMI_English', inline = TRUE))
    ),
    h2('How to Interpret Your BMI?'),
    ("For both men and women 20 years old and older, BMI is interpreted using standard weight status categories that are the same for all age groups. The standard weight status categories associated with BMI ranges for adults are shown in the following table."),
    dataTableOutput('tableBMIStatus'),
    ("Keep in mind that BMI is not a direct measure of body fat and may produce misleading results for certain individuals, such as athletes with a high proportion of muscle. Furthermore, body fat is only one of many risk factors for disease."),
    h2("More Information"),
    tags$ul("For more information on the Body Mass Index, please visit the",
a("US Center for Disease Control and Prevention (CDC)", href="http://www.cdc.gov/healthyweight/assessing/bmi/adult_bmi/index.html"), "."),
    tags$ul(("For more information on healthy eating, please visit the"),
a("Academy of Nutrition and Dietetics", href="http://www.eatright.org/"), ("."))

  )))