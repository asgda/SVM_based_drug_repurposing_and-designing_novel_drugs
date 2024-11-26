#!/usr/bin/env python

#SBATCH -N 2
#SBATCH --ntasks-per-node=20
#SBATCH --time=48:00:00
#SBATCH --job-name=qsar
#SBATCH --error=job.%J.err_node_20
#SBATCH --output=job.%J.out_node_20
#SBATCH --partition=cpu

## import libraries ##
import pandas as pd
from sklearn import metrics
import pandas as pd
from sklearn.neural_network import MLPClassifier
from sklearn.neural_network import MLPRegressor
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import RandomForestRegressor
from sklearn.linear_model import LogisticRegression
from sklearn.svm import SVR
from sklearn.linear_model import Lasso
from sklearn.model_selection import train_test_split
import math
from scipy.stats import pearsonr
import matplotlib.pyplot as plt
import seaborn as sns
plt.style.use('ggplot')
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import KFold
from sklearn.model_selection import cross_val_predict
from sklearn.model_selection import cross_val_score
import sys
from sklearn.preprocessing import StandardScaler
from scipy.stats import loguniform
from pandas import read_csv
from sklearn.linear_model import Ridge
from sklearn.model_selection import RepeatedKFold
from sklearn.model_selection import RandomizedSearchCV
from scipy.stats import randint as sp_randint
import random
from mlxtend.feature_selection import SequentialFeatureSelector as sfs
import joblib
from statistics import mean
import pickle as pkl

##make a list of the cell lines##
with open("cell_line_names_1.txt") as f:
    content_list= f.readlines()
    content_list = [x.strip() for x in content_list]
#content_list= [x.replace('"', '') for x in content_list]

##for loop in machine learning code

