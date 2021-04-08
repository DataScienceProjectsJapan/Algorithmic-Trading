library(usethis) 
#use_git_config(user.name = "DataScienceProjectsJapan", user.email = "wclaster@apu.ac.jp")


library(rvest)
library(pbapply)
library(TTR)
library(dygraphs)
library(lubridate)
library(tidyquant)
library(timetk)
pacman::p_load(dygraphs,DT)
website <- read_html("https://www.marketwatch.com/tools/industry/stocklist.asp?bcind_ind=9535&bcind_period=3mo")

table <- html_table(html_nodes(website, "table")[[4]], fill = TRUE)

stocks.symbols<-table$X2
stocks.names<-table$X3

