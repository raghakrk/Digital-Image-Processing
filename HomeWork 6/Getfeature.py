#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Apr 26 19:36:49 2019

@author: raghakrk
"""

import pickle
import numpy as np
import data
import saab
import keras
import sklearn
import glob
from scipy import misc

def main():
    	# load data
    fr=open('pca_params.pkl','rb')  
    pca_params=pickle.load(fr)
    fr.close()
    
    #	read data
    image1=misc.imread('1.png').reshape(32,32,1)
    image2=misc.imread('2.png').reshape(32,32,1)
    image3=misc.imread('3.png').reshape(32,32,1)
    image4=misc.imread('4.png').reshape(32,32,1)
    image1=image1/255.
    image2=image2/255.
    image3=image3/255.
    image4=image4/255.
    image=np.stack([image1,image2,image3,image4]);
    image=image.astype('float32')
    train_images=image;
    #	train_images, train_labels, test_images, test_labels, class_list = data.import_data("0-9")
    print('Training image size:', train_images.shape)
    #	print('Testing_image size:', test_images.shape)
    	
    	# Training
    print('--------Training--------')
    feature=saab.initialize(train_images, pca_params) 
    fs=feature.shape
    np.save('fs',fs)
    feature=feature.reshape(feature.shape[0],-1)
    print("S4 shape:", feature.shape)
    print('--------Finish Feature Extraction subnet--------')
    feat={}
    feat['feature']=feature
    	
    	# save data
    fw=open('feat.pkl','wb')    
    pickle.dump(feat, fw)    
    fw.close()

if __name__ == '__main__':
	main()
    