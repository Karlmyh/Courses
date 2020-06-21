from svmutil import *
 
y, x = svm_read_problem('dataset/a1a.txt')
yt, xt = svm_read_problem('dataset/a1at.txt')
model = svm_train(y, x)
 
p_label, p_acc, p_val = svm_predict(yt[0:117], xt[0:117], model)

