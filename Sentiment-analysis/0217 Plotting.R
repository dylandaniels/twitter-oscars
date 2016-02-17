### Import data
bigshort <- as.vector(read.table('thebigshort.csv',sep=',',col.names='sentiment'))
revenant <- as.vector(read.csv('revenant.csv',sep=',',col.names='sentiment'))
room <- as.vector(read.csv('room.csv',sep=',',col.names='sentiment'))
spotlight <- as.vector(read.csv('spotlight.csv',sep=',',col.names='sentiment'))
madmax <- as.vector(read.table('madmax.csv',sep=',',col.names='sentiment'))
martian <- as.vector(read.csv('martian.csv',sep=',',col.names='sentiment'))
bridgeofspies <- as.vector(read.csv('bridgeofspies.csv',sep=',',col.names='sentiment'))
brooklyn <- as.vector(read.csv('brooklyn.csv',sep=',',col.names='sentiment'))

bigshort2 <- cbind(movie="Big Short",bigshort)
revenant2 <- cbind(movie="Revenant",revenant)
room2 <- cbind(movie="Room",room)
spotlight2 <- cbind(movie="Spotlight",spotlight)
madmax2 <- cbind(movie="Mad Max",madmax)
martian2 <- cbind(movie="Martian",martian)
bridgeofspies2 <- cbind(movie="Bridge of Spies",bridgeofspies)
brooklyn2 <- cbind(movie="Brookyln",brooklyn)
movie.data2 <- rbind(madmax2,bridgeofspies2,revenant2,room2,martian2,bigshort2,brooklyn2,spotlight2)

#movie <- c('Bridge of Spies','The Mad Max','The Revenant','The Big Short',
#           'The Martian','Room','Brooklyn','Spotlight')
#sentiment <- c(mean(bridgeofspies$sentiment),mean(madmax$sentiment),
#               mean(revenant$sentiment),mean(bigshort$sentiment),
#               mean(martian$sentiment),mean(room$sentiment),
#               mean(brooklyn$sentiment),mean(spotlight$sentiment))
#movie.data <- data.frame(movie,sentiment)

### Plot 1 
par(mfrow=c(1,1))
library(ggplot2)
library(plyr)
library(reshape2)
summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=FALSE,
                      conf.interval=.95, .drop=TRUE) {
  library(plyr)
  
  # New version of length which can handle NA's: if na.rm==T, don't count them
  length2 <- function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }
  
  # This does the summary. For each group's data frame, return a vector with
  # N, mean, and sd
  datac <- ddply(data, groupvars, .drop=.drop,
                 .fun = function(xx, col) {
                   c(N    = length2(xx[[col]], na.rm=na.rm),
                     mean = mean   (xx[[col]], na.rm=na.rm),
                     sd   = sd     (xx[[col]], na.rm=na.rm)
                   )
                 },
                 measurevar
  )
  
  # Rename the "mean" column    
  datac <- rename(datac, c("mean" = measurevar))
  
  datac$se <- datac$sd / sqrt(datac$N)  # Calculate standard error of the mean
  
  # Confidence interval multiplier for standard error
  # Calculate t-statistic for confidence interval: 
  # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  
  return(datac)
}
tgc <- summarySE(movie.data2, measurevar="sentiment", groupvars="movie")
tgc
pd <- position_dodge(0.1) 

cols <- c('#FFCC33', '#CC0000','#999999','#3399FF','#CC6600','#9933FF','#336699','#FF9933') 
tgc <- cbind(tgc,cols)

p=ggplot(tgc, aes(x=movie, y=sentiment)) + 
  geom_errorbar(aes(ymin=sentiment-ci, ymax=sentiment+ci), colour="black", width=.3, size=1.5, position=pd) +
  geom_point(position=pd, size=7, colour=cols, fill=cols) +
  ggtitle("Mean and 95% Confidence Interval for Tweet Sentiment per Movie") +
  labs(y="Sentiment score of tweets") +
  labs(x="Movie name") +
  theme(plot.title = element_text(face="bold", size=25)) +
  theme(axis.title = element_text(size=20,face="bold"),
        axis.text.x = element_text(colour="black",size=15),
        axis.text.y = element_text(colour="black",size=15))+
  theme(legend.position='none') +
  ylim(0,0.3)
p

# write a simple function to add footnote
makeFootnote <- function(footnoteText =
                           format(Sys.time(), "%d %b %Y"),
                         size = .7, color = grey(.5))
{
  require(grid)
  pushViewport(viewport())
  grid.text(label = footnoteText ,
            x = unit(1,"npc") - unit(2, "mm"),
            y = unit(2, "mm"),
            just = c("right", "bottom"),
            gp = gpar(cex = size, col = color))
  popViewport()
}
png("sentiment1.png", width = 641, height = 343)
print(p)
# call makeFootnote function to add footnote
makeFootnote("Footnote", color = "black")
dev.off()

library(gridExtra)
g <- arrangeGrob(p, 
                 sub = textGrob("Footnote: We measured the sentiment of tweets with the python package, TextBlob. Sentiment scores are on a scale of -1 to 1.", 
                                x = 0, hjust = -0.1, vjust=0.1, gp = gpar(fontface = "italic", fontsize = 15)))
