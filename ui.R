
library(shiny)

shinyUI(
    navbarPage("Next Word(s) Prediction",
        tabPanel("Predict",
            fluidPage(
                sidebarLayout(
                    sidebarPanel(
                        textInput("phraseBox", "Enter a phrase:"),
                        numericInput("noOfWords", "Enter no. of words to be predicted:", value = 1, min = 1, max = 3),
                        actionButton("predictButton", "Predict"),
                        br(),
                        br(),
                        h5(strong("How to use the App")),
                        h5("Enter the phrase in first text box for which next word(s) have to be preidcted. In second text box, enter the number of word suggestions to be predicted for entered phrase."),
                        h5("The app fetches the last few words of the phrase and runs it through the ngram to generate the most predictable next word.")
                    ),
                    mainPanel(
                        h3("Next Word(s) Prediction App"),
                        br(),
                        br(),
                        h4("Entered phrase:"),
                        verbatimTextOutput("Text1"),
                        h4("Next Word(s):"),
                        verbatimTextOutput("Text2")
                    )
                )
            )
        )
    )
)