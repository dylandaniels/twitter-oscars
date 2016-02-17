library(ggplot2)
movie <- c('Bridge of Spies', 'Mad Max: Fury Road', 'Room','The Revenant','Brooklyn','Spotlight',
           'The Big Short','The Martian')

cols <- c('#CC0000', '#FFCC33','#3399FF','#999999','#336699','#FF9933','#9933FF','#CC6600') 
movie_color <- data.frame(cbind(movie,movie_colors))
levels(movie_color$movie) <- movie

exampleColorPlot <- function () {
  ggplot(movie_color,aes(movie)) + geom_bar(fill = cols)
}
