#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Mar 30 12:46:04 2019

@author: raghakrk
"""

import os
from keras.models import Sequential
from keras.layers import Dense, Dropout, Flatten
from keras.layers import Conv2D, MaxPooling2D
from keras.utils import to_categorical
from keras.datasets import mnist
from keras.preprocessing.image import ImageDataGenerator
import matplotlib.pyplot as plt
from keras import optimizers
import keras
import numpy as np

(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train = x_train/255
x_test = x_test/255  
  
x_train = x_train.reshape(60000,28,28,1)
x_test = x_test.reshape(10000,28,28,1)
y_train = to_categorical(y_train)
y_test = to_categorical(y_test)

#setno=30
drop=0
lr=0.001
data_augmentation = False
batch_size=128   
epochs = 25


max_batches = 2 * len(x_train) / batch_size
save_dir = os.path.join(os.getcwd(), 'saved_models')
model_name = 'MNIST_trained_model__0.001_128.h5'

model = Sequential()
model.add(Conv2D(6,  kernel_size=(5,5), strides=1,padding='valid', activation='relu',input_shape=(28,28,1)))
model.add(MaxPooling2D(pool_size=(2, 2)))

model.add(Conv2D(16,  kernel_size=(5,5), strides=1,padding='valid',activation='relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))

model.add(Flatten())
model.add(Dense(120, activation='relu', kernel_initializer=keras.initializers.RandomNormal(mean=0, stddev=np.sqrt(2/256), seed=None),
                bias_initializer='zeros'))
model.add(Dropout(drop))
model.add(Dense(84, activation='relu',kernel_initializer=keras.initializers.RandomNormal(mean=0, stddev=np.sqrt(2/120), seed=None),
                bias_initializer='zeros'))
model.add(Dropout(drop))
model.add(Dense(10, activation='softmax',kernel_initializer=keras.initializers.RandomNormal(mean=0, stddev=np.sqrt(2/84), seed=None),
                bias_initializer='zeros'))

adam=optimizers.Adam(lr=lr, beta_1=0.9, beta_2=0.999, epsilon=None, decay=0.0, amsgrad=False)
sgd = optimizers.SGD(lr=0.01, momentum=0.0, decay=0.0, nesterov=True)
rms=optimizers.RMSprop(lr=0.001, rho=0.9, epsilon=None, decay=0.0)
adagrad=optimizers.Adagrad(lr=0.001, epsilon=None, decay=0.0)
adadelta=optimizers.Adadelta(lr=1.0, rho=0.95, epsilon=None, decay=0.0)

opt=adam
model.compile(optimizer=opt, loss='categorical_crossentropy', metrics=['accuracy'])

if not data_augmentation:
    print('Not using data augmentation.')
    hist=model.fit(x_train, y_train, epochs=epochs, shuffle=True,
                   batch_size=batch_size,validation_data=(x_test, y_test))
else:
    print('Using real-time data augmentation.')
    datagen = ImageDataGenerator(rotation_range=25, 
                               width_shift_range=0.08, 
                               shear_range=0.3, 
                               height_shift_range=0.08, 
                               zoom_range=0.08)
    x_trainn = np.array(x_train, copy=True) 
    y_trainn = np.array(y_train, copy=True) 
    datagen.fit(x_trainn)
    xtrain_set=np.concatenate((x_train, x_trainn), axis=0)
    ytrain_set=np.concatenate((y_train, y_trainn), axis=0)
    hist = model.fit_generator(datagen.flow(xtrain_set, ytrain_set,batch_size=batch_size),
                    steps_per_epoch=len(x_train) / batch_size, epochs = epochs, shuffle=True,
                    verbose=1,validation_data=(x_test, y_test))
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
#plt.savefig('set'+str(setno)+'.png')
if not os.path.isdir(save_dir):
    os.makedirs(save_dir)
model_path = os.path.join(save_dir, model_name)
model.save(model_path)
print('Saved trained model at %s ' % model_path)