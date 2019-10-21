data<-read.csv("data.csv")
table(data$companyfield)
field<-NULL
tag<-NULL
#for(i in 1:nrow(data)){
#  field=c(field,strsplit(chartr("、"," ",chartr(","," ",data$companyfield[[i]]))," "))
#}
for(i in 1:nrow(data)){
  field=c(field,as.vector(strsplit(chartr("、"," ",chartr(","," ",data$companyfield[[i]]))," ")))
}
for(i in 1:nrow(data)){
  temp=strsplit(chartr("/"," ",data$tags[[i]])," ")[[1]][c(strsplit(chartr("/"," ",data$tags[[i]])," ")[[1]]!="")]
  tag=c(tag,list(temp))
}
data$companyfield<-field
data$tags<-tag
data$salary=(data$highsalary+data$lowsalary)/2

majorcity<-table(data$city)[table(data$city)>mean(as.vector(table(data$city)))]
citydata<-data[data[["city"]]%in%names(majorcity),]
ggplot(citydata,aes(x=city,y=salary),position="jitter")+geom_boxplot(notch = TRUE)+ scale_size_area() +xlab("city")+ stat_summary(fun.y="mean", geom="point", shape=23, size=3, fill="white")




ggplot(citydata,aes(x=salary))+geom_density()+facet_wrap(vars(citydata$city),nrow=2)

beijingdata<-data[as.vector(data[["city"]])=="北京",]
beijingdata$district<-as.character(beijingdata$district)
quantile(as.vector(table(beijingdata$district)))
beijingdata<-beijingdata[beijingdata$district%in%names(table(beijingdata$district)[table(beijingdata$district)>20]),]

beijingdata$district[beijingdata$district%in%c("北京大学","上地","五道口","西北旺","西二旗","西三旗","学院路","知春路","中关村","海淀区")]="haidianqu"
beijingdata$district[beijingdata$district%in%c("大望路","酒仙桥","望京","朝阳区")]="chaoyangqu"
ggplot(beijingdata,aes(x=district,y=salary))+geom_boxplot()+scale_size_area()

haidian<-beijingdata[beijingdata$district%in%c("北京大学","上地","五道口","西北旺","西二旗","西三旗","学院路","知春路","中关村","海淀区"),]
chaoyang<-beijingdata[beijingdata$district%in%c("大望路","酒仙桥","望京","朝阳区"),]
t.test(haidian$salary,chaoyang$salary)

q<-NULL
for(i in 1:8){q<-c(q,quantile(data$salary[data$belong==names(table(data$belong))[i]])[4])}
names(q)<-names(table(data$belong))
ggplot(data,aes(x=data$belong,y=salary))+geom_boxplot()





data$degree=factor(data$degree,levels = c("不限","大专","本科","硕士","博士"),labels = c("whatever","college","university","master","docter"))
data$experience=factor(data$experience,c("经验不限","经验应届毕业生","经验1年以下","经验1-3年","经验3-5年","经验5-10年","经验十年以上"),labels = c("whatever","graduate","lessthan1","1-3","3-5","5-10","10+"))

ggplot(data,aes(x=experience,y=salary,color=degree))+geom_jitter()+geom_point()+scale_color_manual(values = c("red", "yellow", "blue","black","green"))

data$exp=as.numeric(data$exp)
data$exp[data$experience=="whatever"]=NA
data$exp[data$experience=="graduate"]=0
data$exp[data$experience=="lessthan1"]=0.5
data$exp[data$experience=="1-3"]=2
data$exp[data$experience=="3-5"]=4
data$exp[data$experience=="5-10"]=7.5
data$exp[data$experience=="10+"]=15
data$deg=as.numeric(data$deg)
data$deg[data$degree=="whatever"]=NA
data$deg[data$degree=="college"]=2
data$deg[data$degree=="university"]=4
data$deg[data$degree=="master"]=6
data$deg[data$degree=="docter"]=8

for(i in 1:nrow(data)){
  field=c(field,as.vector(strsplit(chartr("、"," ",chartr(","," ",field[[i]]))," ")))
}
field<-as.character(field)


data$companyintroduction<-as.character(data$companyintroduction)
data$introlength=nchar(data$companyintroduction)
ggplot(data,aes(y=salary,x=introlength))+geom_point()+geom_jitter()

cor.test(data$salary,data$introlength)
data$tag<-as.numeric(data$tag)
for (i in 1:nrow(data)){data$tag[i]=length(data$tags[[i]])}
cor.test(data$salary,data$tag)


data$companyfinancial=factor(data$companyfinancial,levels = c("不需要融资","未融资","天使轮","A轮","B轮","C轮","D轮及以上","上市公司"),labels = c("noneed","notyet","angel","A","B","C","D+","listed"))
data$companyfin[data$companyfinancial=="不需要融资"]=NA
data$companyfin[data$companyfinancial=="未融资"]=0
data$companyfin[data$companyfinancial=="天使轮"]=1
data$companyfin[data$companyfinancial=="A轮"]=2
data$companyfin[data$companyfinancial=="B轮"]=3
data$companyfin[data$companyfinancial=="C轮"]=4
data$companyfin[data$companyfinancial=="D轮及以上"]=5
data$companyfin[data$companyfinancial=="上市公司"]=6
ggplot(data,aes(y=salary,x=companyfinancial))+geom_point()+geom_jitter()

data$companymem<-NULL
data$companymem=as.numeric(data$companymem)
data$companymembers=factor(data$companymembers,levels = c("少于15人","15-50人","50-150人","150-500人","500-2000人","2000人以上"),labels = c("lessthan15","15-50","50-150","150-500","500-2000","2000+"))
data$companymem[data$companymembers=="lessthan15"]=8
data$companymem[data$companymembers=="15-50"]=30
data$companymem[data$companymembers=="50-150"]=100
data$companymem[data$companymembers=="150-500"]=300
data$companymem[data$companymembers=="500-2000"]=1300
data$companymem[data$companymembers=="2000+"]=2500
cor.test(data$companymem,data$salary)

cordata<-data[c("salary","companyfin","companymem","tag","introlength","exp","deg")]
cordata<-na.omit(cordata)
confdata<-cor.mtest(cordata)
corrplot(cor(cordata),p.mat =confdata$p,sig.level=0.005)

linear<-lm(salary~companyfin+companymem+tag+introlength+exp+deg,data=cordata)
summary(linear)

linear<-step(linear)
confint(linear,level = 0.95)

linear<-lm(salary~companyfin+companymem+exp+deg,data=cordata)
summary(linear)
abline(linear)

cordata<-data[c("salary","companyfin","companymem","tag","introlength")]
cordata<-na.omit(cordata)
library(plyr)
library(cluster)
library(lattice)
library(graphics)
wss <- numeric(10) 
for (k in 1:10) wss[k] <- sum(kmeans(cordata, centers=k, nstart=25)$withinss)
plot(1:10, wss, type="b", xlab="Number of Clusters", ylab="Within Sum of Squares") 

km = kmeans(cordata,3, nstart=25)
cordata$type=km$cluster
ggplot(cordata,aes(x=companyfin,y=companymem,color=type))+geom_point()+geom_jitter()
ggplot(cordata,aes(x=tag,y=introlength,color=type))+geom_point()+geom_jitter()

install.packages("SUMMER")
install.packages("wordcloud")
library("wordcloud")
field<-read.csv(file="field.csv",stringsAsFactors = FALSE)
field[1]<-NULL
wordcloud(as.character(field),scale = c(4,0.8),family="STKaiti")
