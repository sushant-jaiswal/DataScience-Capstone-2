# Overview

As part of our last project, we already have built a predictive model to estimate the next work for provided Blogs, News and Twitter data. The data was provided in 4 different languages, but we analyzed the english language data for wide acceptance.
In this project, we will build a shiny app to provide an interface for users to use the predictive model to find next word suggestion for any given word.

# Generating N-Gram

The data has been downloaded from provided source and loaded from files to R objects. The profanity words have been obtained from online source and put into R object. A function has been written to generate ngram tokens from corpora using the RWeka package. Another function has been written to extract ngram from each dataset. The ngram for each dataset have been merged to have bigrams and trigrams for Blogs, News and Twitter data.

# How the App works

The app takes two inputs:
1. An input phrase in a text box
2. The number of predictions to be suggested in a text box

The input phrase has been run through bigram and trigram to find the next word suggestion.
Based on the input for number of words to be suggested, the app will generate the specified number of predictions for the next most likely words.

# Next Word(s) Prediction App

Try out the shiny app for Next Word(s) Prediction at-
https://sushantjaiswal.shinyapps.io/PredictNextWords/

Enter the phrase in first text box for which next word(s) have to be preidcted. In second text box, enter the number of word suggestions to be predicted for entered phrase.
