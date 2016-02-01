import json

import twitter

# You will need to set the following variables with your
# personal information.  To do this you will need to create
# a personal account on Twitter (if you don't already have
# one).  Once you've created an account, create a new
# application here:
#    https://dev.twitter.com/apps
#
# You can manage your applications here:
#    https://apps.twitter.com/
#
# Select your application and then under the section labeled
# "Key and Access Tokens", you will find the information needed
# below.  Keep this information private.
CONSUMER_KEY       = "z3zSbTr9SlsOKh7xyvCTucZaW"
CONSUMER_SECRET    = "K3omYZifBRQynix3CmGd3UwqSteiF815SBjsLqAuPAN4PkOVJ6"
OAUTH_TOKEN        = "30330422-hoj8YAx3S2ry1zMNRJ5n0rJw1IwCS02pEEO7WZYUp"
OAUTH_TOKEN_SECRET = "dUTUteQ96Wy0cYgWGgNvKpmFfAJbnysvBjisbBr5wkPcS"

auth = twitter.oauth.OAuth(OAUTH_TOKEN, OAUTH_TOKEN_SECRET,
                           CONSUMER_KEY, CONSUMER_SECRET)
api = twitter.Twitter(auth=auth)

print(api)