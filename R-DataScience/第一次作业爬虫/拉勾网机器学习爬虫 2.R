library(stringr)
library(xml2)
library(RSelenium)
library(rvest)
############################################设置浏览器
remDr = remoteDriver('localhost',4444L,browserName='chrome')
############################################登陆账号的操作函数
#该函数使用获取验证码方式登陆，但是很奇怪的是我只有第一遍成功登陆了...不知道为什么
login<-function(){
  ##################################单击登陆按钮
  xpath5<-'//*[@id="lg_tbar"]/div/ul/li[1]/a'
  btn5 <- remDr$findElement(using = 'xpath', value = xpath5)
  remDr$mouseMoveToLocation(webElement = btn5)
  remDr$click()
  xpath0<-'/html/body/section/div[2]/div[1]/div[1]/ul/li[2]'
  btn0 <- remDr$findElement(using = 'xpath', value = xpath0)
  ##################################鼠标移动到手机验证码登陆选项
  remDr$mouseMoveToLocation(webElement = btn0)
  ##################################单击
  remDr$click()
  ##################################输入电话号码
  xpath1<-'/html/body/section/div[2]/div[1]/div[3]/form/div[1]/input'
  btn1 <- remDr$findElement(using = 'xpath', value = xpath1)
  # 输入文本
  text1 <- '18852002575'
  btn1$sendKeysToElement(text1)
  ##################################停顿
  Sys.sleep(4)
  ##################################获取验证码
  xpath4<-'/html/body/section/div[2]/div[1]/div[3]/form/div[3]/div/input[2]'
  btn4 <- remDr$findElement(using = 'xpath', value = xpath4)
  remDr$mouseMoveToLocation(webElement = btn4)
  remDr$click()
  ##################################输入验证码
  xpath2<-'/html/body/section/div[2]/div[1]/div[3]/form/div[3]/div/input[1]'
  btn2 <- remDr$findElement(using = 'xpath', value = xpath2)
  text2 <- readline('输入验证码')
  btn2$sendKeysToElement(text2)
  Sys.sleep(4)
  ##################################点击登陆按钮
  xpath3<-'/html/body/section/div[2]/div[1]/div[3]/form/div[5]/input'
  btn3 <- remDr$findElement(using = 'xpath', value = xpath3)
  remDr$mouseMoveToLocation(webElement = btn3)
  remDr$click()
}
############################################开始爬取页面，首先登陆，不过事实上后来发现登陆不是必须的
#url1 <- 'https://www.lagou.com/'
remDr$open()
#remDr$navigate(url1)
#login()
############################################找到爬取的页面
type<-c('yuyinshibie','jiqishijue','suanfagongchengshi','ziranyuyanchuli')
url0 <- 'https://www.lagou.com/zhaopin/ziranyuyanchuli/'
#remDr$open()
remDr$navigate(url0)
tpage <- remDr$getPageSource()
pageSource <- tpage[[1]]
web <- read_html(pageSource)
############################################找到总页数
#奇怪的一点是直接浏览网页时，使用safari打开网页有总共300个结果，但是chrome就有450....
pgcttxt <- web %>% html_nodes('div.item_con_pager') %>% 
  html_nodes('div')%>%html_nodes('a:nth-child(5)')%>% html_text()
pgct = as.numeric(pgcttxt)
setwd('/Users/mayuheng/Desktop')
############################################初始化向量和数据框
name=salary=require=location=time=company=companysituation=companyintro=tags=NULL
data=data.frame(name,location,salary,require,time,company,companysituation,companyintro,tags)
############################################开始循环
for(i in 1:pgct)
{
  url <- paste(url0,i,"/?filterOption=2",sep = '')
  web <- read_html(url)
  ############################################
  name <- c(name,web %>% html_nodes('div.position') %>% 
              html_nodes('div.p_top') %>% html_nodes('a') %>%
              html_nodes('h3') %>%html_text())
  ############################################
  location <- c(location,web %>% html_nodes('div.position') %>% 
                  html_nodes('div.p_top') %>% html_nodes('a') %>%
                  html_nodes('span') %>%html_nodes('em') %>%html_text())
  ############################################
  salary <- c(salary,web %>% html_nodes('div.position') %>% 
                html_nodes('div.p_bot') %>% html_nodes('div') %>%
                html_nodes('span') %>%html_text())
  ############################################有一些数据格式混乱，做简单处理
  require<- c(require, web %>% html_nodes(xpath="//li[@class]/div[1]/div[1]/div[2]/div/text()")
              %>%html_text())
  require<-require[require!="\n                                    "]
  require<-gsub(" ","",require)
  require<-gsub("\n","",require)
  ############################################
  time<- c(time,web %>% html_nodes('div.position') %>% 
             html_nodes('div.p_top') %>% html_nodes('span') %>%html_text())
  time<-time[grepl("[0-9]",time)]
  ############################################
  company <- c(company,web %>% html_nodes('div.company') %>% 
                 html_nodes('div.company_name') %>% html_nodes('a') %>%
                 html_text())
  ############################################
  companysituation <- c(companysituation,web %>% html_nodes('div.company') %>% 
                          html_nodes('div.industry') %>% 
                          html_text())
  companysituation<-gsub("\n","",companysituation)
  companysituation<-gsub(" ","",companysituation)
  ############################################
  companyintro <- c(companyintro,web %>% html_nodes('div.li_b_r') %>% 
                      html_text())
  ############################################
  tags<- c(tags, web %>% html_nodes("div.list_item_bot")
           %>% html_nodes("div.li_b_l")
           %>%html_text())
  tags<-gsub("\n","/",tags)
  tags<-gsub(" ","",tags)
  ############################################每一页的数据存储在pracdata里
  pracdata<-data.frame(name,location,salary,require,time,company,companysituation,companyintro,tags)
  print(pracdata)
  ############################################汇总进总数据框里
  data<-rbind(data,pracdata)
  ############################################清空向量
  name=salary=require=location=time=company=companysituation=companyintro=tags=NULL
  ############################################有时会遇到需要重新登录的情况
  #if(###)login()
  #Sys.sleep(5)
  ############################################
  #等时间间隔的爬取会被服务器识别并要求登陆，此时需要调用登陆操作函数
  #而随机时间的爬取并不会被识别，就无需调用
  ############################################
  x1<-runif(1,3,10)
  Sys.sleep(x1)
}
############################################关闭浏览器
remDr$closeWindow()
############################################导出数据
write.table(data,file='ziranyuyanchulidata.txt')
write.csv(data,file='ziranyuyanchulidata.csv')