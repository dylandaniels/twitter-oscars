library(ggplot2)

# NOTE: add last year's winner as horizontal line

setwd('~/stat222/twitter')
tweetCounts <- read.csv('bestPictureTweetCounts.csv', header=FALSE)
names(tweetCounts) <- c('count', 'Name')

boxOffice <- c(71884220, 30599697, 153636354, 
               9901663, 34884206, 61191200, 
               227954994, 139512249)

rottenTomatoes <- c(0.91, 0.98, 0.97,
                    0.96, 0.96, 0.88,
                    0.91, 0.83)

metacritic <- c(0.81, 0.87, 0.89,
                0.86, 0.93, 0.81,
                0.80, 0.76)

freqCounts <- cbind(tweetCounts, boxOffice, rottenTomatoes, metacritic)

sentiment <- read.csv('sentiment_analysis.csv')

scatterPlot <- function (data, xVar, yVar, label, title, xlab, ylab) {
  ggplot(data=data, mapping=aes_string(x=xVar, y=yVar, label=label, color=label)) + 
    geom_point(size=3) + 
    ggtitle(title) +
    labs(x=xlab, y=ylab) +
    theme(legend.position='none') +# removes legend
    theme(axis.text=element_text(size=12),
          axis.title=element_text(size=14,face="bold"),
          title=element_text(size=14, face='bold'))
}

defaultTextLabelSize <- 4

plotBoxOfficeVsTweets <- function () {
  p <- scatterPlot(freqCounts, 'count', 'boxOffice', 'Name',
                  'Box Office Earnings vs. Number of Tweets',
                  'Number of tweets (1/29/16 - 2/1/16)', 
                  'Total box office earnings (as of 2/5/16)')
  p <- p + scale_y_continuous(label=function(x){return(paste0("$", x / 1e6, 'M'))})
  p + geom_text(vjust=-1, hjust="inward", check_overlap=TRUE, color='black',
                size = defaultTextLabelSize)
}

plotRottenTomatoesVsTweets <- function () {
  p <- scatterPlot(freqCounts, 'count', 'rottenTomatoes', 'Name',
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
  p <- scatterPlot(freqCounts, 'count', 'metacritic', 'Name',
                   'Metacritic Score vs. Number of Tweets',
                   'Number of tweets (1/29/16 - 2/1/16)', 
                   'Metacritic Score')
  p + geom_text(vjust=-0.7, hjust="inward", check_overlap=TRUE, color='black',
                size = defaultTextLabelSize)
}

plotSentimentVsTweets <- function () {
  df <- cbind(sentiment[order(sentiment$Movies),], freqCounts[order(freqCounts$Name),])
  p <- scatterPlot(df, 'count', 'Sentiment', 'Name',
                   'Sentiment Score vs. Number of Tweets',
                   'Number of tweets (1/29/16 - 2/1/16)', 
                   'Sentiment Score')
  p + geom_text(vjust=-0.7, hjust="inward", check_overlap=TRUE, color='black',
                size = defaultTextLabelSize)
}


# p <- ggplot(data=freqCounts, mapping=aes(x=count, y=boxOffice, label=Name)) + 
#   geom_point(size=3) +
#   geom_text(vjust=-1, hjust="inward") +
#   ggtitle('Tweet Mentions vs. Box Office Earnings') +
#   labs(x='Number of tweets (1/29/16 - 2/1/16)', y='Total box office earnings (as of 2/5/16)')
# 
# 
# 
# p + scale_x_continuous(limits=c(0, 25000))
# breaks=c('0', '5e7', '1e8', '1.5e8', '2e8')) 
    # labels=c('$0', '$5', '$1', '$1.5', '$2'))
# 
# ggplot(data=freqCounts, aes(x=count, y=rottenTomatoes)) +
#   geom_point(shape=1)
# 
# ggplot(data=freqCounts, aes(x=count, y=metacritic)) + 
#   geom_point(shape=1)
