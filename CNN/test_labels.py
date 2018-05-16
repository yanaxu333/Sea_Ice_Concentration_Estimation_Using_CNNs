#coding=utf-8
# at first, you need to adjust the fc8 and fc6 and the output classes in the last, cause in the train_val.prototxt file you retained these layers in fact, therefore, the deploy.prototxt should consistant with the the train_val.prototxt file. remember that, it is the most important concepts.
import numpy as np
import scipy.io as sio
import sys,os

#
caffe_root = '/home/lein/yan/caffe/' 
sys.path.insert(0, caffe_root + 'python')
import caffe
os.chdir(caffe_root)

D='argu_par_ic/1fold_2013_parIC'
serial_nums=[1,3,10,17,24]
for num in serial_nums:
	print num

	test_scene_num = num
	net_file=caffe_root + 'finetunning_thesis/%s/deploy.prototxt' % D
	caffe_model=caffe_root + 'finetunning_thesis/%s/snapshot/_iter_21000.caffemodel' % D
	mean_file=caffe_root + 'finetunning_thesis/%s/mean.npy'% D

	net = caffe.Net(net_file,caffe_model,caffe.TEST)
	transformer = caffe.io.Transformer({'data': net.blobs['data'].data.shape})
	transformer.set_transpose('data', (2,0,1))
	transformer.set_mean('data', np.load(mean_file).mean(1).mean(1))
	transformer.set_raw_scale('data', 255) 
	transformer.set_channel_swap('data', (2,1,0))

	def getAllImages(folder):
	    assert os.path.exists(folder)
	    assert os.path.isdir(folder)
	    imageList = os.listdir(folder)

	    return imageList
	#####################################
	  #you can define wich scene to test on?
	Imdirectory = '/home/lein/patches/patches_10_mirroring/samples/%s'%test_scene_num
	result_dir = '/home/lein/yan/caffe/finetunning_thesis/%s/results' %D
	imagelist1=getAllImages('%s' %Imdirectory)

	final_img_list=[]

	for i in range(len(imagelist1)):

		dir = getAllImages('%s/%s' %(Imdirectory, imagelist1[i]))

	 	final_img_list.append(dir)


	#print final_img_list
	#print imagelist1
	#print len(flattened_list)
	pid = 0 

	returnmat1=[]
	returnname = []
	for i in range(0, len(imagelist1)):

		for j in range(len(final_img_list[i])):


			image_root1=final_img_list[i][j]
		
			im=caffe.io.load_image('%s/%s/' %(Imdirectory, imagelist1[i]) +image_root1)

			net.blobs['data'].data[...] = transformer.preprocess('data',im)
			out = net.forward()
			loss= net.blobs['ip2'].data[0]#取出最后一层（Softmax）属于某个类别的概率值
			returnmat1.append(list(loss))
			returnname.append(image_root1)
			#print loss
			pid=pid+1
		   ## print image_root1

	flattened_list = [val for sublist in returnmat1 for val in sublist]

	final_results = np.asarray(flattened_list)
	#print returnname

	#
	sio.savemat('%s/%s_regression'%(result_dir,test_scene_num),{'data':final_results})
	sio.savemat('%s/%s_img_name'%(result_dir,test_scene_num),{'data':returnname})
