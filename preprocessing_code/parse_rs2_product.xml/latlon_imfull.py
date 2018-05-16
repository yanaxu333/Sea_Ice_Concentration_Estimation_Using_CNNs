from PIL import Image
import numpy as np
import matplotlib.pyplot as pplt
import pickle

###Get Data###

##TIE POINTS##

with open('test_tiepts.pkl','r') as f:
    tie_pt_array = pickle.load(f)

tie_pt_imLines = tie_pt_array[0]
tie_pt_imPixels = tie_pt_array[1]
tie_pt_Lats = tie_pt_array[2]
tie_pt_Lons = tie_pt_array[3]

#convert tie_pt_Lats and tie_pt_Lons to radians
tie_pt_Lats_rad = tie_pt_Lats*(np.pi/180.)
tie_pt_Lons_rad = tie_pt_Lons*(np.pi/180.)

#get the size of the image
from scipy import misc
import numpy as np
image_hh =misc.imread('imagery_HH.tif')

im_dim1 = image_hh.shape[1]  # number pixels per line
im_dim2 = image_hh.shape[0] # number of lines

##IM COORDS##
#im_dim1 = 10542
#im_dim2 = 9779 
imPixels, imLines = np.indices((im_dim1,im_dim2)) 

###Interpolation###
#following steps outline in RS2 technical note, 3.2.1
##STEP 1##
#get tie points in cartesian from latitude and longitude

#from xml
a = 6378137.0 #m
b = 6356752.31425 #m

def x(lat,lon):
    num = a**2.*np.cos(lat)*np.cos(lon)
    denom = np.sqrt(a**2.*(np.cos(lat))**2. + b**2.*(np.sin(lat))**2.)
    x_val = num/denom
    return x_val

def y(lat,lon):
    num = a**2.*np.cos(lat)*np.sin(lon)
    denom = np.sqrt(a**2.*(np.cos(lat))**2. + b**2.*(np.sin(lat))**2.)
    y_val = num/denom
    return y_val
    
def z(lat,lon):
    num = b**2.*np.sin(lat)
    denom = np.sqrt(a**2.*(np.cos(lat))**2. + b**2.*(np.sin(lat))**2.)
    z_val = num/denom
    return z_val

tiePt_x = x(tie_pt_Lats_rad,tie_pt_Lons_rad)
tiePt_y = y(tie_pt_Lats_rad,tie_pt_Lons_rad)
tiePt_z = z(tie_pt_Lats_rad,tie_pt_Lons_rad)

##STEP 2##
#normalize image coords

#from tiff
m = im_dim1 # number pixels per line
n = im_dim2 # number of lines

#size of tie point grid MxN
M = tiePt_x.shape[0] #=11
N = tiePt_x.shape[1] #=11

def normalize(arr,A,a): #A = length of dimension in tie pt grid, a = length of dimension in image grid
    normd_arr = arr*(A-1.)/(a-1.)
    return normd_arr
    
imLines_normd = normalize(imLines,N,n)
imPixels_normd = normalize(imPixels,M,m)

#clear initial arrays
del imLines
del imPixels

##STEPS 2,3, and 4 are as follows##

#functions for interpolation in cartesian coordinates
def x_interp(P,L,u,v,x_uv,x_uplus1v,x_uvplus1,x_uplus1vplus1):
    x = (u + 1 - P)*(v + 1 - L)*x_uv + (P - u)*(v + 1 - L)*x_uplus1v + (u + 1 - P)*(L - v)*x_uvplus1 + (P - u)*(L - v)*x_uplus1vplus1    
    return x

def y_interp(P,L,u,v,y_uv,y_uplus1v,y_uvplus1,y_uplus1vplus1):
    y = (u + 1 - P)*(v + 1 - L)*y_uv + (P - u)*(v + 1 - L)*y_uplus1v + (u + 1 - P)*(L - v)*y_uvplus1 + (P - u)*(L - v)*y_uplus1vplus1
    return y
    
def z_interp(P,L,u,v,z_uv,z_uplus1v,z_uvplus1,z_uplus1vplus1):
    z = (u + 1 - P)*(v + 1 - L)*z_uv + (P - u)*(v + 1 - L)*z_uplus1v + (u + 1 - P)*(L - v)*z_uvplus1 + (P - u)*(L - v)*z_uplus1vplus1
    return z

#initialize arrays
interped_Xvals = np.zeros((im_dim1,im_dim2))
interped_Yvals = np.zeros((im_dim1,im_dim2))
interped_Zvals = np.zeros((im_dim1,im_dim2))

