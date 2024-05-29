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
from sklearn.linear_model import LogisticRegression, LogisticRegressionCV
from sklearn.model_selection import KFold
from sklearn.preprocessing import StandardScaler
# -

from sklearn.metrics import roc_curve

pred_target = 'Gender' 
n_splits = 5

fc_df = pd.read_csv('fc_vals.csv').drop('Unnamed: 0', axis=1).T
#a relative path is easier when collaborating

participants_df = pd.read_csv('participants.tsv', sep = '\t', 
                              index_col='participant_id')

if pred_target == 'Gender': 
    participants_df.loc[participants_df['Gender'] == 'M'] = 0
    participants_df.loc[participants_df['Gender'] == 'F'] = 1

fc_df = fc_df.join(participants_df[pred_target])  

from sklearn.utils import resample
fc_df = resample(fc_df, replace=True) 

kfolds = KFold(
        n_splits=5,
        shuffle=True)

acc_scores = [] 
for fold_idx, (train_idx, test_idx) in enumerate( kfolds.split(X=fc_df) ):
    train_df = fc_df.iloc[train_idx, :]
    test_df = fc_df.iloc[test_idx, :]

    x_train = train_df.drop(pred_target, axis=1)
    y_train = train_df[pred_target].astype(int)

    x_test = test_df.drop(pred_target, axis=1) 
    y_test = test_df[pred_target].astype(int)
    
    scaler = StandardScaler()
    #scale seperately - MH needs to fix in her own code
    scaler.fit_transform(x_train)
    scaler.fit_transform(x_test)

    logistic_model = LogisticRegressionCV(penalty='l2') #C=1/Lambda
    logistic_model.fit(x_train, y_train)

    #coefficients
    coefficients = logistic_model.coef_
    print('Smallest coefficient', coefficients.min())
    print('Largest coefficient:', coefficients.max())

    #calc accuracy
    acc_scores.append(accuracy_score(logistic_model.predict(x_test), y_test))
print(np.mean(acc_scores))  

# +
#add roc curve? 
# -

roc_curve(logistic_model.predict(x_test), y_test)

acc_scores


# +
# create a confusion matrix
import time

def plot_confusion_matrix(tp, fp, fn, tn):
    """
    Plots a confusion matrix using the values 
       tp - True Positive
       fp - False Positive
       fn - False Negative
       tn - True Negative
    """
    data = np.matrix([[tp, fp], [fn, tn]])

    heatmap = sns.heatmap(data,annot=True,xticklabels=['Actual Pos', 'Actual Neg']
              ,yticklabels=['Pred. Pos', 'Pred. Neg']) 
    
    fig = heatmap.get_figure()
    timestamp = time.strftime("%H%M%S")
    fig.savefig(f"confusion_matrix_{timestamp}.png")

from sklearn.metrics import confusion_matrix
tp = confusion_matrix(y_test, logistic_model.predict(x_test))[1,1]
fp = confusion_matrix(y_test, logistic_model.predict(x_test))[0,1]
tn = confusion_matrix(y_test, logistic_model.predict(x_test))[0,0]
fn = confusion_matrix(y_test, logistic_model.predict(x_test))[1,0]
# -

plot_confusion_matrix(tp=tp, fp=fp, tn=tn, fn=fn)

import csv

filename = "acc_scores.csv"

with open(filename, 'a', newline = '') as csvfile:
    writer = csv.writer(csvfile)
    
    writer.writerow([np.mean(acc_scores), coefficients.max(), coefficients.min()])

print("scores saved to", filename)