ggsave("sentiment_plot1.png", g)



### plot 2
movie.data3 <- as.vector(read.table('sentiment.csv',sep=',',
                                    col.names=c("movie","Sentiment","score")))
p=ggplot(movie.data3, aes(factor(movie), y=score, fill=Sentiment)) +
  geom_bar(stat="identity") +
  scale_fill_hue(l=40) + 
  ggtitle("Percentage of Positive, Neutral, Negative Tweets per Movie") +
  labs(y="Percentage of tweets (%)") +
  labs(x="Movie name") +
  theme(plot.title = element_text(face="bold", size=25)) +
  theme(axis.title = element_text(face="bold", size=20),
        axis.text.x = element_text(colour="black", size=15),
        axis.text.y = element_text(colour="black", size=15)) +
  theme(legend.title=element_text(size=16))+
  theme(legend.text=element_text(size=15))+
  scale_x_discrete(labels=c("Mad Max","Revenant","Bridge of Spies","Room",
                            "Martian","Brooklyn","Big Short","Spotlight"))

# write a simple function to add footnote
makeFootnote <- function(footnoteText =
                           format(Sys.time(), "%d %b %Y"),
                         size = .7, color = grey(.5))
{
  require(grid)
  pushViewport(viewport())
  grid.text(label = footnoteText ,
            x = unit(1,"npc") - unit(2, "mm"),
            y = unit(2, "mm"),
            just = c("right", "bottom"),
            gp = gpar(cex = size, col = color))
  popViewport()
}
png("sentiment3.png", width = 641, height = 343)
print(p)
# call makeFootnote function to add footnote
makeFootnote("Footnote", color = "black")
dev.off()

library(gridExtra)
g <- arrangeGrob(p, 
    sub = textGrob("Footnote: We measured the sentiment of tweets with the python package, TextBlob. Sentiment scores are on a scale of -1 to 1.", 
                                x = 0, hjust = -0.1, vjust=0.1, gp = gpar(fontface = "italic", fontsize = 15)))
ggsave("sentiment_plot2.png", g)





#######################################################################################################
word <- read.csv('word.csv',sep=',')
rev <- word[word$Movie=="Revenant",]
spo <- word[word$Movie=="Spotlight",]
revpos <- rev[rev$Sentiment=="Positive",]
revneg <- rev[rev$Sentiment=="Negative",]
spopos <- spo[spo$Sentiment=="Positive",]
sponeg <- spo[spo$Sentiment=="Negative",]

## Revenant positive
revpos1=revpos[1:10,]
 ### Count
revpos1 <- transform(revpos1,
                     Word = reorder(Word, order(Count, decreasing = TRUE)))
revposplot <- ggplot(revpos1, aes(x=Word, y=Count)) + 
  geom_bar(stat="identity", fill="#999999", colour="#999999") +
  ggtitle("The Top 10 Frequent Words of the Positive Tweets of the Revenant") +
  labs(y="Word count") +
  labs(x="Words") +
  theme(plot.title = element_text(face="bold", size=25)) +
  theme(axis.title = element_text(face="bold", size=20),
        axis.text.x = element_text(colour="black", size=15),
        axis.text.y = element_text(colour="black", size=15)) +
  theme(legend.title=element_text(size=16))+
  theme(legend.text=element_text(size=15)) +
  theme(legend.position="none") +
  ylim(0,1600)
ggsave("revpos_count.png", revposplot)

 ### Proportion
revpos1 <- transform(revpos1,
                     Word = reorder(Word, order(Prop2, decreasing = TRUE)))
revposplot <- ggplot(revpos1, aes(x=Word, y=Prop2)) + 
  geom_bar(stat="identity", fill="#999999", colour="#999999") +
  ggtitle("The Top 10 Frequent Words of the Positive Tweets of the Revenant") +
  labs(y="Word proportion (Frequency/#Positive tweets)") +
  labs(x="Words") +
  theme(plot.title = element_text(face="bold", size=25)) +
  theme(axis.title = element_text(face="bold", size=20),
        axis.text.x = element_text(colour="black", size=15),
        axis.text.y = element_text(colour="black", size=15)) +
  theme(legend.title=element_text(size=16))+
  theme(legend.text=element_text(size=15)) +
  theme(legend.position="none")+
  ylim(0,0.5)
ggsave("revpos_prop.png", revposplot)

## Spotlight positive
spopos1=spopos[1:10,]
### Count
spopos1 <- transform(spopos1,
                     Word = reorder(Word, order(Count, decreasing = TRUE)))
spoposplot <- ggplot(spopos1, aes(x=Word, y=Count)) + 
  geom_bar(stat="identity", fill="#FF9933", colour="#FF9933") +
  ggtitle("The Top 10 Frequent Words of the Positive Tweets of the Spotlight") +
  labs(y="Word count") +
  labs(x="Words") +
  theme(plot.title = element_text(face="bold", size=25)) +
  theme(axis.title = element_text(face="bold", size=20),
        axis.text.x = element_text(colour="black", size=15),
        axis.text.y = element_text(colour="black", size=15)) +
  theme(legend.title=element_text(size=16))+
  theme(legend.text=element_text(size=15)) +
  theme(legend.position="none")+
  ylim(0,1600)
