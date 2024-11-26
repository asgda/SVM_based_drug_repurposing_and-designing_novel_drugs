#!/usr/bin/env python
# coding: utf-8

# In[2]:


#install RDKit
#!pip install rdkit


# In[1]:


#importing RDKit libraries
from rdkit import Chem
from rdkit.Chem import AllChem
import sys


# In[13]:


#Running the code in loop
with open("pubchem_id_list.txt") as f:
    content_list= f.readlines()
    content_list = [x.strip() for x in content_list]

for i in range(len(content_list)):
    line= content_list[i]
    m = Chem.MolFromMolFile('sdf_files_2d/'+line + '.sdf')
    m2= Chem.AddHs(m)
    AllChem.EmbedMolecule(m2,randomSeed=0xf00d)
    
    ## saving the file
    file_path = line+'_3d'+'.sdf'
    sys.stdout = open(file_path, "w")
    print(Chem.MolToMolBlock(m2))


# In[ ]:




