# this  code can apply land mask to the SAR images

import numpy as np
import os 
import scipy.io
from scipy.misc import imsave
import math
import glob as glob
# get the 25 SAR scene number of 25 SAR scenes; therefore, we can iterate through all of them

dirc = '/home/lein/yan_thesis/raw_data/2011_2012/rs2/*'
dirs= glob.glob(dirc)

mat = scipy.io.loadmat('landmaskna.mat')
lat = mat['latvalsna']
lon = mat['lonvalsna']
landmask = mat['landnafp']


for di in dirs:
	snum = di.split('/')[7]
	snum = snum[35:36+14]
	print snum


	#load image lat-lon files
	mat1 = scipy.io.loadmat('/home/lein/yan_thesis/raw_data/2011_2012/lat_lon/%s_lon.mat'%snum)
	mat2 = scipy.io.loadmat('/home/lein/yan_thesis/raw_data/2011_2012/lat_lon/%s_lat.mat'%snum)

	lon_im = mat1['lon2']                           
	lat_im = mat2['lat2']  
	if lon_im.shape != lat_im.shape:  
		print 'the size of lat and lon does not match'

	sha= lon_im.shape 
	land_mask = np.zeros((sha[0],sha[1]))
	for i in range(sha[0]):

		for j in range(sha[1]):
			or_lon=lon_im[i,j]
			or_lat=lat_im[i,j]

			tem_lat=np.abs(lat-or_lat)
			tem_lon=np.abs(lon-or_lon)
			lat_index = np.argmin(tem_lat)
			lon_index = np.argmin(tem_lon)

			land_mask[i,j] = landmask[lat_index,lon_index]
			'''lat_li.append(lat_index)
			lon_li.append(lon_index)
		'''
		#print lat_index



	mk_im = land_mask

	mk_im[np.isnan(mk_im)] =0

	imsave('/home/lein/yan_thesis/raw_data/2011_2012/immask/%s_msk.tif'%snum, mk_im)
