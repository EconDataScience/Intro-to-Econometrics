setwd("C:/where/Files/Are/Located")

mroz <- read.csv("mroz.csv")
head(mroz)
summary(mroz)
names(mroz)[names(mroz) == "hourstotalin1975"] <- "hours"

mroz2 <- na.omit(mroz)
mroz2$fulltime <- mroz2$hours > 40*52

attach(mroz2)
mroz2$fulltime_d <- ifelse(mroz2$hours>40*52,1,0)


reg_1 <- lm(wage ~ educ, data = mroz2)
summary(reg_1)

plot(mroz2$educ, mroz2$wage)
abline(lm(wage ~ educ, data = mroz2))

hist(mroz2$wage)



library(data.table)
mroz3 <- as.data.table(mroz2)
mroz3 <- mroz3[which(wage >0),]


reg_2 <- lm(log(wage) ~ educ, data = mroz3) 
reg_3 <- lm(log(wage) ~ educ + exper, data = mroz3)



library(stargazer)
stargazer(reg_2,reg_3,type = "text", title="Regression Results")


?stargazer
