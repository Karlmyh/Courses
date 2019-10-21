setwd("/Users/mayuheng/Desktop/未命名文件夹")
data1<-read.csv("group1.csv")
data2<-read.csv("group2.csv")
data3<-read.csv("group3.csv")
data<-rbind(data1,data2,data3)
data=data[!is.na(data$nettime),]
segmentofage<-function(age){
  if (age<35){age_seg<-"young"}
  else if(age>=35&&age<50){age_seg<-"middle"}
  else{age_seg<-"old"}
}
data$age_seg<-lapply(data$age,segmentofage)
name <- strsplit(as.character(data$nettime),":")

#wss <- numeric(10)
#for (k in 1:10) wss[k] <- sum(kmeans(data, centers=k, nstart=4)$withinss)
#plot(1:10, wss, type="b", xlab="Number of Clusters", ylab="Within Sum of Squares") 
#result=kmeans(data,4, nstart=4)
#data$cluster=result$cluster
#ggplot(data,aes(y=deathrate,x=incidence,color=as.factor(cluster)))+geom_point()+geom_text(aes(label=rownames(data)), size=3)
