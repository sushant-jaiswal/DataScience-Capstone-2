
library(stringr)

bigrams <- readRDS("bigrams_all.rds")
trigrams <- readRDS("trigrams_all.rds")

selectwords <- function(phrase) {
    phrase <- unlist(strsplit(phrase, "\\s+"))
    
    if (length(phrase) >= 2) {
        phrase <- phrase[(length(phrase) - 1) : length(phrase)]
    }
    else {
        phrase <- phrase
    }
}

predict <- function(phrase, noOfWords = 1) {
    phrase <- selectwords(phrase)
    suggetion <- head(grep(paste("^\\<", phrase[1], "\\>", sep = ""), bigrams$ngram), noOfWords)
    suggetion <- bigrams$ngram[suggetion]
    suggetion <- gsub(phrase, "", suggetion)
    suggetion <- unlist(strsplit(suggetion, "\\s+"))
    return(suggetion)
}
