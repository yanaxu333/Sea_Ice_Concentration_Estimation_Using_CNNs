MY=finetunning_thesis/argu_par_ic/1fold_2013_parIC

echo "Create train lmdb.."
rm -rf $MY/img_train_lmdb
build/tools/convert_imageset --shuffle / $MY/train_all.txt  $MY/img_train_lmdb

echo "Create test lmdb.."
rm -rf $MY/img_test_lmdb
build/tools/convert_imageset --shuffle / $MY/test_all.txt  $MY/img_test_lmdb

echo "All Done.."
