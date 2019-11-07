# 웹 크롤링

install.packages("rvest") # html긁어오는 역할
install.packages("dplyr")
library(rvest)
library(dplyr)

url <- "https://news.naver.com/main/list.nhn?mode=LS2D&sid2=250&sid1=102&mid=shm&date=20191107&page="

?paste # 붙이기!
page.num <- 1:10
url.page <- paste(url, page.num, sep="")
url.page

idx.page <- 1
url.html <- url.page[idx.page] %>% read_html() # 해당 html을 긁어오는 기능
url.html %>% str()

# html_nodes()은 tag, class(.), id(#)를 검색
url.html %>% 
  html_nodes("div.list_body.newsflash_body") %>% 
  html_nodes("dt") %>% 
  html_nodes("a") %>% 
  #html_text()
  html_attr("href") %>% 
  unique() # 중복제거거
