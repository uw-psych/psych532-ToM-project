import math
import string

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn import metrics

fc = pd.read_csv('')

#make a new DataFrame??

fc_data = pd.DataFrame('')

train_data, test_and_validation_data = train_test_split(fc, test_size=0.2)
validation_data, test_data = train_test_split(test_and_validation_data, test_size=0.5)

logistic_model = LogisticRegression(penalty='l2', C=1e23) #C=1/Lambda
logistic_model.fit(train_data[], train_data[])

#coefficients
coefficients = logistic_model.coef_
weights = logistic_model.coef_property

#predict the probability of the target
logistic_model.predict_proba(validation_data[])

#predict labels
logistic_model.predict(validation_data[])

#find the validation accuracy
logistic_model_val_accuracy = accuracy_score(validation_data[], logistic_model.predict(validation_data[]))

# create a confusion matrix
def plot_confusion_matrix(tp, fp, fn, tn):
    """
    Plots a confusion matrix using the values 
       tp - True Positive
       fp - False Positive
       fn - False Negative
       tn - True Negative
    """
    data = np.matrix([[tp, fp], [fn, tn]])

    sns.heatmap(data,annot=True,xticklabels=['Actual Pos', 'Actual Neg']
              ,yticklabels=['Pred. Pos', 'Pred. Neg']) 

from sklearn.metrics import confusion_matrix
tp = confusion_matrix(validation_data[], logistic_model.predict(validation_data[]))[1,1]

# set up different regularization penalties to try
l2_penalties = [0.01, 1, 4, 10, 1e2, 1e3, 1e5]
for l2_penalty in l2_penalties:
    model = LogisticRegression(penalty='l2', C=1/l2_penalty)
    model.fit(train_data[], train_data[])



