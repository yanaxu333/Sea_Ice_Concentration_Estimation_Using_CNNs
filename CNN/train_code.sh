#!/usr/bin/env sh
# begin train
folder=argu_par_ic/1fold_2013_parIC
set -e
LOG=/home/lein/yan/caffe/finetunning_thesis/$folder/log/train-`date +%Y-%M-%d-%H-%M-%S`.log
TOOLS=/home/lein/yan/caffe/build/tools
MODEL=/home/lein/yan/caffe/finetunning_thesis/$folder/solver.prototxt


#$TOOLS/caffe train  -solver $MODEL/$NAME-solver.prototxt  -weights $MODEL/VGG_16_layers.caffemodel -gpu 0 > VGG2.log

$TOOLS/caffe train  -solver $MODEL -gpu 0 2>&1 | tee $LOG


#sudo build/tools/caffe train -s	olver finetunning_thesis/try20170916/solver.prototxt -weights models/bvlc_reference_caffenet/bvlc_reference_caffenet.caffemodel -gpu 0
