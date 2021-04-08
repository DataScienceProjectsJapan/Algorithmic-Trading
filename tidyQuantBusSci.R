#https://www.business-science.io/code-tools/2017/01/01/tidyquant-introduction.html

install.packages("tidyquant")

# Loads tidyquant, tidyverse, lubridate, quantmod, TTR, and xts
library(tidyquant)
library(dplyr)
library(tidyverse)

from <- today() - years(1)
SESN <- tq_get("SESN", get = "stock.prices", from = from)
# SESN
# SESN <-SESN %>%
#   tq_mutate(ohlc_fun = Cl, mutate_fun = SMA, n = 15)
#View(SESN)

SESN <- SESN%>%
  tq_mutate(ohlc_fun = Cl, mutate_fun = SMA, n = 15) %>%
  rename(SMA.15 = SMA) %>%
  tq_mutate(ohlc_fun = Cl, mutate_fun = SMA, n = 50) %>%
  rename(SMA.50 = SMA)


SESN %>% select(date,close,SMA.15, SMA.50) %>% ggplot(aes(x=date,y=close))+geom_line(color="blue") + geom_line(aes(x = date, y = SMA.15), size = 1.5, color="green")+geom_line(aes(x = date, y = SMA.50), size = 1, color="purple")

# AAPL %>%
#   select(date, close, SMA.15, SMA.50) %>%
#   gather(key = type, value = price, close:SMA.50)

my_palette <- c("#69b3a2", "blue1", "brown2","black", "purple")

SESN %>% select(date,close,SMA.15, SMA.50) %>% pivot_longer(cols=c(close,SMA.15,SMA.50), names_to = "type", values_to ="value" ) %>% ggplot(aes(x=date,y=value,col=type))+geom_line(size=1) 

#+ scale_color_viridis(discrete=TRUE, option="plasma")

# SESN %>% select(date,close,SMA.15, SMA.50) %>% ggplot(aes(x=date,y=close))+geom_line() + geom_line(aes(x = date, y = SMA.15), size = 1.5)+geom_line(aes(x = date, y = SMA.50), size = 1)+scale_color_manual(values=c("#69b3a2", "blue1", "brown2","black", "purple"))

ggplot(TokyoCases, aes(x = Date, y=TokyoCasesDaily)) + geom_point() + geom_smooth(span = 0.2)+labs(title = "Tokyo daily new cases", x = "", y = "New cases",subtitle = "7-day smoothing in blue")

library(forecast)
library(viridis)
#See some color options here
#https://www.r-graph-gallery.com/ggplot2-color.html
#+geom_forecast()
ggplot(top5Casesgrouped, aes(x = Date, y=newCases, colour = prefectureNameE)) + geom_point(size=.1)+ geom_smooth(aes(group = prefectureNameE),span = 0.2) +labs(title = "Japan Cities", x = "", y = "New cases",subtitle = "smoothed trend")+ylim(0,1800) +scale_color_manual(values=c("#69b3a2", "blue1", "brown2","black", "purple"))
