Note::: before executing the following steps, it is importamt to change some directory setting the the following code and other relative code 


step1: Execute
folder_generator.sh
: is used to generate folders for each experiments
-------------------------------------------------------------
step2: Execute:
get_file_location,sh 
: is used to generate the directory of where each image us stored in, beside, adding labels for each image, store these information in a train.txt and test.txt files 
---------------------------------------------------------------
Step3: Execute 
second_processing.sh 
: to conver data from image .jpg to a new format called LMDB, besides, compute the mean_files for images 

---------------------------------------------------------------
after executing these code, it should be go to the main directory to execute 

--------------------------------------------------------------------
Step4: execute 
sudo sh train_code.sh 
CNN will be starting training

------------------------------------------------------------
Step 5: do prediction by using:
python test_label.py

Step 6: To visualization the results, use the prop_mp.m code in the visulization_code_for _thesis folder

----------------------------------------------------------------
