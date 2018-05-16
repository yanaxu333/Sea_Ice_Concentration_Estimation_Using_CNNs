
#echo 'start creating the directory files for each image patches'
folder=1 



working_dir=/home/lein/patches/2013/samples # this is the directory of all the patches are stored
target_dir=/home/lein/yan/caffe/finetunning_thesis/argu_par_ic/1fold_2013_parIC
#this is the directory that saving the generated .txt files 


while [ $folder -lt 11 ]
do
	echo $folder #there are 11 floders, corresponding to 11 SAR scenes

	subfolder=0  #subfolder contains different labeled ice concentration(or labels)
	while [ $subfolder -lt 11 ];
	do
    	echo $subfolder
    	 
    	directory=$working_dir/$folder/$subfolder
		if [ -d "$directory" ]; then
			echo here

			find $directory -type f -exec echo {} \; > $target_dir/temp/a_${folder}_${subfolder}.txt

			sed "s/$/ $subfolder/" $target_dir/temp/a_${folder}_${subfolder}.txt > $target_dir/train2/${folder}_${subfolder}.txt
		fi
	
    	subfolder=`expr $subfolder + 1`

	done

folder=`expr $folder + 1`

done

