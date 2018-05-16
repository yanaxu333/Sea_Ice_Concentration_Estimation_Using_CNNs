

#! /usr/bin/python
#make incidence angle map
import numpy as np
import cv2
import sys
import os
import re
import glob

def make_incidence_angle_map(image_path, xml_path, out_path):
    im = cv2.imread(image_path, -1)
    xml = open(xml_path).readlines()
    direction = [l for l in xml if l.find('passDirection') != -1]
    ascend = direction[0].find('Ascending') != -1
    near = [l for l in xml if l.find('incidenceAngleNearRange') != -1]
    near = float(re.split("\<|\>", near[0])[2])
    far = [l for l in xml if l.find('incidenceAngleFarRange') != -1]
    far = float(re.split("\<|\>", far[0])[2])
    if ascend:
        left = near
        right = far
    else:
        left = far
        right = near
    for i in range(0, im.shape[1]):
        im[:,i] = i * (right - left) / (im.shape[1]-1) + left
    cv2.imwrite(out_path, im)

if __name__ =='__main__':
    folderlist = os.listdir('/home/lein/yan_thesis/raw_data/2011_2012/rs2')
    folderlist = [f for f in folderlist if f.find('RS2') != -1]
    for f in folderlist:
        day = '_'.join(f.split('_')[5:7])
        image_path = '/home/lein/yan_thesis/raw_data/2011_2012/hhv/' + day + '-HH-8by8-mat.tif'
        xml_path ='/home/lein/yan_thesis/raw_data/2011_2012/rs2/'+ f + '/product.xml'
        out_path = '/home/lein/yan_thesis/raw_data/2011_2012/IA/' + day + '_IA.tif'
        print image_path                       
        print xml_path
        print out_path
  
        make_incidence_angle_map(image_path, xml_path, out_path)

