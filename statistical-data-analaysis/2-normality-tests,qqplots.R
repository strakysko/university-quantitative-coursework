setwd("C:/Users/david/OneDrive/VU/Statistical Data Analysis/Assignment 2")
source("sample33.txt")
source("sample34.txt")
source('functions_Ch4.txt')
source('functions_Ch5.txt')

 
# Exercise 3.3
data33 <- scan("sample33.txt")
hist(data33, prob=T)
y = log(data33)
h = h_opt(y)
yrange <- seq(min(y), max(y), length.out=512)
lines(exp(yrange), density(y, bw = h, kernel = "gaussian", from=min(yrange), to=max(yrange))$y/exp(yrange))


# Exercise 3.4
data34 <- scan("sample34.txt")
hist(data34, prob=T)
h = h_opt(data34)
x = seq(min(data34) - 3*h, max(data34) + 3*h, length.out=512)
lines(x, density(data34, bw = h, kernel = "gaussian")$y)










# Part a.
data$BMI = data$weight / (data$height / 100) ^ 2
par(mfrow=c(2,2))
hist(data$BMI, prob=T, main = "Histogram of BMIs of Young Sporty Males", 
     xlab = "Body Mass Index (BMI)", ylab = "Proportion of Males")
hist(data$ankle_girth, prob=T, main = "Histogram of Ankle Girths of Young Sporty Males",
     xlab = "Ankle Girth (cm)", ylab = "Proportion of Males")
boxplot(data$BMI, main = "Boxplot of BMIs of Young Sporty Males", 
        ylab = "Body Mass Index (BMI)")
boxplot(data$ankle_girth, main = "Boxplot of Ankle Girths of Young Sporty Males",
        ylab = "Ankle Girth (cm)")

# Part b.
par(mfrow=c(1,1))
qqplot(data$BMI, data$ankle_girth, 
       main = "Two Sample QQ-Plot of BMIs and Ankle Girths of Young Sporty Males", 
       xlab = "Body Mass Index (BMI)", ylab = "Ankle Girth (cm)")

# Part c.
par(mfrow=c(1,2))
qqplot(rnorm(247, 25, 2.8), data$BMI,
       main = "QQ-Plot of BMI of Males and N(25, 2.8)", 
       xlab = "Theoretical Quantiles of N(25, 2.8)", ylab = "Order Statistics of BMI")
qqplot(rnorm(247, 23, 1.7), data$ankle_girth,
       main = "QQ-Plot of Ankle Girth of Males and N(23, 1.7)", 
       xlab = "Theoretical Quantiles of N(23, 1.7)", ylab = "Order Statistics of Ankle Girth")

# Part d.
diff = data$BMI - data$ankle_girth
par(mfrow=c(2,2))
qqnorm(diff, main = "Normal QQ-Plot of the Difference between BMI and Ankle Girth", 
       xlab = "Theoretical Quantiles of the Standard Normal Distribution", 
       ylab = "Order Statistics of The Differences")
hist(diff, prob=T, main = "Histogram of the Difference between BMI and Ankle Girth", 
     xlab = "Difference between BMI and Ankle Girth", 
     ylab = "Proportion of the Differences")

# Part e.
shapiro.test(diff)

# Part f.
shapiro.test(data$BMI)
shapiro.test(data$BMI[0:50])

par(mfrow=c(2,2))
hist(data$BMI, prob=T, main = "Histogram of BMI of 247 Young Sporty Males", 
     xlab = "Body Mass Index (BMI)", ylab = "Proportion of Males")
hist(data$BMI[0:50], prob=T, main = "Histogram of BMI of 50 Young Sporty Males", 
     xlab = "Body Mass Index (BMI)", ylab = "Proportion of Males")
