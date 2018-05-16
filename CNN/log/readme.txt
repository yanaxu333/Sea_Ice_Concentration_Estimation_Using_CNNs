the code in this folder is maily for drawing a plot of training loss and testing loss versus the number of iteration; aimed at looing how the loss goes down during training CNN

Step1: cd to this log folder
step2: execute:
./parse_log.sh train-2018-32-26-13-32-54.log
# this will be generating two files 
train-2018-32-26-13-32-54.log.train 
and
train-2018-32-26-13-32-54.log.test 

Step3: change the log filename in the plot.py file 
Step4: python plot.py
#finilly you will get the image

