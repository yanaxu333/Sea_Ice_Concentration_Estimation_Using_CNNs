import numpy as np
import os 
import scipy.io
from scipy.misc import imsave
import math
import glob as glob
# get the 25 SAR scene number of 25 SAR scenes; therefore, we can iterate through all of them

dirc = '/home/lein/yan_thesis/raw_data/original/*'
dirs= glob.glob(dirc)

for di in dirs:
	snum = di.split('/')[6]
	snum = snum[35:36+14]
	print snum


	#load image lat-lon files
	mat1 = scipy.io.loadmat('/home/lein/yan_thesis/raw_data/lat_lon/%s_lon.mat'%snum)
	mat2 = scipy.io.loadmat('/home/lein/yan_thesis/raw_data/lat_lon/%s_lat.mat'%snum)

	lon_im = mat1['lon2']                           
	lat_im = mat2['lat2']  
	if lon_im.shape != lat_im.shape:  
		print 'the size of lat and lon does not match'

	 #create a empty array for storing wind speed image
	sha= lon_im.shape 
	ws_image = np.zeros((sha[0],sha[1]))

                    
 #----------------------------------------------------------------------

	# load in wind speed data 
	uu = open('/home/lein/yan_thesis/raw_data/ws/%s_UU.txt'%snum, 'r ')
	vv = open('/home/lein/yan_thesis/raw_data/ws/%s_VV.txt'%snum, 'r')
	 #create three lists
	 #one list for saving windspeed data UU,one for windspeed data VV,  the other list saves lat and lon  information
	ws_uu=[]
	ws_vv=[]
	lat_lon_ws =[]# the first element is lat, while the second element is lon\
	ws=[]

	 
	for u in uu:
		u = u.split()
		ws_uu.append(float(u[0]))
		lat_lon_ws.append([float(u[1]),(float(u[2])-360)])

	for v in vv:
		v = v.split()
		ws_vv.append(float(v[0]))

	for u,v in zip(ws_uu, ws_vv):
		temp=math.sqrt(u**2+v**2)
		ws.append(temp)

	# convert list to array
	#the following code just make sure the readin file has the same size and 
	# we can have a basic view of how the images' maximum and minimum value of lat and lon 

	lat_lon_ws =np.asarray(lat_lon_ws)
	print 'the lat and lon range for wind speed '
	print np.amax(lat_lon_ws, axis=0)               
	print np.amin(lat_lon_ws, axis=0)

	print 'the lat and lon range for images'
	print np.amax(lon_im)                                                   
	print np.amin(lon_im)                           
	                                                                         
	print np.amax(lat_im)                                                   
	print np.amin(lat_im)  
	print len(ws), lat_lon_ws.shape, lat_im.shape, lon_im.shape

	for i in range(sha[0]):
		print i
		for j in range(sha[1]):
			or_lon=lon_im[i,j]
			or_lat=lat_im[i,j]
			tem_array=np.sqrt((lat_lon_ws[:,:1]-or_lat)**2 +(lat_lon_ws[:,1:2]-or_lon)**2)
			index = np.argmin(tem_array)
			ws_image[i,j] = ws[index]
			

	print ws_image.shape
	ws_im = []
	ws_im = ws_image
	imsave('/home/lein/yan_thesis/raw_data/ws_ima/%s_ws.tif'%snum, ws_im)




