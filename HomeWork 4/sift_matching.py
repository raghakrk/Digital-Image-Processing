#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Mar 16 23:57:44 2019

@author: raghakrk
"""
#from IPython import get_ipython
#ipython = get_ipython()
#ipython.magic("matplotlib auto")
import cv2
import numpy as np
import matplotlib.pyplot as plt

def readraw_rgb(file,ht,wd):
    A = np.fromfile(file, dtype='uint8', sep="")
    A = A.reshape([ht,wd,3])
    return A

path='/home/raghakrk/Desktop/DIP/HW4_Images/'
img1=readraw_rgb(path+'river1.raw',1024,768)
img2=readraw_rgb(path+'river2.raw',1024,768)

gray1= cv2.cvtColor(img1,cv2.COLOR_BGR2GRAY)
gray2= cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)

sift = cv2.xfeatures2d.SIFT_create()
kp1, des1 = sift.detectAndCompute(gray1,None)
kp2, des2 = sift.detectAndCompute(gray2,None)

l2norm1=np.linalg.norm(des1,axis=1)
#l2norm2=np.linalg.norm(des2,axis=1)
idx1=np.argmax(l2norm1)
#idx2=np.argmax(l2norm2)
        
pts1=np.zeros((len(kp1),2))
for idx in range(len(kp1)):
    pts1[idx,:]=np.array((kp1[idx].pt))

pts2=np.zeros((len(kp2),2))
for idx in range(len(kp2)):
    pts2[idx,:]=np.array((kp2[idx].pt))


x1m,y1m=pts1[idx1]
#x2m,y2m=pts2[idx2]

#imgo1=cv2.drawKeypoints(gray1,kp1,img1,flags=cv2.DRAW_MATCHES_FLAGS_DRAW_RICH_KEYPOINTS)

#fig = plt.figure(0)
#plt.imshow(imgo1,cmap='gray')
#plt.scatter(x1m,y1m,marker='*',s=200)

bf=cv2.BFMatcher()
matches=bf.match(des1,des2)

#l=np.zeros((len(matches),2))
#l1=list();l2=list();
#for m,n in matches:
#    l1.append(m.trainIdx)
#    l2.append(n.trainIdx)
#l[:,0]=np.asarray(l1)
#l[:,1]=np.asarray(l2)

matches = sorted(matches, key = lambda x:x.distance)

#ls=np.zeros((len(matches),2))
#l1=list();l2=list();
#for m,n in matches:
#    l1.append(m.trainIdx)
#    l2.append(n.trainIdx)
#ls[:,0]=np.asarray(l1)
#ls[:,1]=np.asarray(l2)

img3 = cv2.drawMatches(img1,kp1,img2,kp2,matches[:10],None, flags=2)
plt.imshow(img3)
plt.show()



