#! /usr/bin/env Rscript
# mapper.R - Wordcount program in R
# script for Mapper (R-Hadoop integration)

trimWhiteSpace <- function(line) gsub("(^ +)|( +$)", "", line)
splitIntoWords <- function(line) unlist(strsplit(line, ","))
splitLine <- function(line) {
  val <- unlist(strsplit(line, ","))     #1 Artist 2 Tag 3 Title 4 Songid
  list(artist = val[1], tags=val[2],title = val[3], song_id=val[4])
}

#data<-data.frame()
#Artist<-c()
#Title<-c()
#Song_id<-c()
#Tags<-c()
NUM_TAG=23
con <- file("stdin", open = "r")
while (length(line <- readLines(con, n = 1, warn = FALSE)) > 0) {
  line <- trimWhiteSpace(line)
  split <- splitLine(line)
  artist2 <- split$artist
  artist<-unlist(strsplit(artist2,";"))
  tags<-length(unlist(strsplit(split$tags,";")))
  if(tags<= NUM_TAG){
    next
  }
  title <- split$title
  song_id<-split$song_id
  for (a in artist){
    cat(a, "\t",title," ",song_id,"\t", sep="")
  }
  cat("\n")
}

close(con)


