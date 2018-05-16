#!/usr/bin/env python
# ./parse_log.sh train-2018-52-03-12-52-36.log
import inspect
import os
import random
import sys
import matplotlib.cm as cmx
import matplotlib.colors as colors
import matplotlib.pyplot as plt
import matplotlib.legend as lgd
import matplotlib.markers as mks

train_loss=[]
test_loss=[]
ite_train=[]
ite_test=[]

filename ='2018-15-15-09-15-41'

with open('train-%s.log.train' %filename) as f:
    count=0
    for line in f.readlines():
        line =line.strip().split()
        count +=1
        if count>1:
            train_loss.append(float(line[2]))
            ite_train.append(float(line[0]))





with open('train-%s.log.test'%filename) as f:
    count =0 
    for line in f.readlines():
        line =line.strip().split()
        count +=1
        if count>1:
            test_loss.append(float(line[2]))
            ite_test.append(float(line[0]))


fig = plt.figure()

plt.plot( ite_test, test_loss, 'r',label ='test_loss')
plt.plot( ite_train, train_loss,'b', label= 'train_loss')
plt.title('Train_loss & Test_loss vs. Iter.')
plt.xlabel('Iter.')
plt.ylabel('Loss')
plt.legend()

#plt.ylim(50)
#plt.xlim(1000)
plt.savefig('/home/lein/yan/caffe/finetunning_thesis/mirroring/log/only1fc_layer.jpg')
plt.show()
