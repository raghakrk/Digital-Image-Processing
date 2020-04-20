#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Apr  6 01:09:14 2019

@author: raghakrk
"""

import os
import cv2
from keras.models import Sequential
from keras.layers import Dense, Dropout, Flatten
from keras.layers import Conv2D, MaxPooling2D
from keras.utils import to_categorical
from keras.datasets import mnist
from keras.preprocessing.image import ImageDataGenerator
import matplotlib.pyplot as plt
from keras import optimizers
import keras
import h5py
import numpy as np
from sklearn.metrics import confusion_matrix

def create_model():
    model = Sequential()
    model.add(Conv2D(6,  kernel_size=(5,5), strides=1,padding='valid', activation='relu',input_shape=(28,28,1)))
    model.add(MaxPooling2D(pool_size=(2, 2)))
    
    model.add(Conv2D(16,  kernel_size=(5,5), strides=1,padding='valid',activation='relu'))
    model.add(MaxPooling2D(pool_size=(2, 2)))
    
    model.add(Flatten())
    model.add(Dense(120, activation='relu', kernel_initializer=keras.initializers.RandomNormal(mean=0, stddev=np.sqrt(2/256), seed=None),
                    bias_initializer='zeros'))
    model.add(Dense(84, activation='relu',kernel_initializer=keras.initializers.RandomNormal(mean=0, stddev=np.sqrt(2/120), seed=None),
                    bias_initializer='zeros'))
    model.add(Dense(10, activation='softmax',kernel_initializer=keras.initializers.RandomNormal(mean=0, stddev=np.sqrt(2/84), seed=None),
                    bias_initializer='zeros'))
    return model


(xp_train, yp_train), (xp_test, yp_test) = mnist.load_data()
xp_train = xp_train/255 
xp_test = xp_test/255 

xn_train=1-xp_train
xn_test=1-xp_test

x_train=np.concatenate((xp_train,xn_train),axis=0)
x_test=np.concatenate((xp_test,xn_test),axis=0)

y_train=np.concatenate((yp_train,yp_train),axis=0)
y_test=np.concatenate((yp_test,yp_test),axis=0)

x_train = x_train.reshape(120000,28,28,1)
x_test = x_test.reshape(20000,28,28,1)
y_train = to_categorical(y_train)
y_test = to_categorical(y_test)
# old model
model_old = create_model()
model_old.load_weights('saved_models/MNIST_trained_model__0.001_128.h5')
adam=optimizers.Adam(lr=0.001, beta_1=0.9, beta_2=0.999, epsilon=None, decay=0.0, amsgrad=False)
model_old.compile(optimizer=adam, loss='categorical_crossentropy', metrics=['accuracy'])
score = model_old.evaluate(xn_test.reshape(10000,28,28,1), to_categorical(yp_test), verbose=0)
print('Test loss:', score[0])
print('Test accuracy:', score[1])
#predictions = model_old.predict(x_test)
#matrix = confusion_matrix(y_test.argmax(axis=1), predictions.argmax(axis=1))
### training new

batch_size=128
epochs = 25
lr=0.001
model=create_model();
adam=optimizers.Adam(lr=lr, beta_1=0.9, beta_2=0.999, epsilon=None, decay=0.0, amsgrad=False)
model.compile(optimizer=adam, loss='categorical_crossentropy', metrics=['accuracy'])
hist=model.fit(x_train, y_train, epochs=epochs, shuffle=True,
                   batch_size=batch_size,validation_data=(x_test, y_test))
score = model.evaluate(x_test, y_test, verbose=0)
print('Test loss:', score[0])
print('Test accuracy:', score[1])

plt.plot(hist.history['acc'])
plt.plot(hist.history['val_acc'])
plt.title('model accuracy')
plt.ylabel('accuracy')
plt.xlabel('epoch')
plt.legend(['train', 'test'], loc='upper left')
plt.show()
plt.savefig('set1c.png')

save_dir = os.path.join(os.getcwd(), 'saved_models')
model_name = 'MNIST_trained_neg+pos_model.h5'
if not os.path.isdir(save_dir):
    os.makedirs(save_dir)
model_path = os.path.join(save_dir, model_name)
model.save(model_path)
print('Saved trained model at %s ' % model_path)