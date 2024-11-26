#!/bin/bash

cl="cell_line_names.txt"
#mkdir weka_output_padel_filtered_mmff94
while IFS= read -r line
do
        #line=`echo ${line//\"/}`
        echo $line
	java -Xmx20G -cp /home2/softwares/weka/weka-3-8-6/weka.jar weka.filters.unsupervised.attribute.RemoveUseless -M 99.0 -i /home2/QSAR_check/weka_processing/csv_to_arff/weka_input_padel_filtered_mmff94_${line}.arff -o useless_mmff94_${line}.arff;
        java -Xmx20G -cp /home2/softwares/weka/weka-3-8-6/weka.jar weka.filters.supervised.attribute.AttributeSelection -E "weka.attributeSelection.CfsSubsetEval -P 1 -E 1" -S "weka.attributeSelection.BestFirst -D 1 -N 5" -i useless_mmff94_${line}.arff -o reduced_features_mmff94_${line}.arff;
        java -Xmx20G -cp /home2/softwares/weka/weka-3-8-6/weka.jar weka.core.converters.CSVSaver -i reduced_features_mmff94_${line}.arff -o weka_out_padel_filtered_mmff94_${line}.csv;
        rm useless_mmff94_*;
        #mv weka_out_padel_filtered_mmff94_${line}.csv weka_output_padel_filtered_mmff94
done <$cl
