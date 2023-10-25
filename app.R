#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)

wd <- getwd()
setwd(wd)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Visualisation of Lifestyle Diseases by Age in the US population, 2005-2006"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          selectInput('visualise', 'Association between', choices = c("Obesity and Age", "Hypertension and Age")),
          
          selectInput('gender', 'Gender', choices = c("All", "Male","Female","Both")),
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("plot")
        )
    ),
    # A new row for the data table
    fluidRow(
      column(width=12,
             dataTableOutput("table"),
      )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  data_obesity <- read.csv(file=file.path("intermediates/data", "obesityTransformedData.csv"),header = TRUE)
  data_obesity_all <- read.csv(file=file.path("intermediates/data", "obeseProbData.csv"),header = TRUE)
  data_obesity_male <- read.csv(file=file.path("intermediates/data", "obeseMaleProbData.csv"),header = TRUE)
  data_obesity_female <- read.csv(file=file.path("intermediates/data","obeseFemaleProbData.csv"),header = TRUE)
  
  data_hypertension <- read.csv(file=file.path("intermediates/data","hypertensionTransformedData.csv"),header = TRUE)
  data_hypertension_all <- read.csv(file=file.path("intermediates/data","hypertensionProbData.csv"),header = TRUE)
  data_hypertension_male <- read.csv(file=file.path("intermediates/data","hypertensionMaleProbData.csv"),header = TRUE)
  data_hypertension_female <- read.csv(file=file.path("intermediates/data","hypertensionFemaleProbData.csv"),header = TRUE)
  
  
    visualise <- reactive({
      input$visualise
    })  
  
    gender <- reactive({
      input$gender
    })  
    
    
    output$plot <- renderPlot({
      
      if(visualise() == "Hypertension and Age"){
        if(gender() == "All"){
          ggplot(data_hypertension_all, aes(x=age,y=hypertension_probability))+geom_line()+
            xlab("age in years") + 
            ylab("Hypertension Probability")
        }
        else if(gender() == "Male"){
          ggplot(data_hypertension_male, aes(x=age,y=male_hypertension_probability))+geom_line()+
            xlab("age in years") + 
            ylab("Hypertension Probability in Males")
          
        }
        else if(gender() == "Female"){
          ggplot(data_hypertension_female, aes(x=age,y=female_hypertension_probability))+geom_line()+
            xlab("age in years") + 
            ylab("Hypertension Probability in Females")
          
        }
        else if(gender() == "Both"){
          ggplot()+
            geom_line(data = data_hypertension_male, aes(x=age,y=male_hypertension_probability),col="blue")+
            geom_line(data = data_hypertension_female, aes(x=age,y=female_hypertension_probability),col="red")+
            xlab("age in years") + 
            ylab("Hypertension Probability")
        }
      }
    
    
      else if(visualise() == "Obesity and Age"){
        
        if(gender() == "All"){
          ggplot(data_obesity_all, aes(x=age,y=obesity_probability))+geom_line()+
            xlab("age in years") + 
            ylab("Obesity Probability")
        }
        else if(gender() == "Male"){
          ggplot(data_obesity_male, aes(x=age,y=male_obesity_probability))+geom_line()+
            xlab("age in years") + 
            ylab("Obesity Probability in Males")
        }
        else if(gender() == "Female"){
          ggplot(data_obesity_female, aes(x=age,y=female_obesity_probability))+geom_line()+
            xlab("age in years") + 
            ylab("Obesity Probability in females")
          
        }
        else if(gender() == "Both"){
          ggplot()+
            geom_line(data = data_obesity_male, aes(x=age,y=male_obesity_probability),col="blue")+
            geom_line(data = data_obesity_female, aes(x=age,y=female_obesity_probability),col="red")+
            xlab("age in years") + 
            ylab("Obesity Probability")
        }
      }
    })
    
    output$table <- renderDataTable({
      if(visualise() == "Hypertension and Age"){
        data_hypertension}
      else if(visualise() == "Obesity and Age"){
        data_obesity}
    })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
