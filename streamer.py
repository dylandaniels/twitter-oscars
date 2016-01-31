import random
import sys
import datetime
import json
import oscars
import os

termsFile = sys.argv[1]
with open(termsFile) as f:
    termList = f.read().replace('\n', ',')

termsFileBasename = os.path.basename(termsFile)
fileExtIndex = termsFileBasename.find('.txt')

def generateFileName(): 
    if fileExtIndex < 0:
        raise Exception('File must end with .txt')
    else:
        os.makedirs('stream-tweets/' + termsFileBasename[0:fileExtIndex], exist_ok=True)
        return 'stream-tweets/' + termsFileBasename[0:fileExtIndex] + '/' + str(datetime.datetime.now()).replace(' ', '-') + '.json'

credentialFiles = os.listdir('credentials')
conns = [oscars.twitStreamingConn('credentials/' + x) for x in credentialFiles]

s = conns[random.randint(0, len(conns) - 1)]

statusGen = s.statuses.filter(track=termList)

for status in statusGen:
    if 'text' in status:
        print(status['text'])
    else:
        print(str(status))
    with open(generateFileName(), 'a') as tweetsFile:
        tweetsFile.write(json.dumps(status) + '\n')
tweetsFile.close()

