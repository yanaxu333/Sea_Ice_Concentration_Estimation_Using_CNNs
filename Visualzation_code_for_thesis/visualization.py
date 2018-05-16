import scipy.io as sio
import numpy 
import pandas as pd
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns
np.random.seed(sum(map(ord, "aesthetics")))
sns.set(color_codes=True)

np.random.seed(sum(map(ord, "distributions")))



pre_label_all = sio.loadmat('/home/lein/yan/caffe/finetunning_thesis/mirroring/code/all_prediction_label.mat')
pre_label_partial = sio.loadmat('/home/lein/yan/caffe/finetunning_thesis/partial/1_par/code/all_prediction_label_partial.mat')
print type(pre_label_all)
pre_label_all.keys()
pre_label_all = pre_label_all['C']
pre_label_partial = pre_label_partial['C']
print 'dg'
label_all = pre_label_all[:,1]
type(label_all)
sns.distplot(label_all, kde=False, rug=True);
#plt.show()
plt.savefig("ic_image_chart.tif" )