#loop through tie points, use each tie point to create subsampled array from the image to interpolate over
for i in range(0,len(tie_pt_imLines)-1):
    for j in range(0,len(tie_pt_imPixels)-1):
        
        #get indices for subsampling the image
        
        line_ij = tie_pt_imLines[j,i]
        line_ind_ij = int(round(line_ij))
        line_iplus1j = tie_pt_imLines[j,i+1]
        line_ind_iplus1j = int(round(line_iplus1j))
        pixel_ij = tie_pt_imPixels[j,i]
        pixel_ind_ij = int(round(pixel_ij))
        pixel_ijplus1 = tie_pt_imPixels[j+1,i]
        pixel_ind_ijplus1 = int(round(pixel_ijplus1))
        
        #subsample the image
        
        imLines_subsmpl = imLines_normd[pixel_ind_ij:pixel_ind_ijplus1+1,line_ind_ij:line_ind_iplus1j+1]
        imPixels_subsmpl = imPixels_normd[pixel_ind_ij:pixel_ind_ijplus1+1,line_ind_ij:line_ind_iplus1j+1]
        
        #perform interpolation
        
        u = j
        v = i
        
        x_uv = tiePt_x[u,v]
        x_uplus1v = tiePt_x[u+1,v]
        x_uvplus1 = tiePt_x[u,v+1]
        x_uplus1vplus1 = tiePt_x[u+1,v+1]
        
        im_Xs = x_interp(imPixels_subsmpl,imLines_subsmpl,u,v,x_uv,x_uplus1v,x_uvplus1,x_uplus1vplus1)
        #print(im_Xs)
        
        y_uv = tiePt_y[u,v]
        y_uplus1v = tiePt_y[u+1,v]
        y_uvplus1 = tiePt_y[u,v+1]
        y_uplus1vplus1 = tiePt_y[u+1,v+1]
        
        im_Ys = y_interp(imPixels_subsmpl,imLines_subsmpl,u,v,y_uv,y_uplus1v,y_uvplus1,y_uplus1vplus1)
        #print(im_Ys)
        
        z_uv = tiePt_z[u,v]
        z_uplus1v = tiePt_z[u+1,v]
        z_uvplus1 = tiePt_z[u,v+1]
        z_uplus1vplus1 = tiePt_z[u+1,v+1]
        
        im_Zs = z_interp(imPixels_subsmpl,imLines_subsmpl,u,v,z_uv,z_uplus1v,z_uvplus1,z_uplus1vplus1)
        #print(im_Zs)
        
        #put interepd vals into array
        
        interped_Xvals[pixel_ind_ij:pixel_ind_ijplus1+1,line_ind_ij:line_ind_iplus1j+1] = im_Xs
        interped_Yvals[pixel_ind_ij:pixel_ind_ijplus1+1,line_ind_ij:line_ind_iplus1j+1] = im_Ys
        interped_Zvals[pixel_ind_ij:pixel_ind_ijplus1+1,line_ind_ij:line_ind_iplus1j+1] = im_Zs

#clear
del imLines_normd
del imPixels_normd

##STEP 5##

#define transformation back to latitude and longitude
def lat(z):
    alpha = a*z/(b*(b**2. - z**2.)**(1./2.))
    return np.arctan(alpha)
    
def lon(x,y):
    return np.arctan2(y,x)
    
im_pt_Lats = lat(interped_Zvals)
im_pt_Lons = lon(interped_Xvals,interped_Yvals)

#convert back to degrees
im_pt_Lats = im_pt_Lats*(180./np.pi)
im_pt_Lons = im_pt_Lons*(180./np.pi)

#clear
del interped_Xvals
del interped_Yvals
del interped_Zvals

#check
#print(tie_pt_Lats)
#print(im_pt_Lats)

###Save to NetCDF4###

from netCDF4 import Dataset

#open
rootgrp = Dataset('test_im_latlon.nc','w',format='NETCDF4')

#dimension
Np = len(im_pt_Lats[:,1])
Nl = len(im_pt_Lats[1,:])

pixels = rootgrp.createDimension('pixels',Np)
lines = rootgrp.createDimension('lines',Nl)

#variable
latitude = rootgrp.createVariable('latitude','f8',('pixels','lines'))
longitude = rootgrp.createVariable('longitude','f8',('pixels','lines'))

latitude.units = 'deg'
longitude.units = 'deg'

#write arrays
latitude[:,:] = im_pt_Lats
longitude[:,:] = im_pt_Lons

#close
rootgrp.close()
