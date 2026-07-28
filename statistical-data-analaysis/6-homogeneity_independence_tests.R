("C:/Users/david/OneDrive/VU/Statistical Data Analysis/Assignment 6")
source('functions_Ch8.txt')
source('expensescrime.txt')
source('nausea.txt')

library(mvtnorm)

# Exercise 6.1

  # Part c.
data61 <- read.table("expensescrime.txt", header=T)

expend_rate = (data61$expend/data61$pop)[data61$pop >= 4000]
crime = data61$crime[data61$pop >= 4000]

cor.test(expend_rate, crime, method = "k")
cor.test(expend_rate, crime, method = "s")

  # Part d.
B = 1000
t = cor(expend_rate, crime, method="s")
t_perm = replicate(B, cor(expend_rate, sample(crime), method="s"))
p = 2 * min(sum(t_perm >= t)/B, sum(t_perm <= t)/B)

  # Part e.
aresimulation=function(B,n){
  pvalken = pvalspear = numeric(B)
  for(i in 1:B){
    x = rmvt(n,sigma=matrix(c(1,0.3,0.3,1),2,2),df=6)
    pvalken[i] = cor.test(x[,1], x[,2], method = "k")[[3]]
    pvalspear[i] = cor.test(x[,1], x[,2], method = "s")[[3]]
  }
  powerken = mean(pvalken<0.05)
  powerspear = mean(pvalspear<0.05)
  rbind(c("ken","spear"),c(powerken,powerspear))
}

aresimulation(5000,48)
aresimulation(5000,50)
aresimulation(5000,52)

# Exercise 6.2

  # Part a.
m = matrix(c(30, 17, 1067, 1120), nrow = 2, ncol = 2)
fisher.test(m)

  # Part b.
fisher.test(m, alternative = "g")

  # Part c.
pl = phyper(30,1097,1137,47)
pr = 1 - phyper(30-1,1097,1137,47)
