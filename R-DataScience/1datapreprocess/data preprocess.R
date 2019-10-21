sortdata<-function (filename,filepath){
  setwd(filepath)
  input<-read.csv(filename)
  input[,1]<-NULL
  colnames(input)<-t(input)[,1]
  input<-input[-1,]
  rownames(input)<-seq(1:nrow(input))
  input[['salary']]<-as.numeric(as.character(input[['salary']]))
  input[['start_date']]<-as.Date(input[['start_date']])
  comment<-NULL
  for(i in 1:nrow(input)){
    comment<-c(comment,paste(input[['name']][i],'entered',input[['dept']][i],'on',input[['start_date']][i],sep=" ",collapse = NULL))
  }
  input<-cbind(input,as.data.frame(comment))
  flag<-!complete.cases(input)
  input<-cbind(input,as.data.frame(flag))
  input
}
filepath<-"/Users/mayuheng/Desktop/未命名文件夹"
input1<-sortdata('input1.csv',filepath)
input2<-sortdata('input2.csv',filepath)
input<-rbind(input1,input2)
output<-input[!duplicated(input$id),]
print(output)
