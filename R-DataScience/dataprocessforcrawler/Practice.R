library("lubridate")
library("VIM")
library("mice")
shenduxuexidata<-read.csv('/Users/mayuheng/Desktop/data/shenduxuexidata.csv',fileEncoding = "UTF-8",stringsAsFactors=FALSE)
jiqixuexidata<-read.csv('/Users/mayuheng/Desktop/data/jiqixuexidata.csv',fileEncoding = "UTF-8",stringsAsFactors=FALSE)
tuxiangchulidata<-read.csv('/Users/mayuheng/Desktop/data/tuxiangchulidata.csv',fileEncoding = "UTF-8",stringsAsFactors=FALSE)
tuxiangshibiedata<-read.csv('/Users/mayuheng/Desktop/data/tuxiangshibiedata.csv',fileEncoding = "UTF-8",stringsAsFactors=FALSE)
yuyinshibiedata<-read.csv('/Users/mayuheng/Desktop/data/yuyinshibiedata.csv',fileEncoding = "UTF-8",stringsAsFactors=FALSE)
jiqishijuedata<-read.csv('/Users/mayuheng/Desktop/data/jiqishijuedata.csv',fileEncoding = "UTF-8",stringsAsFactors=FALSE)
suanfagongchengshidata<-read.csv('/Users/mayuheng/Desktop/data/suanfagongchengshidata.csv',fileEncoding = "UTF-8",stringsAsFactors=FALSE)
ziranyuyanchulidata<-read.csv('/Users/mayuheng/Desktop/data/ziranyuyanchulidata.csv',fileEncoding = "UTF-8",stringsAsFactors=FALSE)
data<-list(shenduxuexidata=shenduxuexidata,jiqixuexidata=jiqixuexidata,tuxiangchulidata=tuxiangchulidata,tuxiangshibiedata=tuxiangshibiedata,yuyinshibiedata=yuyinshibiedata,
jiqishijuedata=jiqishijuedata,suanfagongchengshidata=suanfagongchengshidata,ziranyuyanchulidata=ziranyuyanchulidata)
for(i in 1:8){data[[i]]<-cbind(belong=rep(names(data[i]),nrow(data[[i]])),data[[i]])}
#for(i in 1:8){data[[i]][1]<-NULL}

sorteddata<-list(NULL)
for(i in 1:8){
  city<-NULL
  district<-NULL
  lowsalary<-NULL
  highsalary<-NULL
  experience<-NULL
  degree<-NULL
  isday<-NULL
  companyfield<-NULL
  companymembers<-NULL
  companyfinancial<-NULL
  today<-Sys.Date()
  temp<NULL
  print(0)
  for(j in 1:nrow(data[[i]])){
    temp<-strsplit(data[[i]][[4]][[j]],split='·') 
    temp[[1]]<-c(temp[[1]],'市')
    city<-c(city,temp[[1]][[1]])
    district<-c(district,temp[[1]][[2]])
    temp<-NULL
  }
  print(1)
  for(j in 1:nrow(data[[i]])){
    temp<-strsplit(data[[i]][[5]][[j]],split='-') 
    lowsalary<-c(lowsalary,as.numeric(chartr("K"," ",chartr("k"," ",temp[[1]][1]))))
    highsalary<-c(highsalary,as.numeric(chartr("K"," ",chartr("k"," ",temp[[1]][2]))))
  }
  for(j in 1:nrow(data[[i]])){
    temp<-strsplit(data[[i]][[6]][[j]],split='/') 
    experience<-c(experience,temp[[1]][[1]])
    degree<-c(degree,temp[[1]][[2]])
  }
  print(2)
  for(j in 1:nrow(data[[i]])){
    isday<-c(isday,grepl("天前发布",data[[i]][['time']][j]))
  }
  for(j in which(isday==1)){
  data[[i]][['time']][[j]]=as.Date(today-as.numeric(substr(data[[i]][['time']][[j]],1,1)))
  }
  isday<-NULL
  print(3)
  for(j in 1:nrow(data[[i]])){
    isday<-c(isday,grepl("发布",data[[i]][['time']][j]))
  }
  for(j in which(isday==1)){
    data[[i]][['time']][[j]]=as.Date(today)
  }
  for(j in 1:nrow(data[[i]])){
    temp<-strsplit(data[[i]][['companysituation']][[j]],split='/') 
    temp[[1]]<-c(temp[[1]],'')
    companyfield<-c(companyfield,temp[[1]][[1]])
    companyfinancial<-c(companyfinancial,temp[[1]][[2]])
    companymembers<-c(companymembers,temp[[1]][[3]])
  }
  print(4)
sorteddata[[i]]<-data.frame(belong=data[[i]][['belong']],serial=data[[i]][['X']],name=data[[i]][['name']],
                        city=city,district=district,lowsalary=lowsalary,highsalary=highsalary,experience=experience,degree=degree,time=data[[i]][['time']],company=data[[i]][['company']],
                        companyintroduction=data[[i]][['companyintro']],companyfield=companyfield,companyfinancial=companyfinancial,
                        companymembers=companymembers,tags=data[[i]][['tags']])
  print(5)
  aggr(sorteddata[[i]], prop=FALSE, numbers=TRUE)
}

print(1)
write.csv(sorteddata,file='sorteddata.csv')
write.table(sorteddata,file='sorteddata.txt')
print(1)