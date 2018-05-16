cd /home/lein/yan_thesis/raw_data/original

for d in *; do
 echo $d
 cd $d
 cp /home/lein/yan_thesis/raw_data/original/Scripts_for_generating_Lat_and_Lon_using_Radarsat2_xml_file/xmlparse.py ./
 cp /home/lein/yan_thesis/raw_data/original/Scripts_for_generating_Lat_and_Lon_using_Radarsat2_xml_file/latlon_imfull.py ./
 python xmlparse.py
 echo 'finished pickle file'
 python latlon_imfull.py
 echo 'done'

 cd ..

done

