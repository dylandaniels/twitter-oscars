
cd /Users/zhouyun/Desktop/twitter-oscars

import nibabel as nib
import numpy as np
import json
import os
from clean import *
from datetime import *
from dateutil import parser
import matplotlib.pyplot as plt
from ggplot import *
import pandas as pd

path_to_json = '/Users/zhouyun/Desktop/twitter-oscars/stream-tweets-examples/BradPitt/'
json_files = [pos_json for pos_json in os.listdir(path_to_json) if pos_json.endswith('.json')]

BradPitt = []
for js in json_files:
    with open(path_to_json+js) as infile:
        sample = json.load(infile)
    sample['text'] = tokenize(sample['text'])
    sample['created_at'] = parser.parse(str(sample['created_at']))
    sample['created_at'] = str(sample['created_at'])
    BradPitt.append(sample)
    

cd /Users/zhouyun/Desktop/twitter-oscars/stream-tweets-examples/

#######

with open ('BradPitt.json') as infile:
    BradPitt_info = json.load(infile)
    
BradPitt_timeline = [w['created_at'] for w in BradPitt_info]

BradPitt_followers_count = [w['user']['followers_count'] for w in BradPitt_info]

BradPitt_plt = pd.DataFrame({'time':pd.DatetimeIndex(BradPitt_timeline),'value':BradPitt_followers_count})


p1 = ggplot(BradPitt_plt, aes('time','value')) + \
    geom_line(color='coral') + \
    scale_x_date(breaks=date_breaks('1 minutes'),labels='%Y')
p1


#####

with open ('thebigshort.json') as infile:
    thebigshort_info = json.load(infile)
    
thebigshort_timeline = [w['created_at'] for w in thebigshort_info]

thebigshort_followers_count = [w['user']['followers_count'] for w in thebigshort_info]

thebigshort_plt = pd.DataFrame({'time':pd.DatetimeIndex(thebigshort_timeline),'value':thebigshort_followers_count})


p2 =  ggplot(thebigshort_plt, aes('time','value')) + \
    geom_line(color='blue') + \
    scale_x_date(breaks=date_breaks('1 minutes'),labels='%Y')

####
with open ('LeoDiCaprio.json') as infile:
    LeoDiCaprio_info = json.load(infile)
    
LeoDiCaprio_timeline = [w['created_at'] for w in LeoDiCaprio_info]

LeoDiCaprio_followers_count = [w['user']['followers_count'] for w in LeoDiCaprio_info]

LeoDiCaprio_plt = pd.DataFrame({'time':pd.DatetimeIndex(LeoDiCaprio_timeline),'value':LeoDiCaprio_followers_count})


p3 = ggplot(LeoDiCaprio_plt, aes('time','value')) + \
    geom_line(color='blue') + \
    scale_x_date(breaks=date_breaks('1 minutes'),labels='%Y') 

combined = pd.DataFrame({'timeLeo':pd.DatetimeIndex(LeoDiCaprio_timeline[0:21]),
              'LeoCount':LeoDiCaprio_followers_count[0:21],
              #'timeBrad':pd.DatetimeIndex(BradPitt_timeline),
              'BradCount':BradPitt_followers_count})
              
ggplot(pd.melt(combined, id_vars=['timeLeo']), aes(x='timeLeo', y='value', color='variable')) +\
    geom_line()