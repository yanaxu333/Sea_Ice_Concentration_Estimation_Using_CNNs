import os  
caffe_root = '/home/lein/yan/caffe/'  
os.chdir(caffe_root)  
import sys  
sys.path.insert(0,'./python')  
  
import caffe  
import numpy as np  

if len(sys.argv)!=3:
    print "Usage: python convert_mean.py mean.binaryproto mean.npy"
    sys.exit()
os.chdir(r'/home/lein/yan/caffe/finetunning_thesis/argu_par_ic/1fold_2013_parIC')
blob = caffe.proto.caffe_pb2.BlobProto()
bin_mean = open( sys.argv[1] , 'rb' ).read()
blob.ParseFromString(bin_mean)
arr = np.array( caffe.io.blobproto_to_array(blob) )
npy_mean = arr[0]
np.save( sys.argv[2] , npy_mean )
