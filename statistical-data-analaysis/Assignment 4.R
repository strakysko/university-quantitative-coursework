setwd("C:/Users/david/OneDrive/VU/Statistical Data Analysis/Assignment 4")
source('functions_Ch5.txt')
source('functions_Ch3.txt')
source('light.txt')


# Exercise 4.1
bw = scan("birthweight.txt")

  # Part a.
par(mfrow=c(1,3), pty="s")
hist(bw, prob=T, main="Histogram of Birth Weights",
     xlab="Birth Weight in Grams",
     ylab="Proportion of Weights")
symplot(bw, main="Symplot of Birth Weights")
boxplot(bw, main="Box Plot of Birth Weights",
        ylab="Birth Weight in Grams")

par(mfrow=c(2,3), pty="s")
qqnorm(bw, main="Normal Q-Q Plot of Birth Weights",
       xlab="Quantiles of the Normal Distribution",
       ylab="Sorted Birth Weights")
qqline(bw)

qqcauchy(bw, main="Cauchy Q-Q Plot of Birth Weights",
         xlab="Quantiles of the Cauchy Distribution",
         ylab="Sorted Birth Weights")
qqline(bw, distr=qcauchy)

qqchisq(bw, df=10, main="Chi-Squared Q-Q Plot of Birth Weights",
        xlab="Quantiles of the Chi-Squared Distribution",
        ylab="Sorted Birth Weights")
qqline(bw, distr=function(p) qchisq(p,df=10))

qqlaplace(bw, main="Laplace Q-Q Plot of Birth Weights",
          xlab="Quantiles of the Laplace Distribution",
          ylab="Sorted Birth Weights")
qqline(bw)

qqlogis(bw, main="Logistic Q-Q Plot of Birth Weights",
        xlab="Quantiles of the Logistic Distribution",
        ylab="Sorted Birth Weights")
qqline(bw, distribution=qlogis)

qqt(bw, df=10, main="Student's T Q-Q Plot of Birth Weights",
    xlab="Quantiles of the T-Distribution",
    ylab="Sorted Birth Weights")
qqline(bw, distr=function(p) qt(p,df=10))

var(bw)
sd(bw)
mean(bw)

  # Part b.
quantile(bw, 0.1)
mad(replicate(1000, quantile(rnorm(length(bw), mean=mean(bw), sd=sd(bw)), 0.1)))

  # Part c.
mad(replicate(1000, quantile(rexp(length(bw), rate=1/mean(bw)), 0.1)))


# Exercise 4.3
x = light[['1879']]

replicate(1000, 1)

ks.test(x,pnorm,mean(x),sd(x))$statistic

bootstrap(x, ks.test, B=1000, pnorm, mean(x), sd(x))
        
          