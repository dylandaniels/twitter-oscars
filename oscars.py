from twitter import *
import os

# Put these in ~/.profile (on OS X) or ~/.bashrc (on Linux)
TWITTER_CONSUMER_KEY = os.environ['TWITTER_CONSUMER_KEY']
TWITTER_CONSUMER_SECRET = os.environ['TWITTER_CONSUMER_SECRET']
TWITTER_ACCESS_TOKEN = os.environ['TWITTER_ACCESS_TOKEN'] 
TWITTER_ACCESS_SECRET = os.environ['TWITTER_ACCESS_SECRET'] 

def twitConn():
    """Gets a twitter connection object.

    Returns
    -------
    conn : Twitter
        A twitter connection object
    """
    t = Twitter(auth=OAuth(TWITTER_ACCESS_TOKEN,
                           TWITTER_ACCESS_SECRET,
                           TWITTER_CONSUMER_KEY, 
                           TWITTER_CONSUMER_SECRET))
    return t

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


# Remove comment for example usage
# print(extractTextFromStatusList(statusesForQuery('#Oscars')))


