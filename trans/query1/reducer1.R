#! /usr/bin/env Rscript

# reducer.R - Wordcount program in R
# script for Reducer (R-Hadoop integration)

trimWhiteSpace <- function(line) gsub("(^ +)|( +$)", "", line)

splitLine <- function(line) {
  val <- unlist(strsplit(line, "\t"))
  list(tag = val[2], title = val[3], song_id=val[4])
}

env <- new.env(hash = TRUE)
#num_tag<-readline(promp="Enter NUM_TAG")
con <- file("stdin", open = "r")

while (length(line <- readLines(con, n = 1, warn = FALSE)) > 0) {
  line <- trimWhiteSpace(line)
  split <- splitLine(line)
  tag2 <- split$tag
  tag<- unlist(strsplit(tag2,";"))
  title <- split$title
  song_id<-split$song_id
  if (length(tag)>2) {
    cat(title,"\t",song_id,"\n", sep="");
  }
  #else assign(word, count, envir = env) #if does not exist
}
close(con)