ggsave("spopos_count.png", spoposplot)

### Proportion
spopos1 <- transform(spopos1,
                     Word = reorder(Word, order(Prop2, decreasing = TRUE)))
spoposplot <- ggplot(spopos1, aes(x=Word, y=Prop2)) + 
  geom_bar(stat="identity", fill="#FF9933", colour="#FF9933") +
  ggtitle("The Top 10 Frequent Words of the Positive Tweets of the Spotlight") +
  labs(y="Word proportion (Frequency/#Positive tweets)") +
  labs(x="Words") +
  theme(plot.title = element_text(face="bold", size=25)) +
  theme(axis.title = element_text(face="bold", size=20),
        axis.text.x = element_text(colour="black", size=15),
        axis.text.y = element_text(colour="black", size=15)) +
  theme(legend.title=element_text(size=16))+
  theme(legend.text=element_text(size=15)) +
  theme(legend.position="none")+
  ylim(0,0.5)
ggsave("spopos_prop.png", spoposplot)

## Revenant negative
revneg1=revneg[1:10,]
### Count
revneg1 <- transform(revneg1,
                     Word = reorder(Word, order(Count, decreasing = TRUE)))
revnegplot <- ggplot(revneg1, aes(x=Word, y=Count)) + 
  geom_bar(stat="identity", fill="#999999", colour="#999999") +
  ggtitle("The Top 10 Frequent Words of the Negative Tweets of the Revenant") +
  labs(y="Word count") +
  labs(x="Words") +
  theme(plot.title = element_text(face="bold", size=25)) +
  theme(axis.title = element_text(face="bold", size=20),
        axis.text.x = element_text(colour="black", size=15),
        axis.text.y = element_text(colour="black", size=15)) +
  theme(legend.title=element_text(size=16))+
  theme(legend.text=element_text(size=15)) +
  theme(legend.position="none")+
  ylim(0,60)
ggsave("revneg_count.png", revnegplot)

### Proportion
revneg1 <- transform(revneg1,
                     Word = reorder(Word, order(Prop2, decreasing = TRUE)))
revnegplot <- ggplot(revneg1, aes(x=Word, y=Prop2)) + 
  geom_bar(stat="identity", fill="#999999", colour="#999999") +
  ggtitle("The Top 10 Frequent Words of the Negative Tweets of the Revenant") +
  labs(y="Word proportion (Frequency/#Negative tweets)") +
  labs(x="Words") +
  theme(plot.title = element_text(face="bold", size=25)) +
  theme(axis.title = element_text(face="bold", size=20),
        axis.text.x = element_text(colour="black", size=15),
        axis.text.y = element_text(colour="black", size=15)) +
  theme(legend.title=element_text(size=16))+
  theme(legend.text=element_text(size=15)) +
  theme(legend.position="none")+
  ylim(0,0.3)
ggsave("revneg_prop.png", revnegplot)

## Spotlight negative
sponeg1=sponeg[1:10,]
### Count
sponeg1 <- transform(sponeg1,
                     Word = reorder(Word, order(Count, decreasing = TRUE)))
sponegplot <-ggplot(sponeg1, aes(x=Word, y=Count)) + 
  geom_bar(stat="identity", fill="#FF9933", colour="#FF9933") +
  ggtitle("The Top 10 Frequent Words of the Negative Tweets of the Spotlight") +
  labs(y="Word count") +
  labs(x="Words") +
  theme(plot.title = element_text(face="bold", size=25)) +
  theme(axis.title = element_text(face="bold", size=20),
        axis.text.x = element_text(colour="black", size=15),
        axis.text.y = element_text(colour="black", size=15)) +
  theme(legend.title=element_text(size=16))+
  theme(legend.text=element_text(size=15)) +
  theme(legend.position="none")+
  ylim(0,60)
ggsave("sponeg_count.png", sponegplot)

### Proportion
sponeg1 <- transform(sponeg1,
                     Word = reorder(Word, order(Prop2, decreasing = TRUE)))
sponegplot <- ggplot(sponeg1, aes(x=Word, y=Prop2)) + 
  geom_bar(stat="identity", fill="#FF9933", colour="#FF9933") +
  ggtitle("The Top 10 Frequent Words of the Negative Tweets of the Spotlight") +
  labs(y="Word proportion (Frequency/#Negative tweets)") +
  labs(x="Words") +
  theme(plot.title = element_text(face="bold", size=25)) +
  theme(axis.title = element_text(face="bold", size=20),
        axis.text.x = element_text(colour="black", size=15),
        axis.text.y = element_text(colour="black", size=15)) +
  theme(legend.title=element_text(size=16))+
  theme(legend.text=element_text(size=15)) +
  theme(legend.position="none")+
  ylim(0,0.3)
ggsave("sponeg_prop.png", sponegplot)