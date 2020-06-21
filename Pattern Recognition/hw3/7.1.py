#path=r"C:\Users\sdswshuizhike\Desktop\libsvm\python"
#sys.path.append(path)
#from svm import *
#y,x=svm_read_problem(r'\a1a')
y,x=svm_read_problem(r'C:\Users\sdswshuizhike\Desktop\libsvm\python\svmguide1')
m=svm_train(y,x,'-c 1 -t 2')
yt,xt=svm_read_problem(r'C:\Users\sdswshuizhike\Desktop\libsvm\python\svmguide1t')
p_label,p_acc,p_val=svm_predict(yt,xt,m)
#Accuracy = 66.925% (2677/4000) (classification)
####################
#cd the folder
#os.system("svm_scale filename")
m=svm_train(y,x,'-c 1 -t 0')
p_label,p_acc,p_val=svm_predict(yt,xt,m)
#Accuracy = 95.675% (3827/4000) (classification)
####################
m=svm_train(y,x,'-c 1 -t 1')
p_label,p_acc,p_val=svm_predict(yt,xt,m)
#Accuracy = 87.7% (3508/4000) (classification)