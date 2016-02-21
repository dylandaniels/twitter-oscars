library(ggplot2)
# NOTE: add last year's winner as horizontal line

setwd('~/stat222/twitter')
tweetCounts <- read.csv('bestPictureTweetCounts.csv', header=FALSE)
names(tweetCounts) <- c('count', 'Name')

movie_colors <- c('#CC0000', '#336699', '#FFCC33', '#3399FF', '#FF9933',  '#9933FF', '#CC6600', '#999999') 

# Downloaded 2/13/2016
boxOffice <- c(72086318, 33186253, 153636354, 
               11551978, 36653245, 64616837, 
               228167401, 153564599)

rottenTomatoes <- c(0.91, 0.98, 0.97,
                    0.96, 0.96, 0.88,
                    0.91, 0.83)

metacritic <- c(0.81, 0.87, 0.89,
                0.86, 0.93, 0.81,
                0.80, 0.76)

awardsWon <- c(19, 23, 130, 63, 89, 23, 26, 49)
nominations <- c(73, 124, 150, 117, 117, 72, 135, 134)
awardRatio <- awardsWon / nominations

freqCounts <- cbind(tweetCounts, boxOffice, rottenTomatoes, metacritic, awardRatio, movie_colors)

sentiment <- read.csv('sentiment_analysis.csv')

movieData <- cbind(sentiment[order(sentiment$Movies),], freqCounts[order(freqCounts$Name),])
movieData[,1] <- NULL 


scatterPlot <- function (data, xVar, yVar, label, title, xlab, ylab) {
  ggplot(data=data, mapping=aes_string(x=xVar, y=yVar, label=label, color=label)) + 
    geom_point(size=8, color=movie_colors) + 
    ggtitle(title) +
    labs(x=xlab, y=ylab) +
    theme(legend.position='none') +# removes legend
    theme(axis.text=element_text(size=12),
          axis.title=element_text(size=20,face="bold"),
          title=element_text(size=20, face='bold'))
}

defaultTextLabelSize <- 6

plotBoxOfficeVsTweets <- function () {
  p <- scatterPlot(movieData, 'count', 'boxOffice', 'Name',
                  'Box Office Earnings vs. Number of Tweets',
                  'Number of tweets (1/29/16 - 2/1/16)', 
                  'Total box office earnings (as of 2/13/16)')
  p <- p + scale_y_continuous(label=function(x){return(paste0("$", x / 1e6, 'M'))})
  p + geom_text(vjust=-1, hjust="inward", check_overlap=TRUE, color='black',
                size = defaultTextLabelSize)
}

plotRottenTomatoesVsTweets <- function () {
  p <- scatterPlot(movieData, 'count', 'rottenTomatoes', 'Name',
                  'Rotten Tomatoes Score vs. Number of Tweets',
                  'Number of tweets (1/29/16 - 2/1/16)', 
                  'Rotten Tomatoes Tomatometer Score')
  p <- p + geom_text(vjust=-1, hjust="inward", check_overlap=TRUE, color='black', 
                     size=defaultTextLabelSize)
  p <- p + geom_text(data=freqCounts[freqCounts$Name=='Spotlight',], nudge_y=-0.003, nudge_x=1500,
                     color='black', size=defaultTextLabelSize)
  return(p)
}

plotMetacriticVsTweets <- function () {
  p <- scatterPlot(movieData, 'count', 'metacritic', 'Name',
                   'Metacritic Score vs. Number of Tweets',
                   'Number of tweets (1/29/16 - 2/1/16)', 
                   'Metacritic Score')
  p + geom_text(vjust=-0.7, hjust="inward", check_overlap=TRUE, color='black',
                size = defaultTextLabelSize)
}

plotSentimentVsTweets <- function () {
  p <- scatterPlot(movieData, 'count', 'Sentiment', 'Name',
                   'Sentiment Score vs. Number of Tweets',
                   'Number of tweets (1/29/16 - 2/1/16)', 
                   'Sentiment Score')
  p + geom_text(vjust=-0.7, hjust="inward", check_overlap=TRUE, color='black',
                size = defaultTextLabelSize)
}

plotSentimentVsBoxOffice <- function () {
  p <- scatterPlot(movieData, 'Sentiment', 'boxOffice', 'Name',
                   'Box Office Earnings vs. Sentiment Score',
                   'Sentiment Score', 
                   'Total box office earnings (as of 2/13/16)')
  p <- p + scale_y_continuous(label=function(x){return(paste0("$", x / 1e6, 'M'))})
  p + geom_text(color='black', size = defaultTextLabelSize, hjust='inward')
}

plotSentimentVsRottenTomatoes <- function () {
  p <- scatterPlot(movieData, 'Sentiment', 'rottenTomatoes', 'Name',
                   'Rotten Tomatoes Score vs. Sentiment Score',
                   'Sentiment Score', 
                   'Rotten Tomatoes Tomatometer Score')
  p + geom_text(color='black', size = defaultTextLabelSize, hjust='inward')
}

plotRottenTomatoesVsBoxOffice <- function () {
  p <- scatterPlot(movieData, 'rottenTomatoes', 'boxOffice', 'Name',
                   'Box Office Earnings vs. Rotten Tomatoes Score',
                   'Rotten Tomatoes Tomtometer Score', 
                   'Total box office earnings (as of 2/13/16)')
  p <- p + scale_y_continuous(label=function(x){return(paste0("$", x / 1e6, 'M'))})
  p + geom_text(color='black', size = defaultTextLabelSize, hjust='inward')
}

savePlot <- function (plotName, plotFun, width, height) {
  setwd('~/stat222/twitter/poster/scatterplots')
  ggsave(filename=paste0(plotName, '.png'), plot=plotFun(), width=width, height=height)
}

saveAllPlots <- function () {
  defaultWidthInches <- 12
  defaultHeightInches <-8 
  savePlot('boxOfficeVsTweets', plotBoxOfficeVsTweets, defaultWidthInches, defaultHeightInches)
  savePlot('rtVsBoxOffice', plotRottenTomatoesVsBoxOffice, defaultWidthInches, defaultHeightInches)
  savePlot('rtVsTweets', plotRottenTomatoesVsTweets, defaultWidthInches, defaultHeightInches)
  savePlot('sentimentVsRt', plotSentimentVsRottenTomatoes, defaultWidthInches, defaultHeightInches)
  savePlot('sentimentVsBoxOffice', plotSentimentVsBoxOffice, defaultWidthInches, defaultHeightInches)
  savePlot('sentimentVsTweets', plotSentimentVsTweets, defaultWidthInches, defaultHeightInches)
}


#plotBoxOfficeVsTweets()
