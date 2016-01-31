from twitter import *
import os

# Put these in ~/.profile (on OS X) or ~/.bashrc (on Linux)
TWITTER_CONSUMER_KEY = os.environ['TWITTER_CONSUMER_KEY']
TWITTER_CONSUMER_SECRET = os.environ['TWITTER_CONSUMER_SECRET']
TWITTER_ACCESS_TOKEN = os.environ['TWITTER_ACCESS_TOKEN'] 
TWITTER_ACCESS_SECRET = os.environ['TWITTER_ACCESS_SECRET'] 

def readOAuthFromFile(filename):
    keys = []
    with open(filename) as data: 
        line = data.readline()
        while line:
            if line is not '\n':
                keys.append(line.split('"')[1])
            line = data.readline()
    return keys

def getOAuth():
    return OAuth(TWITTER_ACCESS_TOKEN,
                 TWITTER_ACCESS_SECRET,
                 TWITTER_CONSUMER_KEY, 
                 TWITTER_CONSUMER_SECRET)

def twitConn():
    """Gets a twitter connection object.

    Returns
    -------
    conn : Twitter
        A twitter connection object
    """
    return Twitter(auth=getOAuth())

def twitStreamingConn(filename=None):
    """Gets a twitter streaming connection object.
    """
    if filename is not None:
        keys = readOAuthFromFile(filename)
        auth = OAuth(keys[2], keys[3], keys[0], keys[1])
    else:
        auth = getOAuth()
    return TwitterStream(auth=auth)

def statusesForQuery(query, count=100):
    """Returns up to 100 statuses for a query via the Search API

    Parameters
    ----------
        q : string
            Query
        count : int
            The number of statuses to return (up to 100)

    Returns
    -------
    statuses : list
        A list of status dictionaries

    Examples
    --------
    statusesForQuery('#Oscars')
    """
    return twitConn().search.tweets(q=query, count=count)['statuses']

def extractTextFromStatusList(statuses):
    """Extracts the 'text' keys from a list of status objects 
    and returns them as a list of strings.

    Parameters
    ----------
        statuses
            A list of status objects (each must have key 'text')

    Returns
    -------
        tweets : string
            A list of tweets.
    """
    return [x['text'] for x in statuses]

def stream(filterWords):
    t = twitStreamingConn()
    return t.statuses.filter(track=filterWords)



# Remove comment for example usage
# print(extractTextFromStatusList(statusesForQuery('#Oscars')))

