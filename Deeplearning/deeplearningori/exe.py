#for clearness, give sigmoid function here
def sigmoid(z):
    return 1.0/(1.0+np.exp(-z))
#compute is to apply network we trained to a given picture of handwritten digit
def compute(img, net):
    img=np.array(img,dtype=np.float128)
    result=[sigmoid(np.dot(np.array(net.weights[0][x],dtype=np.float128),img)+np.array(net.biases[0][x],dtype=np.float128)) for x in range(0,net.sizes[1])]
    finalresult=np.ravel([np.dot(np.array(net.weights[1][x],dtype=np.float128),result)+np.array(net.biases[1][x],dtype=np.float128) for x in range(0,net.sizes[2])])
    print(list(np.ravel(np.where(finalresult==np.max(finalresult))))[0])

#read the picture into a array of 784
def readimg(index):
    import cv2
    import numpy as np
    img=cv2.imread(index,cv2.IMREAD_GRAYSCALE)
    img=cv2.resize(img,(28,28))
    #below are for show the gray-processed picture
        #cv2.imshow('gray',img)
        #cv2.waitKey(10)
    img=np.ravel(img)
    for i in range(0,len(img)):
        if img[i]<80:
            img[i]=1.0
        else:
            img[i]=0
    return img
    
#train the network, only need to do once
     
import sys
sys.path.append(index)
import mnist_loader
training_data, validation_data, test_data = mnist_loader.load_data_wrapper()
import network
net = network2.Network([784, 30, 10], cost=network2.CrossEntropyCost)
net.SGD(training_data,30,10,0.1,lmbda = 5.0,monitor_training_accuracy=True)
img=readimg('/Users/mayuheng/Desktop/1.png')
compute(img,net)



