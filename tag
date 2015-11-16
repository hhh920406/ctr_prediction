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
