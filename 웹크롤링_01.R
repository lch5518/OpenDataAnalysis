# 웹 크롤링

install.packages("rvest") # html긁어오는 역할
install.packages("dplyr")
library(rvest)
library(dplyr)


dir <- choose.dir()
setwd(dir)
getwd()

# 네이버 뉴스-교육
url <- "https://news.naver.com/main/list.nhn?mode=LS2D&mid=shm&sid2=230&sid1=105&date=20191112&page="

?paste # 붙이기!
page.num <- 1:10
url.page <- paste(url, page.num, sep="")
url.page

idx.page <- 1
for(idx.page in page.num){
    
    url.html <- url.page[idx.page] %>% read_html() # 해당 html을 긁어오는 기능
    url.html %>% str()
    
    # html_node는 하나만
    # html_nodes()은 tag, class(.), id(#)를 검색
    url.a <- url.html %>% 
      html_nodes("div.list_body.newsflash_body") %>% 
      html_nodes("dt") %>% 
      html_nodes("a") %>% 
      #html_text()
      html_attr("href") %>% 
      unique() # 중복제거거
    
    i <- 1
    for(i in i:length(url.a)){
    url.a.html <- url.a[i] %>% read_html()
    
    
    # 클래스는 .  ID는 
    # 제목
    news.title <- url.a.html %>% 
      html_nodes("#articleTitle") %>% 
      html_text()
    
    
    # 날짜
    news.datatime <- url.a.html %>% 
      html_nodes("span.t11") %>% 
      html_text()
    
    # 내용
    news.body <- url.a.html %>% 
      html_nodes("#articleBodyContents") %>% 
      html_text()
    
    # 정규식으로 필요없는 문장제거
    news.body <- sub("^.*(\\{\\}\n)[:space:]*", "", news.body)
    news.body <- gsub("(\r|\n|\t)+", "", news.body)  # +: n개 중 하나이상 이라면
    
    news.data <- cbind(news.title, news.datatime[1], news.body)
    
  
    write.table(news.data, "네이버뉴스_사회_교육.txt", sep="\t",
                append=T, row.names=F, col.names=F)
  }
}
