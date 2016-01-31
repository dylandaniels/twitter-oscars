# Write a function, called all_punct, which takes a word and returns a bool indicating whether all the characters are punctuation marks.


import string
def one_punc(w):
    s = set(w)
    
    for s in w:
        if s in string.punctuation:
            return True
    return False

def all_punc(w):
    return set(w).issubset(set(string.punctuation))


# Write a function, called remove_punct, which takes a word and returns the word with all punctuations characters removed.
def remove_punct(w):
    if one_punc(w):
        a = [s for s in w if s not in string.punctuation]
        b = ''.join(a)
        return b
    else:
        return w


# Create a list, called stopwords, which contains common english words. You may want to use this list:
stopword = "a,able,about,across,after,all,almost,also,am,among,an,and,any,are,as,at,be,because,been,but,by,can,cannot,could,dear,did,do,does,either,else,ever,every,for,from,get,got,had,has,have,he,her,hers,him,his,how,however,i,if,in,into,is,it,its,just,least,let,like,likely,may,me,might,most,must,my,neither,no,nor,not,of,off,often,on,only,or,other,our,own,rather,said,say,says,she,should,since,so,some,than,that,the,their,them,then,there,these,they,this,tis,to,too,twas,us,wants,was,we,were,what,when,where,which,while,who,whom,why,will,with,would,yet,you,your"

stopword = stopword.split(',')


# Write a function, called tokenize, which takes a tweet cleans it as well as removes all punctuation and stopwords.
def tokenize(tweet):
    
    tweet = tweet.split()
    cleaned = [remove_punct(t) for t in tweet if t and 
               (not all_punc(t)) and 
              'http' not in t and 
               t!='RT']
    cleaned_word = [t.lower() for t in cleaned if t.isalpha() and t.lower() not in stopword]
    
    return ' '.join(cleaned_word)



def clean(tweet):
    cleaned_words = [word.lower() for word in tweet.split() if
                     'http' not in word and
                     word.isalpha() and
                     word != 'RT']
    return ' '.join(cleaned_words)



