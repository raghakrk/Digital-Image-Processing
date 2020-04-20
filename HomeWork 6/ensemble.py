#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Apr 28 18:48:18 2019

@author: raghakrk
"""

import data
import pickle
import numpy as np
from sklearn import svm
from sklearn.decomposition import PCA


def loadfeature(feat):
    fr=open(feat,'rb')
    feat=pickle.load(fr,encoding='latin1')
    fr.close()
    return feat

train_images, train_labels, test_images, test_labels, class_list = data.import_data("0-9")
ensem=loadfeature('llsr1.pkl')
ensem=np.append(ensem,loadfeature('llsr_2.pkl'),axis=1)
ensem=np.append(ensem,loadfeature('llsr3.pkl'),axis=1)
ensem=np.append(ensem,loadfeature('llsr4.pkl'),axis=1)
ensem=np.append(ensem,loadfeature('llsr5.pkl'),axis=1)
ensem=np.append(ensem,loadfeature('llsr6.pkl'),axis=1)
ensem=np.append(ensem,loadfeature('llsr7.pkl'),axis=1)
ensem=np.append(ensem,loadfeature('llsr8.pkl'),axis=1)
ensem=np.append(ensem,loadfeature('llsr9.pkl'),axis=1)
ensem=np.append(ensem,loadfeature('llsr10.pkl'),axis=1)

pca=PCA(n_components=10)
X=pca.fit_transform(ensem)

Y=svm.SVC(gamma='scale')
Y.fit(X,train_labels)
train_score=Y.score(X,train_labels)
print('Training accuracy')
print(train_score)

ensem_test=loadfeature('model1.pkl')
ensem_test=np.append(ensem,loadfeature('model2.pkl'),axis=1)
ensem_test=np.append(ensem,loadfeature('model3.pkl'),axis=1)
ensem_test=np.append(ensem,loadfeature('model4.pkl'),axis=1)
ensem_test=np.append(ensem,loadfeature('model5.pkl'),axis=1)
ensem_test=np.append(ensem,loadfeature('model6.pkl'),axis=1)
ensem_test=np.append(ensem,loadfeature('model7.pkl'),axis=1)
ensem_test=np.append(ensem,loadfeature('model8.pkl'),axis=1)
ensem_test=np.append(ensem,loadfeature('model9.pkl'),axis=1)
ensem_test=np.append(ensem,loadfeature('model10.pkl'),axis=1)


X_test=pca.fit(ensem_test)
test_score=Y.score(X_test,test_labels)
print('Testing accuracy')
print(test_score)



