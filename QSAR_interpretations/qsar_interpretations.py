#!/usr/bin/env python

#!pip install shap
#!pip install lime
import os
import pandas as pd
import pickle as pkl
import matplotlib.pyplot as plt 
import numpy as np
import lime
import shap


##reading the files

with open("/home2/QSAR_check/prediction_results_padel/final_selected_cell_lines.txt") as f:
    content_list= f.readlines()
    content_list = [x.strip() for x in content_list]
    
    
for i in range(len(content_list)):
    line= content_list[i]
    print(line)
    df = pd.read_csv('/home2/QSAR_check/prediction_results_padel/F_stepping_outputs/f_step_outputs_drugs/f_step_'+ line + '.csv')
    #thisFilter = df.filter("''")
    #df = df.drop(thisFilter, axis=1)
    x= df.drop('IC50', axis=1)
    x= x.drop('Name', axis=1)
    y= df.IC50
    feature_names= x.columns.tolist()
    pkl_model= pkl.load(open('/home2/QSAR_check/prediction_results_padel/ML_model_files/svm_'+line+'.pkl', 'rb'))
    pkl_model.fit(x, y)
    #line explainer
    # Create object that can calculate shap values
    explainer = shap.KernelExplainer(pkl_model.predict, x, link="identity")
    # Calculate Shap values
    
    shap_values = explainer.shap_values(x)
    #shap.summary_plot(shap_values, x)
    #shap.dependence_plot(5, shap_values,x, feature_names=feature_names)
    #shap.decision_plot(explainer.expected_value, shap_values[0], feature_names=feature_names)
    fig= plt.figure()
    shap.summary_plot(shap_values, x, feature_names=feature_names, plot_type="bar", show=False)

    # Save the plot to a file (adjust filename and format as needed)
    plt.savefig("/home2/QSAR_check/QSAR_interpretation/summary_plots/shap_summary_plot_"+line+".tiff", dpi=300, bbox_inches='tight')  # Adjust dpi and bbox_inches for quality
    
    fig2 = plt.figure()
    shap.decision_plot(explainer.expected_value, shap_values[0], feature_names=feature_names, show=False)
    plt.savefig("/home2/QSAR_check/QSAR_interpretation/decision_plots/shap_decision_plot_"+line+".tiff", dpi=300, bbox_inches='tight')
