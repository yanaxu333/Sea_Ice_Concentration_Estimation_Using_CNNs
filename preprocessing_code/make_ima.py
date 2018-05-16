# this code can interprate the image analysis charts to match SAR image
# this operation aims at generating groundtruth for each image pixels in HH SAR images
 
import numpy as np
import os 
import scipy.io
from scipy.misc import imsave
import math
import glob as glob
import cv2
# get the 25 SAR scene number of 25 SAR scenes; therefore, we can iterate through all of them

dirc = '/home/lein/yan_thesis/raw_data/2011_2012/rs2/*'
dirs= glob.glob(dirc)

mat = scipy.io.loadmat('landmaskna.mat')
lat = mat['latvalsna']
lon = mat['lonvalsna']
landmask = mat['landnafp']

# load the lon and lat information of images
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




	#load in the imag analysis chart
	datContent = [i.strip().split() for i in open('/home/lein/yan_thesis/raw_data/2011_2012/ice_chart/%s_ima.dat'%snum).readlines()]
	ar = np.asarray(datContent)
	lon = ar[:,0].astype(float)
	lat = ar[:,1].astype(float)
	IC = ar[:,2].astype(float)
	IC =(IC*10).astype(int)



	#load land_mask ## Note 255 represents land while 0 represent ocean
	mask=scipy.misc.imread('/home/lein/yan_thesis/raw_data/2011_2012/immask/%s_msk.tif' % snum)
	#plt.imshow(mask)


	sha= lon_im.shape 
	ima_im = np.zeros((sha[0],sha[1]))
	for i in range(sha[0]):
		for j in range(sha[1]):
			if mask[i,j] == 0:
				or_lon=lon_im[i,j]
				or_lat=lat_im[i,j]
				tem_array=np.sqrt((lat-or_lat)**2 +(lon-or_lon)**2)
				index = np.argmin(tem_array)
				ima_im[i,j] = IC[index]
			else:
				ima_im[i,j] = 11

	print ima_im.max(), ima_im.min()
	imsave('/home/lein/yan_thesis/raw_data/2011_2012/imc/%s_ima.tif'%snum, ima_im)
	#cv2.imwrite('/home/lein/yan_thesis/raw_data/2011_2012/ima/%s_ima.tif'%snum, ima_im)
