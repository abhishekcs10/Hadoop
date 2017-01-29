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
  artist <- split$artist
  title_id <- split$title_id
  #song_id<-split$song_id
  if (exists(artist, envir = env, inherits = FALSE)) {
    vec <- get(artist, envir = env) #checks if the word exists in current environment
    assign(artist,c(vec,title_id) , envir = env)  #assign 
  }
  else assign(artist, c(title_id), envir = env) #if does not exist
}
close(con)
for (w in ls(env, all = TRUE)){#ls list all 
  d<-get(w,envir=env)
cat(w,"\t",sep="");
    for (j in 1:length(d)){
    cat(d[j],"; ", sep = "")
  }
  cat("\n",sep="")
}

ARTIST_NAME="The Chicharones"
cat("\n\n")
if(exists(ARTIST_NAME, envir = env, inherits = FALSE)){
  vec <- get(ARTIST_NAME, envir = env)
  cat(vec,"\n",sep="")
}



