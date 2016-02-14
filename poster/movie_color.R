library(ggplot2)
movie <- c('Bridge of Spies', 'Mad Max', 'Room','The Revenant','Brooklyn','Spotlight',
           'The Big Short','The Martian')
cols <- c('#CC0000', '#FFCC33','#3399FF','#999999','#336699','#FF9933','#9933FF','#CC6600') 
a <- rep(1,8)
movie_color <- data.frame(cbind(movie,cols,a))
levels(movie_color$movie) <- movie

(ggplot(movie_color,aes(movie))
+ geom_bar(fill = cols))
