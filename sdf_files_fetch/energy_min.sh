#!/bin/bash

cl='pubchem_id_list.txt'
mkdir sdf_files_3d_ob
while IFS= read -r line
do
	line=`echo ${line}`
	echo $line
	#obabel -isdf sdf_files_2d/${line}.sdf -osdf -O ${line}_3d.sdf --gen3d
	obabel sdf_files_3d/${line}_3d.sdf -O ${line}_3d_ob.sdf --minimize --ff MMFF94 
	#obminimize -isdf sdf_files_3d/${line}_3d.sdf -osdf -O sdf_files_3d_ob/${line}_3d_ob.sdf
	#mv ${line}_3d.sdf sdf_files_3d
	mv ${line}_3d_ob.sdf sdf_files_3d_ob
done <$cl
