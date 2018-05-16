cd /home/lein/yan/caffe/finetunning_thesis/argu_par_ic/
dirw=/home/lein/yan/caffe/finetunning_thesis
a=1fold_2013_parIC
mkdir $a

cp $dirw/mirroring/* /home/lein/yan/caffe/finetunning_thesis/argu_par_ic/$a/
cd $a

mkdir train 
mkdir log
mkdir temp
mkdir code
mkdir snapshot
mkdir results
mkdir train2
mkdir temp2

b=test
mkdir $b

cp $dirw/mirroring/code/* /home/lein/yan/caffe/finetunning_thesis/argu_par_ic/$a/code/
cp $dirw/mirroring/train/* /home/lein/yan/caffe/finetunning_thesis/argu_par_ic/$a/train/
cp $dirw/mirroring/test/* /home/lein/yan/caffe/finetunning_thesis/argu_par_ic/$a/test/
cd $dirw/$a

ls 
rm train_all.txt 
rm test_all.txt 
rm mean.binaryproto
rm mean.npy


