setwd('/Users/riverzhu/twitter-oscars')
countdata=read.csv('bestPictureTweetCounts.csv',header=T,col.names=c('number','name'))
countdata
library(ggplot2)
movie <- c('Bridge of Spies', 'Mad Max: Fury Road', 'Room','The Revenant','Brooklyn','Spotlight',
           'The Big Short','The Martian')
cols <- c('#CC0000', '#FFCC33','#3399FF','#999999','#336699','#FF9933','#9933FF','#CC6600') 
movie_color <- data.frame(cbind(movie,cols))
target <- c('Bridge of Spies', 'Mad Max: Fury Road', 'Room','The Revenant','Brooklyn','Spotlight',
            'The Big Short','The Martian')
countdata=countdata[match(target, countdata$name),]

exampleColorPlot <- function () {
  ggplot(data=countdata,aes(x=countdata$name,y=countdata$number)) + geom_bar(fill = cols,stat="identity")+
    theme(axis.text.x = element_text(angle = 90, hjust = 1))+
    labs(y='number of total tweets 1/29-2/1',title='number of total tweets for each movie')+
    geom_text(aes(label=countdata$number), vjust=1.5, colour="black",
              position=position_dodge(.9), size=3)
}
exampleColorPlot()
ggsave('number_of_total_tweets.png', plot = last_plot())



