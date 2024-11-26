#!/bin/bash

#from padelpy import padeldescriptor

#_= padeldescriptor(mol_dir='all_sdf_files_3d_ob.sdf', d_file='padel_all_desc.csv', d_2d=True, d_3d=True, fingerprints=True, convert3d=False, detectaromaticity=True, removesalt=False, retain3d=True, standardizenitro=True, descriptortypes='/home2/softwares/PaDEL/PaDEL-Descriptor/descriptors.xml')

java -jar -Xmx20G /home2/softwares/PaDEL/PaDEL-Descriptor/PaDEL-Descriptor.jar -2d -3d -retain3d -removesalt -standardizenitro -dir all_sdf_files_ob.sdf -file padel_all_desc_mmff94.csv -descriptortypes /home2/softwares/PaDEL/PaDEL-Descriptor/descriptors.xml -fingerprints
