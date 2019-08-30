
library(NLP)
library(tm)
library(ggplot2)
library(RWeka)
library(RColorBrewer)
library(gridExtra)

setwd("C:/Data/MyLearn/DataScienceCoursera/Files/ProgrammingAssignment16/predictNextWords")
swiftKeyZipURL <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"

# set the download file name
swiftKeyZipFile <- "Coursera-SwiftKey.zip"

# if file does not exists, download and unzip it
if (!file.exists(swiftKeyZipFile)) {
    download.file(swiftKeyZipURL, swiftKeyZipFile)
    unzip (swiftKeyZipFile)
}

# show files
filePath <- file.path(getwd(), "final", "en_US")
list.files(filePath)

# load the data
blogsFile <- file.path(filePath, "en_US.blogs.txt")
blogs <- readLines(blogsFile,encoding="UTF-8")

newsFile <- file.path(filePath, "en_US.news.txt")
news <- readLines(newsFile,encoding="UTF-8")

twitterFile <- file.path(filePath, "en_US.twitter.txt")
twitter <- readLines(twitterFile, encoding = "Latin1")

# getting bad words data
badWordsURL <- "https://raw.githubusercontent.com/LDNOOBW/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words/master/en"
badWordsFile <- "badwords.txt"

# if not exists, download it
if (!file.exists(badWordsFile)) {
    download.file(badWordsURL, badWordsFile)
}

# load bad words
badwords <- readLines(badWordsFile,encoding="latin1")

SampleAndCleanCopora <- function(sample_corpus) {
    sample_corpus <- sample(sample_corpus, 1000)
    sample_corpus <- VCorpus(VectorSource(sample_corpus))
    sample_corpus <- tm_map(sample_corpus, removeNumbers)
    sample_corpus <- tm_map(sample_corpus, removeWords, stopwords("english"))
    sample_corpus <- tm_map(sample_corpus, removeWords, badwords)
    sample_corpus <- tm_map(sample_corpus, stripWhitespace)
    sample_corpus <- tm_map(sample_corpus, content_transformer(tolower))
}

# create samples
blogs_sample <- SampleAndCleanCopora(blogs)
news_sample <- SampleAndCleanCopora(news)
twitter_sample <- SampleAndCleanCopora(twitter)

# define Bi and Tri tokens
BiToken <- function (x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
TriToken <- function (x) NGramTokenizer(x, Weka_control(min = 3, max = 3))

# functions for bigrams and trigrams
bigrams <- function(x) {
    tdm <- TermDocumentMatrix(x, control = list(tokenize = BiToken))
    fm <- rowSums(as.matrix(tdm))
    ngram <- data.frame(ngram=names(fm),freq=fm)
    ngram <- ngram[order(-ngram$freq),]
}

trigrams <- function(x) {
    tdm <- TermDocumentMatrix(x, control = list(tokenize = TriToken))
    fm <- rowSums(as.matrix(tdm))
    ngram <- data.frame(ngram=names(fm),freq=fm)
    ngram <- ngram[order(-ngram$freq),]
}

# ngrams applied on the samples
blogs_bi <- bigrams(blogs_sample)
blogs_tri <- trigrams(blogs_sample)

news_bi <- bigrams(news_sample)
news_tri <- trigrams(news_sample)

twitter_bi <- bigrams(twitter_sample)
twitter_tri <- trigrams(twitter_sample)

# Saving to RDS
blogs_bi$ngram<-as.character(blogs_bi$ngram)
blogs_tri$ngram<-as.character(blogs_tri$ngram)

news_bi$ngram<-as.character(news_bi$ngram)
news_tri$ngram<-as.character(news_tri$ngram)

twitter_bi$ngram <- as.character(twitter_bi$ngram)
twitter_tri$ngram <- as.character(twitter_tri$ngram)

mergegrams <- function (x,y,z)
{
    x1 <- merge.data.frame(x, y, all = TRUE)
    x2 <- merge.data.frame(x1, z, all = TRUE)
    x3 <- aggregate(freq~ngram, data = x2, sum)
    x3 <- x3[order(-x3$freq),]
}

bigrams_all <- mergegrams(blogs_bi, news_bi, twitter_bi)
saveRDS (bigrams_all, "bigrams_all.rds")

trigrams_all <- mergegrams(blogs_tri, news_tri, twitter_tri)
saveRDS (trigrams_all, "trigrams_all.rds")