for i in range(len(content_list)):
    line= content_list[i]
    df = pd.read_csv('/scratch/avik.bio.iith/weka_output_padel_filtered_mmff94/weka_out_padel_filtered_mmff94_'+ line + '.csv')
    #thisFilter = df.filter("''")
    #df = df.drop(thisFilter, axis=1)
    x= df.drop('IC50', axis=1)
    y= df.IC50

    #train test split
    x_train, x_test, y_train, y_test= train_test_split(x, y, test_size=0.2, random_state=42)
    
    sc= StandardScaler()
    x_train_sc= sc.fit_transform(x_train)
    x_test_sc= sc.transform(x_test)

    ## Model selection ##
    #mlp_rdm= MLPRegressor(random_state=42)
    svm_rdm= SVR()
    
    ## Random Search CV ##
    space = dict()
    space['kernel'] = ['linear', 'poly', 'rbf', 'sigmoid']
    space['C'] = loguniform(1e-5, 100)
    space['epsilon'] = loguniform(1e-5, 10)
    space['gamma'] = ['scale', 'auto']
    # define search
    cv= KFold(n_splits=10, random_state=42, shuffle=True)
    search = RandomizedSearchCV(svm_rdm, space, n_iter=500, scoring='r2', n_jobs=-1, cv=cv, random_state=42)
    # execute search
    result_svm = search.fit(x_train_sc, y_train)
    # summarize result
    print('Best Score SVM: %s' % result_svm.best_score_)
    print('Best Hyperparameters SVM: %s' % result_svm.best_params_)
    
    # parameter_space = {
    #'hidden_layer_sizes': [(list(range(100,500)), list(range(0,500)), list(range(0,500)))],
    #'activation': ['tanh', 'relu', 'logistic'],
    #'solver': ['sgd', 'adam', 'lbfgs'],
    #'alpha': loguniform(0.0001, 0.9),
    #'learning_rate': ['constant','adaptive'],
    #'max_iter': list(range(500, 2001))}
 
    # # define search
    #search1 = RandomizedSearchCV(mlp_rdm, parameter_space, n_iter=500, scoring='r2', n_jobs=-1, cv=cv, random_state=42)

    #result_mlp = search1.fit(x_train_sc, y_train)

    # # summarize result
    #print('Best Score MLP: %s' % result_mlp.best_score_)
    #print('Best Hyperparameters MLP: %s' % result_mlp.best_params_)
    
    ## Model ##
    svm= SVR(**result_svm.best_params_)
    #mlp_r= MLPRegressor(**result_svm.best_params_)
    
    ## Model fitting ##
    #mlp_r.fit(x_train_sc, y_train)
    svm.fit(x_train_sc, y_train)
    
    ## Determining y_pred (train dataset)
    y_actual_train= y_train
    cv= KFold(n_splits=10, random_state=1, shuffle=True)
    #y_pred_train_mlp=cross_val_predict(mlp_r, x_train_sc, y_train, cv=cv, n_jobs=-1)
    #y_pred_train_rf= cross_val_predict(rf, x_train, y_train, cv=cv, n_jobs=-1)
    #y_pred_train_lin= cross_val_predict(lin_reg, x_train, y_train, cv=cv, n_jobs=-1)
    #y_pred_train_log= cross_val_predict(log_reg, x_train, y_train, cv=cv, n_jobs=-1)
    y_pred_train_svm= cross_val_predict(svm, x_train_sc, y_train, cv=cv, n_jobs=-1)
    #y_pred_train_l= cross_val_predict(l_reg, x_train, y_train, cv=cv, n_jobs=-1)
    ## Metrics for train dataset
    #r2
    #r2_mlp= metrics.r2_score(y_actual_train, y_pred_train_mlp)
    #r2_rf= metrics.r2_score(y_actual_train, y_pred_train_rf)
    #r2_lin= metrics.r2_score(y_actual_train, y_pred_train_lin)
    #r2_log= metrics.r2_score(y_actual_train, y_pred_train_log)
    r2_svm= metrics.r2_score(y_actual_train, y_pred_train_svm)
    #r2_l= metrics.r2_score(y_actual_train, y_pred_train_l)
    #r
    #r_mlp,_= pearsonr(y_actual_train, y_pred_train_mlp)
    #r_rf,_= pearsonr(y_actual_train, y_pred_train_rf)
    #r_lin,_= pearsonr(y_actual_train, y_pred_train_lin)
    #r_log,_= pearsonr(y_actual_train, y_pred_train_log)
    r_svm,_= pearsonr(y_actual_train, y_pred_train_svm)
    #r_l,_= pearsonr(y_actual_train, y_pred_train_l)
    #mse
    #mse_mlp= metrics.mean_squared_error(y_actual_train, y_pred_train_mlp)
    #mse_rf= metrics.mean_squared_error(y_actual_train, y_pred_train_rf)
    #mse_lin= metrics.mean_squared_error(y_actual_train, y_pred_train_lin)
    #mse_log= metrics.mean_squared_error(y_actual_train, y_pred_train_log)
    mse_svm= metrics.mean_squared_error(y_actual_train, y_pred_train_svm)
    #mse_l= metrics.mean_squared_error(y_actual_train, y_pred_train_l)
    #rmse
    #rmse_mlp= math.sqrt(metrics.mean_squared_error(y_actual_train, y_pred_train_mlp))
    #rmse_rf= math.sqrt(metrics.mean_squared_error(y_actual_train, y_pred_train_rf))
    #rmse_lin= math.sqrt(metrics.mean_squared_error(y_actual_train, y_pred_train_lin))
    #rmse_log= math.sqrt(metrics.mean_squared_error(y_actual_train, y_pred_train_log))
    rmse_svm= math.sqrt(metrics.mean_squared_error(y_actual_train, y_pred_train_svm))
    #rmse_l= math.sqrt(metrics.mean_squared_error(y_actual_train, y_pred_train_l))
    #mae
    #mae_mlp= metrics.mean_absolute_error(y_actual_train, y_pred_train_mlp)
    #mae_rf= metrics.mean_absolute_error(y_actual_train, y_pred_train_rf)
    #mae_lin= metrics.mean_absolute_error(y_actual_train, y_pred_train_lin)
    #mae_log= metrics.mean_absolute_error(y_actual_train, y_pred_train_log)
    mae_svm= metrics.mean_absolute_error(y_actual_train, y_pred_train_svm)
    #mae_l= metrics.mean_absolute_error(y_actual_train, y_pred_train_l)
    
    ## Determining y_pred (test dataset)##
    y_actual_test= y_test
    #y_pred_test_mlp= mlp_r.predict(x_test_sc)
    #y_pred_test_rf= rf.predict(x_test)
    #y_pred_test_lin= y_pred_test= lin_reg.predict(x_test)
    #y_pred_test_log= log_reg.predict(x_test)
    y_pred_test_svm= svm.predict(x_test_sc)
    #y_pred_test_l= l_reg.predict(x_test)

    ## metrics for test dataset ##
    ##r2
    #r2_mlp_ts= metrics.r2_score(y_actual_test, y_pred_test_mlp)
    #r2_rf_ts= metrics.r2_score(y_actual_test, y_pred_test_rf)
    #r2_lin_ts= metrics.r2_score(y_actual_test, y_pred_test_lin)
    #r2_log_ts= metrics.r2_score(y_actual_test, y_pred_test_log)
    r2_svm_ts= metrics.r2_score(y_actual_test, y_pred_test_svm)
    #r2_l_ts= metrics.r2_score(y_actual_test, y_pred_test_l)
    #r
    #r_mlp_ts,_= pearsonr(y_actual_test, y_pred_test_mlp)
    #r_rf_ts,_= pearsonr(y_actual_test, y_pred_test_rf)
    #r_lin_ts,_= pearsonr(y_actual_test, y_pred_test_lin)
    #r_log_ts,_= pearsonr(y_actual_test, y_pred_test_log)
    r_svm_ts,_= pearsonr(y_actual_test, y_pred_test_svm)
    #r_l_ts,_= pearsonr(y_actual_test, y_pred_test_l)
    #mse
    #mse_mlp_ts= metrics.mean_squared_error(y_actual_test, y_pred_test_mlp)
    #mse_rf_ts= metrics.mean_squared_error(y_actual_test, y_pred_test_rf)
    #mse_lin_ts= metrics.mean_squared_error(y_actual_test, y_pred_test_lin)
    #mse_log_ts= metrics.mean_squared_error(y_actual_test, y_pred_test_log)
    mse_svm_ts= metrics.mean_squared_error(y_actual_test, y_pred_test_svm)
    #mse_l_ts= metrics.mean_squared_error(y_actual_test, y_pred_test_l)
    #rmse
    #rmse_mlp_ts= math.sqrt(metrics.mean_squared_error(y_actual_test, y_pred_test_mlp))
    #rmse_rf_ts= math.sqrt(metrics.mean_squared_error(y_actual_test, y_pred_test_rf))
    #rmse_lin_ts= math.sqrt(metrics.mean_squared_error(y_actual_test, y_pred_test_lin))
    #rmse_log_ts= math.sqrt(metrics.mean_squared_error(y_actual_test, y_pred_test_log))
    rmse_svm_ts= math.sqrt(metrics.mean_squared_error(y_actual_test, y_pred_test_svm))
    #rmse_l_ts= math.sqrt(metrics.mean_squared_error(y_actual_test, y_pred_test_l))
    #mae
    #mae_mlp_ts= metrics.mean_absolute_error(y_actual_test, y_pred_test_mlp)
    #mae_rf_ts= metrics.mean_absolute_error(y_actual_test, y_pred_test_rf)
    #mae_lin_ts= metrics.mean_absolute_error(y_actual_test, y_pred_test_lin)
    #mae_log_ts= metrics.mean_absolute_error(y_actual_test, y_pred_test_log)
    mae_svm_ts= metrics.mean_absolute_error(y_actual_test, y_pred_test_svm)
    #mae_l_ts= metrics.mean_absolute_error(y_actual_test, y_pred_test_l)

    ## F-stepping ##
    sfsl_svm = sfs(svm,k_features="best",forward=False,floating=False,verbose=0,scoring='r2',cv=cv,n_jobs=-1)
    sfsl_svm.fit(x_train_sc, y_train)
    feat_cols_svm = list(sfsl_svm.k_feature_idx_)
    feat_col_names= list(sfsl_svm.k_feature_names_)
    svm.fit(x_train_sc[:,feat_cols_svm], y_train)
    y_actual_train=y_train
    cv= KFold(n_splits=10, random_state=42, shuffle=True)
    y_pred_train_svm_f= cross_val_predict(svm, x_train_sc[:,feat_cols_svm], y_train, cv=cv, n_jobs=-1)
    b=df.iloc[:, (feat_cols_svm)]
    c= pd.concat([b,y],axis=1)
    c.to_csv('/scratch/avik.bio.iith/prediction_models/f_stepping_outputs_final/'+line+'.csv', index=False)
    r2_svm_f= metrics.r2_score(y_actual_train, y_pred_train_svm_f)
    r_svm_f,_= pearsonr(y_actual_train, y_pred_train_svm_f)
    mse_svm_f= metrics.mean_squared_error(y_actual_train, y_pred_train_svm_f)
    rmse_svm_f= math.sqrt(metrics.mean_squared_error(y_actual_train, y_pred_train_svm_f))
    mae_svm_f= metrics.mean_absolute_error(y_actual_train, y_pred_train_svm_f)
    y_pred_test_svm_f= svm.predict(x_test_sc[:,feat_cols_svm])
    r2_svm_ts_f= metrics.r2_score(y_actual_test, y_pred_test_svm_f)
    r_svm_ts_f,_= pearsonr(y_actual_test, y_pred_test_svm_f)
    mse_svm_ts_f= metrics.mean_squared_error(y_actual_test, y_pred_test_svm_f)
    rmse_svm_ts_f= math.sqrt(metrics.mean_squared_error(y_actual_test, y_pred_test_svm_f))
    mae_svm_ts_f= metrics.mean_absolute_error(y_actual_test, y_pred_test_svm_f)
    
    ##actual vs predicted graphs
    fig, ax = plt.subplots()
    ax.scatter(y_actual_train, y_pred_train_svm_f, edgecolors=(0, 0, 0))
    ax.plot([y.min(), y.max()], [y.min(), y.max()], 'k--', lw=2)
    ax.set_xlabel('Actual logIC50')
    ax.set_ylabel('Predicted logIC50')
    plt.title(line+'_logIC50')
    #ax.set_title('R2: ' + str(r2_svm_f))
    ax.annotate("R2 = {:.3f}".format(r2_svm_f), (0,4))
    #plt.show()
    plt.savefig('actual_vs_predicted_graphs/'+line+'_train_final.jpg')
