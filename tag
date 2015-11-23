# coding: utf-8
import csv
from sklearn.preprocessing import OneHotEncoder
import numpy

#import types
#import numpy
#from  datetime  import  *  
#import  time  

csvfile = file('C:\Users\Gwinhen\Desktop\\test.csv', 'rb')

reader = csv.reader(csvfile)

arr=[]
table={}
i=-1

for line in reader:
    arr1=[]
    for tag in line[45].split('|'):
        arr1.append([int(tag)])
        if (not tag in table):
            table[tag]=[int(tag)]
    arr.append(arr1)

enc = OneHotEncoder()
enc.fit(table.values())

transformedTag=[]

for arr2 in arr:
    temp = [0 for x in range(0,numpy.shape(enc.transform(arr2).toarray())[1])]
    for v in enc.transform(arr2).toarray():
        temp+=v
    transformedTag.append(temp)
    
print numpy.shape(transformedTag)

csvfile.close()

print "finished"

---------------------------------------------dummies---------------------------------------------
import sys
reload(sys)
sys.setdefaultencoding("utf-8")
import csv
import numpy as np
import pandas as pd
from datetime import datetime
from dateutil.parser import parse
import calendar
import hashlib
from sklearn.preprocessing import OneHotEncoder
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import log_loss


NR_BINS = 1000000
def hashstr(input):
    return int(hashlib.md5(input.encode('utf8')).hexdigest(), 16)%(NR_BINS-1)+1
    


file = r'E:\ad\data\20151104.csv'

df = pd.read_csv(file, names = ['spotid', 'ac802', 'drt', 'uid', 'yob', 'gender', 'userid', 'ei', 'brd', 'mo', 'sw', 'sh', 'os', 'osv', 'ip', 'country', 'apn', 'connt', 'lat', 'lon', 'ua', 'w', 'h', 'pos', 'splash', 'adown', 'city', 'carrier', 'bidceiling', 'lang', 'bidprice', 'winprice', 'seq', 'inst1', 'adw', 'adh', 'title', 'content', 'imageurl', 'bidappnm', 'storeid', 'goal', 'hv', 'cst', 'rtype', 'tag'])
resY=df['ac802'].tolist()

df['drt'] = df['drt'].str.replace('+', ' ')


tag_iter = (set(str(x).split('|')) for x in df.tag)
tags = sorted(set.union(*tag_iter))
dummies = pd.DataFrame(np.zeros((len(df), len(tags))), columns=tags)
for i, tag in enumerate(df.tag):
    dummies.ix[i, str(tag).split('|')] = 1
df_windic = df.join(dummies.add_prefix('Tag_'))

print 'finished'
