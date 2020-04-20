#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Apr 26 21:30:42 2019

@author: raghakrk
"""


import pickle
import numpy as np
from scipy import misc
import matplotlib.pyplot as plt
import cv2 as cv

image1=misc.imread('1.png')/255.
image2=misc.imread('2.png')/255.
image3=misc.imread('3.png')/255.
image4=misc.imread('4.png')/255.
image=np.stack([image1,image2,image3,image4])
fr=open('feat.pkl','rb')
fp=open('pca_params.pkl','rb')
data1=pickle.load(fr)
pca_params=pickle.load(fp)
feat_new=data1['feature']
fs=np.load('fs.npy')
feat_new=feat_new.reshape(fs[0],fs[1],fs[2],fs[3])
transformed=feat_new.reshape(16,pca_params['Layer_1/kernel'].shape[0])
bias=pca_params['Layer_%d/bias'%1]
kernels=pca_params['Layer_%d/kernel'%1]
kernels0=pca_params['Layer_%d/kernel'%0]
e=np.zeros((1, kernels.shape[0]))

e[0,0]=1
transformed+=bias*e
sample_patches_centered_w_bias=np.matmul(transformed,np.linalg.pinv(np.transpose(kernels)))
sample_patches_centered=sample_patches_centered_w_bias-np.sqrt(kernels.shape[1])*bias
feature_expectation = pca_params['Layer_%d/feature_expectation'%1].astype(np.float32)
sample_patches = sample_patches_centered + feature_expectation
#(4,2,2,96)
sample_patches = sample_patches.reshape(4,fs[1],fs[2],pca_params['Layer_1/pca_mean'].shape[0])
#(4,2,2,1,1,4,4,6)
sample_patches=sample_patches.reshape(4,fs[1],fs[2],1,1,pca_params['kernel_size'][0],pca_params['kernel_size'][1],kernels0.shape[0])

img=list()
for i in range(2):
    l=np.dstack((sample_patches[:,i,0,0,0,:,:,:],sample_patches[:,i,1,0,0,:,:,:]))
    img.append(l)
sample_patches=np.hstack((img[0], img[1]))


transformed0=sample_patches.reshape(-1,kernels0.shape[0])
kernels0=pca_params['Layer_%d/kernel'%0]
sample_patches_centered0=np.matmul(transformed0,np.linalg.pinv(np.transpose(kernels0)))
feature_expectation0 = pca_params['Layer_%d/feature_expectation'%0].astype(np.float32)
sample_patches0 = sample_patches_centered0 + feature_expectation0
#4,8,8,16
sample_patches0 = sample_patches0.reshape(4,8,8,pca_params['Layer_0/pca_mean'].shape[0])
#4,8,8,1,1,4,4,1
sample_patches0=sample_patches0.reshape(4,8,8,1,1,pca_params['kernel_size'][0],pca_params['kernel_size'][1],1)

img=list()
for i in range(8):
    l = np.dstack((sample_patches0[:,i,0,0,0,:,:,0],sample_patches0[:,i,1,0,0,:,:,0],sample_patches0[:,i,2,0,0,:,:,0],sample_patches0[:,i,3,0,0,:,:,0],sample_patches0[:,i,4,0,0,:,:,0],sample_patches0[:,i,5,0,0,:,:,0],sample_patches0[:,i,6,0,0,:,:,0],sample_patches0[:,i,7,0,0,:,:,0]))
    img.append(l)
imgorg=np.hstack((img[0], img[1], img[2], img[3], img[4], img[5], img[6], img[7]))


conf='_9_15'

plt.imsave('1r'+conf+'.png',imgorg[0],cmap='gray')
plt.imsave('2r'+conf+'.png',imgorg[1],cmap='gray')
plt.imsave('3r'+conf+'.png',imgorg[2],cmap='gray')
plt.imsave('4r'+conf+'.png',imgorg[3],cmap='gray')

PSNR=np.zeros((4,1))
for p in range(4):
    Y=cv.normalize(imgorg[p], None, alpha=0, beta=1, norm_type=cv.NORM_MINMAX, dtype=cv.CV_32F)
    X=image[p]
    mse=0
    for i in range(32):
        for j in range(32):
            temp=pow((Y[i,j]-X[i,j]),2)
            mse=mse+temp
    
    mse=(1/(32*32))*mse
    PSNR[p]=10*np.log10(1/mse)




