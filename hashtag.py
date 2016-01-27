from twython import Twython

TWITTER_APP_KEY = 'eWH6hZjvaIylC5e4FDkGmPyts' #supply the appropriate value
TWITTER_APP_KEY_SECRET = 'WosRj9W8dqF4efo6FklEdSKeKJz5bcoCNVoblrwWmQhBdjLDzq' 
TWITTER_ACCESS_TOKEN = '4831953172-k3Tau7kPOUYYCs4LzoyfMW9ouXGjerLSyAlE4zs'
TWITTER_ACCESS_TOKEN_SECRET = 'sUZCADZAxg9oLxQS7l23ypvTvopgaSqb5nVUq8Rr7yBp6'

t = Twython(app_key=TWITTER_APP_KEY, 
            app_secret=TWITTER_APP_KEY_SECRET, 
            oauth_token=TWITTER_ACCESS_TOKEN, 
            oauth_token_secret=TWITTER_ACCESS_TOKEN_SECRET)

search = t.search(q='#oscars',   #**supply whatever query you want here**
                  count=1000)

tweets_oscar = search['statuses']

for tweet in tweets_oscar:
    print(tweet['id_str'], '\n', tweet['text'], '\n\n\n')



search_revenant = t.search(q='#therevenant',   #**supply whatever query you want here**
                  count=100)

tweets_revenant = search_revenant['statuses']

for tweet in tweets_revenant:
    print(tweet['id_str'], '\n', tweet['text'], '\n\n\n')



import json
with open("oscars.json", "w") as f:
    json.dump(tweets_oscar, f, indent=4, sort_keys=True)

# get all the senators' timelines
#names = [d["screen_name"] for d in senators["users"]]
#timelines = [api.statuses.user_timeline(screen_name=name)
#                  for name in names]
with open("therevenant.json", "w") as f:
    json.dump(tweets_revenant, f, indent=4, sort_keys=True)


with open("oscars.json") as infile:
    oscars = json.load(infile)
    
with open("therevenant.json") as infile:
    therevenant = json.load(infile)



oscars[1]['user']['screen_name']


