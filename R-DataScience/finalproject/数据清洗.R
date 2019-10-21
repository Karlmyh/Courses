library("lubridate")
library("VIM")
library("mice")
############简单而笨拙的导入数据
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
data1<-cbind(belong=rep(names(data[1]),nrow(data[[1]])),data[[1]])
for(i in 2:8){data1<-rbind(data1,cbind(belong=rep(names(data[i]),nrow(data[[i]])),data[[i]]))}
data=data1

sorteddata<-list(NULL)
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
  index<-NULL
  ###############处理地名
  
    temp<-strsplit(data[[4]],split='·') 
  
    for(i in 1:nrow(data)){
    city<-c(city,temp[[i]][[1]])
    if(length(temp[[i]])==2){
    district<-c(district,temp[[i]][[2]])
    }
    else{
      district<-c(district,"市")
      index<-c(index,i)
    }
    }
    temp<-NULL
  ############处理薪资
  temp<-strsplit(data[[5]],split='-') 
  for(j in 1:nrow(data)){
    
    lowsalary<-c(lowsalary,as.numeric(chartr("K"," ",chartr("k"," ",temp[[j]][[1]]))))
    if(length(temp[[j]])==2){
    highsalary<-c(highsalary,as.numeric(chartr("K"," ",chartr("k"," ",temp[[j]][[2]]))))
    }
    else{
      highsalary<-c(highsalary,as.numeric(chartr("K"," ",chartr("k"," ",temp[[j]][[1]]))))
      index<-c(index,j)
    }
  }
  #########处理要求
  temp<-strsplit(data[[6]],split='/') 
  for(j in 1:nrow(data)){
    experience<-c(experience,temp[[j]][[1]])
    degree<-c(degree,temp[[j]][[2]])
  }
  #########处理公司情况
  temp<-strsplit(data[['companysituation']],split='/') 
  for(j in 1:nrow(data)){
    if(length(temp[[j]])==3){
    companyfield<-c(companyfield,temp[[j]][[1]])
    companyfinancial<-c(companyfinancial,temp[[j]][[2]])
    companymembers<-c(companymembers,temp[[j]][[3]])
    }
    else{
      companyfield<-c(companyfield,"blank")
      companyfinancial<-c(companyfinancial,"blank")
      companymembers<-c(companymembers,"blank")
      index<-c(index,j)
    }
  }
  ###########把刚刚得到的向量组成表格
sorteddata<-data.frame(belong=data[['belong']],name=data[['name']],
                        city=city,district=district,lowsalary=lowsalary,highsalary=highsalary,experience=experience,degree=degree,company=data[['company']],
                        companyintroduction=data[['companyintro']],companyfield=companyfield,companyfinancial=companyfinancial,
                        companymembers=companymembers,tags=data[['tags']])
###########查看缺失值
  aggr(sorteddata, prop=FALSE, numbers=TRUE,plot = TRUE)
  ################删除缺失值和前面不好处理的数据行
data<-na.omit(sorteddata)
data<-data[-index,]


