Simple R commands to pull data from web sites

library(rvest)
library(dplyr)

movie <- html("") # exctract webpage

## Extract specific node correponds to the item
html_node() 

## exctract text
html_text()

## tables from pages
 html_table()

### Following example illustrates scraping from Linkdn site 

## html_form(), html_session(), set_values(), submit_geturl(),

# Attempt to crawl LinkedIn, requires useragent to access Linkedin Sites
uastring <- "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"
session <- html_session("https://www.linkedin.com/job/", user_agent(uastring))
form <- html_form(session)[[1]]
form <- set_values(form, keywords = "Data Science", location="New York")
 
new_url <- submit_geturl(session,form)
new_session <- html_session(new_url, user_agent(uastring))
jobtitle <- new_session %>% html_nodes(".job [itemprop=title]") %>% html_text
company <- new_session %>% html_nodes(".job [itemprop=name]") %>% html_text
location <- new_session %>% html_nodes(".job [itemprop=addressLocality]") %>% html_text
description <- new_session %>% html_nodes(".job [itemprop=description]") %>% html_text
url <- new_session %>% html_nodes(".job [itemprop=title]") %>% html_attr("href")
url <- paste(url, ')', sep='')
url <- paste('[Link](', url, sep='')
df <- data.frame(jobtitle, company, location, url)

df %>% kable
