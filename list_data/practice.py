#Practice for Monday 1/25

# Finding topics of interest by using the filtering capablities it offers.

import twitter

# Query terms

q = '@realDonaldTrump' # Comma-separated list of terms

print >> sys.stderr, 'Filtering the public timeline for track="%s"' % (q,)

# Returns an instance of twitter.Twitter
api = oauth_login()

# Reference the self.auth parameter
twitter_stream = twitter.TwitterStream(auth=api.auth)

# See https://dev.twitter.com/docs/streaming-apis
stream = twitter_stream.statuses.filter(track=q)

# For illustrative purposes, when all else fails, search for Justin Bieber
# and something is sure to turn up (at least, on Twitter)

for tweet in stream:
    print(tweet['text'])
    # Save to a database in a particular collection

names = ['@realDonaldTrump']
timeline = [api.statuses.user_timeline(screen_name=name)
                  for name in names]
with open("timeline.json", "w") as f:
    json.dump(timeline, f, indent=4, sort_keys=True)

timeline[0][0]["text"]
timeline[0][0]["favorite_count"]