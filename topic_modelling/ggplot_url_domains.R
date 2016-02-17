library("ggplot2")
library("plotflow")
library(rjson)


a=c("artist","reven","galli","pari","lavin")
b=c(23,23,21,20,14)
domains_stat = data.frame(domain = a, frequencies = b)

data3 = fromJSON(file = "all_topic3.json")
data4 = fromJSON(file = "all_topic4.json")


png("actor_wordcloud.png", width=1280,height=800)

draw_wordcloud = function(strname){
  bradpitt = get(strname) 
  bradpitt_freq = as.numeric(bradpitt[seq(1,length(bradpitt),2)])
  bradpitt_domain = bradpitt[seq(2,length(bradpitt),2)]
  
  wordcloud(words = bradpitt_domain, freq = sqrt(bradpitt_freq), min.freq = 1,
            max.words=200, random.order=FALSE, rot.per=.1,
            colors=brewer.pal(8, "GnBu"))
  text(.5,0,strname,font=4,side =3,cex=1.5)
}


#,'stanleytucci','willpoulter'
name_actor = c('BradPitt','LeoDicaprio','TomHanks','TomHardy','ChristianBale','CharlizeTheron','MarkRuffalo',
               'RachelMcadams','StanleyTucci')

par(mfrow=c(3,3))
for (i in name_actor){
  #print(i)
  draw_wordcloud(i)
}

mtext("Topics From Tweets About Different Actors", side = 3, 
      line = -2, outer = TRUE, font = 2)


dev.off()


BradPitt = c(48,'dada',48,'loui',118,'angelina',26,'amor',24,'daniel',24,'harri',24,'casal',24,'amizad',18,'sooyoung',18,'hold',
             18,'mask',84,'joli',28,'8x10',29,'new')

LeoDicaprio = c(95,'oscar',17,'cri',17,'orihuela',111,'kate',111,'winslet',90,'now',6,'titan',15,'dan',16,'reven')

TomHanks = c(56,'star',25,'theatr',25,'octob',25,'2016',15,'johnni',24,'bridg',24,'spi',31,'actor',11,'favorit')

TomHardy = c(175,'legend',128,'dog',114,'rememb',114,'took',120,'premier',17,'ford',13,'reven',44,'film',15,'david')

ChristianBale = c(47,'birthday',46,'happi',32,'batman',29,'knight',16,'award',51,'42',42,'actor')

CharlizeTheron = c(150,'photo',80,'pictur',55,'hot',55,'sexi',19,'candid',83,'glossi',87,'penn',105,'sean',61,'celebr',70,'star',79,'movi')

MarkRuffalo = c(75,'spotlight',29,'fantast',28,'work',68,'actor',52,'award')

MattDamon = c(45,'martian',28,'movi',26,'water',17,'crisi')

RachelMcadams = c(47,'award',24,'spotlight',39,'notebook',38,'ryan',36,'film',34,'hate',17,'end',48,'canadian',48,'fellow',16,'cute')

StanleyTucci = c(38,'night',37,'big',24,'revolut',24,'help',52,'portrait',52,'final',49,'financ',47,'riverston',47,'pictur',81,'male',81,'like',81,'credit',81,'streep',80,'meryl')

WillPoulter = c(98,'happi',96,'birthday',14,'dicaprio',12,'leonardo',20,'menswear',24,'reven',35,'star',19,'maze',19,'runner')



brad_pitt = read.csv('brad_pitt.csv')
brad_pitt['label'] = c(rep(1,5),rep(2,5),rep(3,5),rep(4,5))

charlize_theron = read.csv('charlize_theron.csv')
charlize_theron['label'] = c(rep(1,5),rep(2,5),rep(3,5),rep(4,5))

leo_dicaprio = read.csv('leo_dicaprio.csv')
leo_dicaprio['label'] = c(rep(1,5),rep(2,5),rep(3,5),rep(4,5))

tom_hardy = read.csv('tom_hardy.csv')
tom_hardy['label'] = c(rep(1,5),rep(2,5),rep(3,5),rep(4,5))

stanley_tucci = read.csv('stanley_tucci.csv')
stanley_tucci['label'] = c(rep(1,5),rep(2,5),rep(3,5),rep(4,5))

christian_bale = read.csv('christian_bale.csv')
christian_bale['label'] = c(rep(1,5),rep(2,5),rep(3,5),rep(4,5))








library(MASS) # to access Animals data sets
library(scales) # to access break formatting functions

charlize_theron$X01 <-  reorder(charlize_theron$X0, charlize_theron$label)
ggplot(charlize_theron, aes(x=X0, y=X,col=label,fill=label)) +
  geom_bar(stat='identity') 
# +facet_grid(.~label) + 
#   theme(axis.text.x  = element_text(angle = 45, hjust = 1))


#png("domain_bar.png", width=640,height=400)
colnames(charlize_theron)=c("probability_of_word","words_of_topic","topic_label")
charlize_theron$"word_of_topic" <-  reorder(charlize_theron$"words_of_topic", charlize_theron$"topic_label")


ggplot(charlize_theron, aes(x=words_of_topic, y=probability_of_word,fill=topic_label)) +
  geom_bar(aes(x=word_of_topic),stat='identity',position='stack') +facet_grid(.~topic_label,margins=T) +
   theme(axis.text.x=element_text(angle = 60, hjust = 1) ) +
   ggtitle("Topics From Tweets About Charlize Theron")+coord_flip()  


colnames(leo_dicaprio)=c("probability_of_word","words_of_topic","topic_label")
leo_dicaprio$"word_of_topic" <-  reorder(leo_dicaprio$"words_of_topic", leo_dicaprio$"topic_label")

ggplot(leo_dicaprio, aes(x=words_of_topic, y=probability_of_word,fill=topic_label)) +
  geom_bar(aes(x=word_of_topic),stat='identity') +facet_grid(.~topic_label,margins=T) + 
  theme(axis.text.x  = element_text(angle = 60, hjust = 1)) +
  ggtitle("Topics From Tweets About Leo Dicaprio")+coord_flip()



+coord_flip()                                                                                     
 
  +scale_y_sqrt(breaks = trans_breaks("sqrt", function(x) x^2),
                labels = trans_format("sqrt", math_format(.x^2))) 
  coord_flip()
dev.off()



