library(ggplot2) 
# # 处理一行数据的函数。
# # 格式表示中使用“;”分隔每个主要字段，然后在每个字段内使用“=”分隔名称值对，
# # 而值可能由多个变量构成，使用“,”分隔。
# # 时间、MAC地址、坐标（x,y,z）和方向（角度值）可以直接通过下标获得。
# # 将侦测到每个信号数据格式化成一个矩阵，并将离线观测点数据填补到矩阵的每一行
# # 对于一行在拆分后只包含监测点自身信息的（只有10个元素），需要丢弃这一行。
# processLine = function(x)
# {	tokens = strsplit(x,"[;=,]")[[1]]
# if(length(tokens)==10) return(NULL)
# tmp = matrix(tokens[-(1:10)], ncol=4, byrow = TRUE)
# mat =	cbind(matrix(tokens[c(2,4,6:8,10)], nrow = nrow(tmp), ncol=6, byrow = TRUE), tmp)
# return(mat)
# }
# 
# # 矫正角度的函数，将方向按照45度为步长调整为8个不同的方向
# roundOrientation = function(angels)
# {
#   refs = seq(0,by=45,length=9)
#   q = sapply(angels,function(o) which.min(abs(o-refs)))
#   c(refs[1:8],0)[q]
# }
# 
# 
# # 读取数据文件
# txt = readLines("/Users/mayuheng/Desktop/r语言/offline.final.txt")
# # 去掉注释行
# lines = txt[substr(txt,1,1)!="#"]
# # 使用processLine函数处理每一行数据
# tmp = lapply(lines, processLine)
# # 将处理结果转换为数据框
# offline = as.data.frame(do.call("rbind",tmp), stringsAsFactors=FALSE)
# # 给数据框的每一列起名
# names(offline)= c("time","scanMac","posX","posY","posZ","orientation","mac","signal","channel","type")
# # 需要转换为数值的列的列名
# numVars = c("time","posX","posY","posZ","orientation","signal")
# # 将以上各列转换为数值类型
# offline[numVars] = lapply(offline[numVars], as.numeric)
# # 类型为“1”的是adhoc设备，不是固定接入点，建模不考虑这些设备的数据，
# # 因此去掉所有与adhoc有关的设备，并删除type这个变量
# offline = offline[offline$type == "3",]
# offline = offline[,"type"!=names(offline)]
# # 将时间变量从毫秒级变为秒级，并为其设置一个time元素类
# offline$rawTime = offline$time
# offline$time = offline$time/1000
# class(offline$time) = c("POSIXt","POSIXct")
# # posZ全是0，因为全是在同一层测量的，
# # scanMac只有一个，这就是完成测量的设备的地址，只有一台设备
# # 因此这两个变量可以从建模数据中去掉
# offline = offline[,!(names(offline) %in% c("scanMac","posZ"))]
# 
# # 以下注释的代码是探索角度值时使用
# # length(unique(offline$orientation))
# # plot(ecdf(offline$orientation))
# 
# # 矫正角度值
# offline$angle = roundOrientation(offline$orientation)
# 
# # 以下注释的代码是探索MAC地址数据时使用
# # 发现有12个MAC地址，实际应该只有6台。
# c(length(unique(offline$mac)),length(unique(offline$channel)))
# table(offline$mac)
# 
# # 取计数值最大的7个MAC地址
# subMacs = names(sort(table(offline$mac),decreasing=TRUE))[1:7]
# offline = offline[offline$mac %in% subMacs,]
# 
# # 探索X,Y坐标的各个位置，找出所有没有进行测试的空位置，并删掉这些位置
# locDF=with(offline,by(offline,list(posX,posY),function(x) x))
# sum(sapply(locDF,is.null))
# locDF = locDF[!sapply(locDF,is.null)]
# 
# # 对手持设备位置数据的探索
# # 检查几个计数，每个位置有大约5000个记录，这与8个方向*110次重复*7个接入点是一致的。
# locCounts = sapply(locDF, function(df) c(df[1,c("posX","posY")],count = nrow(df)))
# locCounts[,1:8]
# locCounts = t(locCounts)
# # 对166个观测位置进行可视化探索
# plot(locCounts, type="n",xlab="",ylab="")
# text(locCounts,labels=locCounts[,3],cex=.8,srt=45)


##########################################################################################
#以上部分是课上代码，下面为作业部分
##########################################################################################
# first=subset(offline,posX==2&posY==12&mac!=unique(offline$mac)[7])
# ggplot(first,aes(x=factor(angle),y=signal))+geom_boxplot()+facet_wrap(vars(first$mac),nrow=3)
#结果发现有依赖性，信号的强度随着角度变化是一个周期差不多为pi的函数，应该是和坐标点与mac的相对位置有关。
# second=subset(offline,posX==24&posY==4&mac!=unique(offline$mac)[7])
# ggplot(second,aes(x=signal))+geom_density()+facet_grid(angle~mac,scales = "free_x")
#跟上一个一样啊。。看不出其他啥了
# third=subset(offline,posX==1&posY==1&mac!=unique(offline$mac)[7])
# c<-ggplot(third,aes(x=factor(angle),y=rawTime))+geom_boxplot()+facet_wrap(vars(third$mac),nrow=3)
#这里可以明显的看出时长和角度的某些关系
fourth=subset(offline,mac!=unique(offline$mac)[7])
#c<-ggplot(fourth,aes(x=signal,y=rawTime,color=angle))+geom_point(size=0.5)
#这里看到了一些奇怪的关系，整不明白啊，把三条单独拿出来看
cluster<-kmeans(fourth$rawTime,3)
fourth$cluster=cluster[[1]]
fourth1=subset(fourth,cluster==1)
ggplot(fourth1,aes(x=signal,y=rawTime,color=angle))+geom_point(size=0.5)
#哈哈，没啥用，散了散了