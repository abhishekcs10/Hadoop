#! /usr/bin/env Rscript
# mapper.R - Wordcount program in R
# script for Mapper (R-Hadoop integration)

trimWhiteSpace <- function(line) gsub("(^ +)|( +$)", "", line)
splitIntoWords <- function(line) unlist(strsplit(line, ","))
#data<-data.frame()
#Artist<-c()
#Title<-c()
#Song_id<-c()
#Tags<-c()
con <- file("stdin", open = "r")
while (length(line <- readLines(con, n = 1, warn = FALSE)) > 0) {
  line <- trimWhiteSpace(line)
  words <- splitIntoWords(line)
  ## **** can be done as cat(paste(words, "\t1\n", sep=""), sep="")
 # Artist<-c(Artist,w[1])
  #Tags<-c(Tags,w[2])
  #Title<-c(Title,w[3])
  #Song_id<-c(Song_id,w[4])
    for (w in words)
    {
    cat(w, "\t", sep="")
    }
  cat("\n")
}

close(con)


