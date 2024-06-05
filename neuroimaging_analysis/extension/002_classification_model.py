# ---
# jupyter:
#   jupytext:
#     formats: ipynb,py:light
#     text_representation:
#       extension: .py
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.16.1
#   kernelspec:
#     display_name: Python [conda env:mriqc-learn-2]
#     language: python
#     name: conda-env-mriqc-learn-2-py
# ---

# +
import math
import string

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

from sklearn.metrics import accuracy_score
from sklearn.metrics import roc_curve

from sklearn.linear_model import LogisticRegression, LogisticRegressionCV
from sklearn.model_selection import KFold
from sklearn.preprocessing import StandardScaler
from sklearn.utils import resample

import argparse
import random
import os
import pickle

# +
args = argparse.Namespace(verbose=False, verbose_1=False)
parser = argparse.ArgumentParser("002_classification_model.py")
parser.add_argument('--seed', default='random.random()')
parser.add_argument('--prediction_target', default='Gender')

#hack argparse to be jupyter friendly AND cmdline compatible
try: 
    os.environ['_']
    args = parser.parse_args()
except KeyError: 
    args = parser.parse_args([])

seed_val = eval(args.seed)
target = args.prediction_target
random.seed(seed_val) 
# -

n_splits = 5 #we could change this if we wanted

fc_df = pd.read_csv('fc_vals.csv').drop('Unnamed: 0', axis=1).T
#a relative path is easier when collaborating

participants_df = pd.read_csv('participants.tsv', sep = '\t', 
                              index_col='participant_id')

if target == 'Gender': 
    participants_df.loc[participants_df['Gender'] == 'M'] = 0
    participants_df.loc[participants_df['Gender'] == 'F'] = 1

fc_df = fc_df.join(participants_df[target])  
#do the bootstrap! 
fc_df = resample(fc_df, replace=True) 

kfolds = KFold(
        n_splits=5,
        shuffle=True)

coef_dict = {} 
acc_scores = [] 
acc_dict = {} 
for fold_idx, (train_idx, test_idx) in enumerate( kfolds.split(X=fc_df) ):
    acc_dict[fold_idx] = {} 
    
    train_df = fc_df.iloc[train_idx, :]
    test_df = fc_df.iloc[test_idx, :]

    x_train = train_df.drop(target, axis=1)
    y_train = train_df[target].astype(int)

    x_test = test_df.drop(target, axis=1) 
    y_test = test_df[target].astype(int)
    
    scaler = StandardScaler()
    #scale seperately - MH needs to fix in her own code
    scaler.fit_transform(x_train)
    scaler.fit_transform(x_test)

    logistic_model = LogisticRegressionCV(penalty='l2') #C=1/Lambda
    logistic_model.fit(x_train, y_train)

    #coefficients
    coef_dict[fold_idx] = logistic_model.coef_[0]
    acc_dict[fold_idx]['predicted'] = logistic_model.predict(x_test)
    acc_dict[fold_idx]['actual'] = y_test.values

    #calc accuracy
    acc_scores.append(accuracy_score(logistic_model.predict(x_test), y_test))


# +
with open(f'results/{target}_{seed_val}_coefs.pkl', 'wb') as f:
    b = pickle.dump(coef_dict, f)

with open(f'results/{target}_{seed_val}_acc.pkl', 'wb') as f:
    b = pickle.dump(acc_dict, f)

with open(f'results/{target}_{seed_val}_accuracies.csv','w') as file:
        file.write(str(np.mean(acc_scores)))
