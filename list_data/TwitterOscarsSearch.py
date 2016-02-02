#https://api.twitter.com/1.1/search/tweets.json?q=%23Oscars&src=typd
#all based on the ch1 and ch 9 websites
#accomplishes getting words, screennames mentioned, hashtags, and text
##############SETTING UP SEARCH API ACCESS##################
import twitter
import json

CONSUMER_KEY       = "z3zSbTr9SlsOKh7xyvCTucZaW"
CONSUMER_SECRET    = "K3omYZifBRQynix3CmGd3UwqSteiF815SBjsLqAuPAN4PkOVJ6"
OAUTH_TOKEN        = "30330422-hoj8YAx3S2ry1zMNRJ5n0rJw1IwCS02pEEO7WZYUp"
OAUTH_TOKEN_SECRET = "dUTUteQ96Wy0cYgWGgNvKpmFfAJbnysvBjisbBr5wkPcS"

auth = twitter.oauth.OAuth(OAUTH_TOKEN, OAUTH_TOKEN_SECRET,
                           CONSUMER_KEY, CONSUMER_SECRET)

twitter_api = twitter.Twitter(auth=auth)


q = 'Oscars' 

count = 100

###############RUN INITIAL SEARCH RESULTS#######################
search_results = twitter_api.search.tweets(q=q, count=count)

statuses = search_results['statuses']


# Iterate through 5 more batches of results by following the cursor

for _ in range(5):
	print("Length of statuses", len(statuses))
	try:
		next_results = search_results['search_metadata']['next_results']
	except KeyError, e:
	break
        
    # Create a dictionary from next_results, which has the following form:
    # ?max_id=313519052523986943&q=NCAA&include_entities=1
	kwargs = dict([ kv.split('=') for kv in next_results[1:].split("&") ])
    
	search_results = twitter_api.search.tweets(**kwargs)
	statuses += search_results['statuses']

#############SLICING BASED ON ONE PART OF THE LIST##################
print(json.dumps(statuses[0], indent=1))

status_texts = [ status['text'] 
                 for status in statuses ]

screen_names = [ user_mention['screen_name'] 
                 for status in statuses
                     for user_mention in status['entities']['user_mentions'] ]

hashtags = [ hashtag['text'] 
             for status in statuses
                 for hashtag in status['entities']['hashtags'] ]

# Compute a collection of all words from all tweets
words = [ w 
          for t in status_texts 
              for w in t.split() ]

# Explore the first 5 items for each...

print(json.dumps(status_texts[0:5], indent=1))
print(json.dumps(screen_names[0:5], indent=1))
print(json.dumps(hashtags[0:5], indent=1))
print(json.dumps(words[0:5], indent=1))


###################FREQUENCY DISTRIBUTION###########################
from collections import Counter

for item in [words, screen_names, hashtags]:
    c = Counter(item)
    print(c.most_common()[:10]) # top 10

####################PLOTTING WORD COUNTS###########################
import matplotlib.pyplot as plt

word_counts = sorted(Counter(words).values(), reverse=True)

plt.loglog(word_counts)
plt.ylabel("Freq")
plt.xlabel("Word Rank")
plt.show()

###################HISTOGRAM OF STUFF##############################
##########DOESN'T WORK###############

for label, data in (('Words', words), 
                    ('Screen Names', screen_names), 
                    ('Hashtags', hashtags)):

    # Build a frequency map for each set of data
    # and plot the values
    c = Counter(data)
    plt.hist(c.values())
    
    # Add a title and y-label ...
    plt.title(label)
    plt.ylabel("Number of items in bin")
    plt.xlabel("Bins (number of times an item appeared)")
    
    # ... and display as a new figure
    plt.figure()

