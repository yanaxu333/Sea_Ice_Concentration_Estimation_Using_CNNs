#Reads relevant data from XML file and makes .pkl file with information

import xml.etree.ElementTree as ET
import numpy as np
import pickle


#open xml file
tree = ET.parse('product.xml')
root = tree.getroot()


#parse branches
'''
for branch in root:
    print branch.tag, branch.attrib
'''
#root[0] = 'productId',root[1] = 'documentIdentifier',root[2] = 'sourceAttributes',root[3] = 'imageGenerationParameters', root[4] = 'imageAttributes'


#parse image attributes
imgAtt = root[4]
'''
for att in imgAtt:
    print att.tag, att.attrib
'''
#imArr[3] = 'geographicInformation'


#parse geographic info
geoInf = imgAtt[3]
'''
for elem in geoInf:
    print elem.tag, elem.attrib
'''
#geoInf[0] = 'geolocationGrid',geoInf[1] = 'rationalFunctions',geoInf[2] = 'referenceEllipsoidParameters'
#geolocation grid is where the latitude and longitude info is in the xml file
#information for interpolation is in reference Ellipsoid Parameters


#parse latitude and longitude from geolocation grid
tieptGrid = geoInf[0]
#parse reference parameters
refparams = geoInf[2]
a = refparams[1] #semimajor axis
a_val = float(a.text)
a_unit = a.attrib
b = refparams[2] #semiminor axis
b_val = float(b.text) 
b_unit = b.attrib

print('semimajor axis of reference ellipsoid:',a_val,a_unit)
print('semiminor axis of reference ellipsoid:',b_val,b_unit)


#structure of geolocation/tiepoint grid
#tieptGrid -> each index is a tie pt with attrib [0] = imageCoordinate (pixel,line) and attrib [1] = geodeticCoordinate (lat,lon)

#tie point grids are (11,11)
#initializing arrays
line_array = np.zeros((11,11))
pixel_array = np.zeros((11,11))
lat_array = np.zeros((11,11))
lon_array = np.zeros((11,11))

#loop through all tie points, save values
i_ind = 0
j_ind = 0
for pt in tieptGrid:
    #image info
    imcoord = pt[0]
    line = float(imcoord[0].text)
    pixel = float(imcoord[1].text)
    #geographic info
    geocoord = pt[1]
    lat = float(geocoord[0].text)
    lon = float(geocoord[1].text)
    
    line_array[i_ind,j_ind] = line
    pixel_array[i_ind,j_ind] = pixel
    lat_array[i_ind,j_ind] = lat
    lon_array[i_ind,j_ind] = lon
    
    if i_ind == 10:
        i_ind = 0
        j_ind += 1
    else:
        i_ind += 1

print('Image coord: lines')
print(line_array)
print('Image coord: pixels')
print(pixel_array)
print('Geo coord: lat')
print(lat_array)
print('Geo coord: lon')
print(lon_array)


#save to pkl file
tie_pt_array = np.array([line_array,pixel_array,lat_array,lon_array]) #order lines, pixels, lats, lons
with open('test_tiepts.pkl','wb') as f:
    pickle.dump(tie_pt_array,f)
