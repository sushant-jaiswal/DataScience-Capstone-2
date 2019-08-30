
library(shiny)
library(tm)
library(RWeka)
library(stringr)

shinyServer(
    function(input, output) {
        setwd("C:/Data/MyLearn/DataScienceCoursera/Files/ProgrammingAssignment16/predictNextWords")
        bigrams<-readRDS("bigrams_all.rds")
        trigrams<-readRDS("trigrams_all.rds")
        
        T1 <- eventReactive(input$predictButton, {
            input$phraseBox
        })
        
        T2 <- eventReactive(input$predictButton, {
            phrase <- input$phraseBox
            source("predictor.R")
            nextWord <- predict(phrase,input$noOfWords)
        })
        
        output$Text1 <- renderText({
            T1()
        })
        
        output$Text2 <- renderPrint({
            cat(T2(), sep = "\n")
        })

    }
)