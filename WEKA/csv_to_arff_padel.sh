#!/bin/bash

cl="cell_line_names.txt"
#mkdir arff_files_padel_filtered
while IFS= read -r line
do
        #line=`echo ${line//\"/}`
        echo $line
        java -Xmx20G -cp /home2/softwares/weka/weka-3-8-6/weka.jar \
        weka.core.converters.CSVLoader /home2/QSAR_check/merged_padelf_ic50/padel_final_file_weka_filtered_mmff94_${line}.csv > weka_input_padel_filtered_mmff94_${line}.arff
        #mv weka_input_padel_filtered_${line}.arff arff_files_padel_filtered
done <$cl

