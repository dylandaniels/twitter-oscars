############ALANNA'S CODE FOR OSCARS LIST#######################
import twitter
import json

CONSUMER_KEY       = "z3zSbTr9SlsOKh7xyvCTucZaW"
CONSUMER_SECRET    = "K3omYZifBRQynix3CmGd3UwqSteiF815SBjsLqAuPAN4PkOVJ6"
OAUTH_TOKEN        = "30330422-hoj8YAx3S2ry1zMNRJ5n0rJw1IwCS02pEEO7WZYUp"
OAUTH_TOKEN_SECRET = "dUTUteQ96Wy0cYgWGgNvKpmFfAJbnysvBjisbBr5wkPcS"

auth = twitter.oauth.OAuth(OAUTH_TOKEN, OAUTH_TOKEN_SECRET,
                           CONSUMER_KEY, CONSUMER_SECRET)

twitter_api = twitter.Twitter(auth=auth)

############# GET ACTOR TIMELINES ############
actors = twitter_api.lists.members(owner_screen_name="alannaiverson", 
                             slug="actors",
                             count=12)
with open("actors-list.json", "w") as f:
    json.dump(actors, f, indent=4, sort_keys=True)

actor_names = [d["screen_name"] for d in actors["users"]]

actor_timelines = [twitter_api.statuses.user_timeline(screen_name=name)
                  for name in actor_names]
with open("actor-timelines.json", "w") as f:
    json.dump(actor_timelines, f, indent=4, sort_keys=True)

############# GET MOVIE TIMELINES ################
movies = twitter_api.lists.members(owner_screen_name="alannaiverson", 
                             slug="movies",
                             count=7)
with open("movies-list.json", "w") as f:
    json.dump(movies, f, indent=4, sort_keys=True)

movie_names = [d["screen_name"] for d in movies["users"]]

movie_timelines = [twitter_api.statuses.user_timeline(screen_name=name)
                  for name in movie_names]
with open("movie-timelines.json", "w") as f:
    json.dump(movie_timelines, f, indent=4, sort_keys=True)