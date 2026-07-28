setwd("C:/Users/david/OneDrive/VU/Statistical Data Analysis/Assignment 3")
source("sample33.txt")
source("sample34.txt")
source("t-sample.txt")
source('functions_Ch4.txt')
source('functions_Ch5.txt')

 
# Exercise 3.3
data33 <- scan("sample33.txt")
hist(data33, prob=T, main = "Histogram and Kernel Density Estimate of Sample 33",
     xlab = "Sample 33 Data", 
     ylab = "Proportion of Sample / Relative Likelihood")
y = log(data33)
h = h_opt(y)
yrange <- seq(min(y), max(y), length.out=512)
lines(exp(yrange), density(y, bw = h,
      from=min(yrange), to=max(yrange))$y/exp(yrange))


# Exercise 3.4
data34 <- scan("sample34.txt")

  # h_opt method
h1 = h_opt(data34)

  # cross-validation criterion method
hrange = seq(0.015, 3, length.out=300)
cv_criterion = lapply(hrange, CV, data34, "g")
plot(hrange, cv_criterion, type="l",
     main = "Bandwidth Minimizing The Cross-Validation Criterion",
     xlab = "Bandwidth", 
     ylab = "Cross-Validation Criterion")
h2 = hrange[which.min(cv_criterion)]

    # kernel density estimates
x_half = seq(0, max(data34) + 3*h1, length.out=600)
x = append(- rev(x_half)[1:599], x_half)
hist(data34, prob=T,  ylim=c(0,0.45),
     main = "Histogram and Kernel Density Estimates of Sample 34",
     xlab = "Sample 34 Data", 
     ylab = "Proportion of Sample / Relative Likelihood")
lines(x, density(data34, bw = h1, from = min(x), to = max(x), n = 1199)$y, 
      col = "red")
lines(x, density(data34, bw = h2, from = min(x), to = max(x), n = 1199)$y,
      col = "blue")
legend(2, 0.4, legend=c("h_opt Method", "Cross-Validation Method"),
       col=c("red", "blue"), lty=1:1)

    # double exponential comparison
doublexp = append(0.5 * rev(dexp(x_half))[1:599], 0.5 * dexp(x_half))
plot(x, doublexp, type="l",
     main = "Laplace Density and Its Kernel Density Estimates",
     xlab = "Sample 34 Data", 
     ylab = "Relative Likelihood")
lines(x, density(data34, bw = h1, from = min(x), to = max(x), n = 1199)$y, 
      col = "red")
lines(x, density(data34, bw = h2, from = min(x), to = max(x), n = 1199)$y,
      col = "blue")
legend(2, 0.5, col=c("black", "red", "blue"), lty=1:1,
       legend=c("Laplace Density", "h_opt Method", "Cross-Validation Method"))


# Exercise 3.5

  # Part a.
tsample <- scan("t-sample.txt")
m = mad(tsample)

  # Part b.
set.seed(20220341)
mad_empBS = bootstrap(tsample, mad, B = 2000)

  # Part c.
s2 = var(tsample)
k = 2 * s2 / (s2 - 1)
mad_parBS = replicate(2000, mad(rt(100, k)))

  # Part d.
par(mfrow=c(2,2))
hist(mad_empBS)
hist(mad_parBS)
mad_realizations = replicate(2000, mad(rt(100, 10)))
hist(mad_realizations)
