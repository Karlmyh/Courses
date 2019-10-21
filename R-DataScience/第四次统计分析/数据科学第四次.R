setwd("/Users/mayuheng/Desktop")
data<-read.csv("lm.csv")
lm.reg<-lm(TC~Q+PL+PF+PK,data = data)
output<-summary(lm.reg)
