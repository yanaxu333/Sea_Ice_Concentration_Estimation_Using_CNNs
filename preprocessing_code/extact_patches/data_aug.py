import numpy as np
import cv2
from PIL import Image
from glob import glob
import numpy as np
import pandas as pd
from tqdm import tqdm


def data_augmentation(images, options={}):
	horizontal_flips = options.get('horizontal_flips', True)	
	augmented_images_set = images[:]
	if horizontal_flips:
		augmented_images_set += [cv2.flip(np.array(image), 1) for image in augmented_images_set]
	return [np.array(image) for image in augmented_images_set]







n = len(glob('/home/lein/patches/patches_10_mirroring/samples/*/*/*.jpg'))
for i, file_name in tqdm(enumerate(glob('/home/lein/patches/patches_10_mirroring/samples/*/*/*.jpg')), total=n):

	img = cv2.imread(file_name)
	a = file_name.split('/')[6]
	b = file_name.split('/')[7]
	c = file_name.split('/')[8]
	#print a,b,c
	#print type(img)
	augmented_images = data_augmentation([img])
	#print '/home/lein/patches/dataaug/patches_10_mirroring/samples/%s/%s'%(a,b) 
	
	for i in range(len(augmented_images)):
		cv2.imwrite('/home/lein/patches/dataaug/patches_10_mirroring/samples/%s/%s/'%(a,b) +str(i)+c, augmented_images[i])
		