#########saving training and testing output in model_output.txt file########

    file_path = 'model_output_padel_filtered_1_'+line+ '.csv'
    sys.stdout = open(file_path, "w")
    print("##############################")
    print("#### PADEL FINAL OUTPUT ####")
    print("##############################")
    print(" ")
    print(" ")
    print(" ")
    print("Total Padel descriptors:18066")
    print("Final Descriptors:%3d" %len(x.columns))
    print("Cell Line:%3s" %line)
    print(' ')
    print(' ')
    print(' ')
    print('Best Hyperparameters SVM: %s' % result_svm.best_params_)
    print(' ')
    #print('Best Hyperparameters MLP: %s' % result_mlp.best_params_)
    print(' ')
    print(' ')
    print(' ')
    print('TRAINING RESULTS :')
    print(' ')
    print("Models\t\tR2\t\tR\t\tMSE\t\tRMSE\t\tMAE")
    #print("MLP\t\t{0:.3f}\t\t{1:.3f}\t\t{2:.3f}\t\t{3:.3f}\t\t{4:0.3f}".format(r2_mlp, r_mlp, mse_mlp, rmse_mlp, mae_mlp))
    #print("RF\t\t{0:.3f}\t\t{1:.3f}\t\t{2:.3f}\t\t{3:.3f}\t\t{4:0.3f}".format(r2_rf, r_rf, mse_rf, rmse_rf, mae_rf))
    #print("LR\t\t{0:.3f}\t\t{1:.3f}\t\t{2:.3f}\t\t{3:.3f}\t\t{4:0.3f}".format(r2_lin, r_lin, mse_lin, rmse_lin, mae_lin))
    #print("Log Reg\t\t{0:.3f}\t\t{1:.3f}\t\t{2:.3f}\t\t{3:.3f}".format(r2_log, r_log, mse_log, rmse_log, mae_log))
    print("SVM\t\t{0:.3f}\t\t{1:.3f}\t\t{2:.3f}\t\t{3:.3f}\t\t{4:0.3f}".format(r2_svm, r_svm, mse_svm, rmse_svm, mae_svm))
    #print("Lasso\t\t{0:.3f}\t\t{1:.3f}\t\t{2:.3f}\t\t{3:.3f}\t\t{4:0.3f}".format(r2_l, r_l, mse_l, rmse_l, mae_l))

    print(' ')
    print(' ')
    print('TEST RESULTS :')
    print(' ')
    print("Models\t\tR2\t\tR\t\tMSE\t\tRMSE\t\tMAE")
    #print("MLP\t\t{0:.3f}\t\t{1:.3f}\t\t{2:.3f}\t\t{3:.3f}\t\t{4:0.3f}".format(r2_mlp_ts, r_mlp_ts, mse_mlp_ts, rmse_mlp_ts, mae_mlp_ts))
    #print("RF\t\t{0:.3f}\t\t{1:.3f}\t\t{2:.3f}\t\t{3:.3f}\t\t{4:0.3f}".format(r2_rf_ts, r_rf_ts, mse_rf_ts, rmse_rf_ts, mae_rf_ts))
    #print("LR\t\t{0:.3f}\t\t{1:.3f}\t\t{2:.3f}\t\t{3:.3f}\t\t{4:0.3f}".format(r2_lin_ts, r_lin_ts, mse_lin_ts, rmse_lin_ts, mae_lin_ts))
    #print("Log Reg\t\t{0:.3f}\t\t{1:.3f}\t\t{2:.3f}\t\t{3:.3f}".format(r2_log_ts, r_log_ts, mse_log_ts, rmse_log_ts, mae_log_ts))
    print("SVM\t\t{0:.3f}\t\t{1:.3f}\t\t{2:.3f}\t\t{3:.3f}\t\t{4:0.3f}".format(r2_svm_ts, r_svm_ts, mse_svm_ts, rmse_svm_ts, mae_svm_ts))
    #print("Lasso\t\t{0:.3f}\t\t{1:.3f}\t\t{2:.3f}\t\t{3:.3f}\t\t{4:0.3f}".format(r2_l_ts, r_l_ts, mse_l_ts, rmse_l_ts, mae_l_ts))
    print('####################################################')
    print("CREDITS TO KAVITA KUNDAL")
    print(' ')
    print(' ')
    print('F-stepping')
    print('')
    print('Selected Feature indices svm::',feat_cols_svm)
    print('Selected Feature Numbers svm::',len(feat_cols_svm))
    print('F-stepping performances')
    print('TRAINING RESULTS :')
    print(' ')
    print("Models\t\tR2\t\tR\t\tMSE\t\tRMSE\t\tMAE")
    #print("MLP\t\t{0:.3f}\t\t{1:.3f}\t\t{2:.3f}\t\t{3:.3f}\t\t{4:0.3f}".format(r2_mlp, r_mlp, mse_mlp, rmse_mlp, mae_mlp))
    print("SVM\t\t{0:.3f}\t\t{1:.3f}\t\t{2:.3f}\t\t{3:.3f}\t\t{4:0.3f}".format(r2_svm_f, r_svm_f, mse_svm_f, rmse_svm_f, mae_svm_f))
    print('TEST RESULTS :')
    print(' ')
    print("Models\t\tR2\t\tR\t\tMSE\t\tRMSE\t\tMAE")
    #print("MLP\t\t{0:.3f}\t\t{1:.3f}\t\t{2:.3f}\t\t{3:.3f}\t\t{4:0.3f}".format(r2_mlp_ts, r_mlp_ts, mse_mlp_ts, rmse_mlp_ts, mae_mlp_ts))
    print("SVM\t\t{0:.3f}\t\t{1:.3f}\t\t{2:.3f}\t\t{3:.3f}\t\t{4:0.3f}".format(r2_svm_ts_f, r_svm_ts_f, mse_svm_ts_f, rmse_svm_ts_f, mae_svm_ts_f))
