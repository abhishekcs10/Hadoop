#! /usr/bin/env Rscript

# reducer.R - Wordcount program in R
# script for Reducer (R-Hadoop integration)

trimWhiteSpace <- function(line) gsub("(^ +)|( +$)", "", line)

splitLine <- function(line) {
  val <- unlist(strsplit(line, "\t"))     #1 Artist 2 Tag 3 Title 4 Songid
  list(artist = val[1], title_id = val[2])
}

env <- new.env(hash = TRUE)
#num_song<-readline(prompt ="Enter NUM_SONG")
con <- file("stdin", open = "r")
while (length(line <- readLines(con, n = 1, warn = FALSE)) > 0) {
  line <- trimWhiteSpace(line)
  split <- splitLine(line)
  artist <- unlist(split$artist)
  title_id <-unlist(split$title_id)
  #song_id<-split$song_id
if(nchar(artist)<1 | nchar(title_id)<1)
{	next
}
  if (exists(artist, envir = env, inherits = FALSE)) {
    vec <- get(artist, envir = env) #checks if the word exists in current environment
    assign(artist,c(vec,title_id) , envir = env)  #assign 
  }
  else assign(artist, c(title_id), envir = env) #if does not exist
}
close(con)

for (w in ls(env, all = TRUE)){#ls list all 
 d<-get(w,envir=env)
 if(length(d)>1)
   {	for (j in 1:length(d)){
	cat(w, "\t",d[j],"\n", sep = "")
 }
}
}
