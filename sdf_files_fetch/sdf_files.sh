for id in $(cat pubchem_id_list.txt) #download 2D structures (sdf files)
do
	wget -O ${id}.sdf https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/cid/${id}/SDF
done
mkdir sdf_files_2d
mv *.sdf sdf_files_2d
