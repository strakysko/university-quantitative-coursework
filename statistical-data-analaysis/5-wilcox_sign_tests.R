setwd("C:/Users/david/OneDrive/VU/Statistical Data Analysis/Assignment 5")
source('functions_Ch3.txt')
source('functions_Ch5.txt')
source('clouds.txt')
source('statgrades.txt')

# Exercise 5.1
data51 <- scan("statgrades.txt")
hist(data51)
summary(data51)

  # Part a.
g62 = 0
for(i in 1:length(data51)){
  if(data51[i] > 6.2){
    g62 = g62 + 1
  }
}

binom.test(g62,length(data51),alternative="less")
pval_a = 0.001444
reject_a = TRUE

  # Part b.
data51b = NULL
for(i in 1:length(data51)){
  if(data51[i] != 6.0){
    data51b[length(data51b)+1] = data51[i]
  }
}

g6 = 0
for(i in 1:length(data51b)){
  if(data51b[i] > 6.0){
    g6 = g6 + 1
  }
}

binom.test(g6,length(data51b), alternative = "two.sided")
pval_b = 0.211
reject_b = FALSE

  # Part c.
data51c = NULL
for(i in 1:length(data51)){
  if(data51[i] != 5.5){
    data51c[length(data51c)+1] = data51[i]
  }
}

g55 = 0
for(i in 1:length(data51c)){
  if(data51c[i] >= 5.5){
    g55 = g55 + 1
  }
}

binom.test(g55,length(data51c),p = 0.45, alternative = "g")
pval_c = 0.0568
reject_c = TRUE

# Exercise 5.2

  # Part a.
clouds = read.table('clouds.txt')
summary(clouds$unseeded.clouds)

par(mfrow=c(1,4), pty="s")
hist(clouds$unseeded.clouds, prob=T, main="Histogram of Precipitation",
     xlab="Precipitation Value",
     ylab="Proportion of Unseeded Clouds")
symplot(clouds$unseeded.clouds, main="Symplot of Precipitation")
qqnorm(clouds$unseeded.clouds, main="Normal QQ-Plot of Precipitation",
       xlab="Quantiles of the Normal Distribution",
       ylab="Sorted Precipitation Values")
qqline(clouds$unseeded.clouds)
boxplot(clouds$unseeded.clouds, main="Box Plot of Precipitation",
        ylab="Precipitation Value")

  # Part b.
sd(clouds$unseeded.clouds)

  # Part c.
sd(bootstrap(clouds$unseeded.clouds, sd, B = 2000))

  # Part d.
sd(bootstrap(clouds$unseeded.clouds, mad, B = 2000))

  # Part g.
c = sum(clouds$unseeded.clouds == 40)
x = sum(clouds$unseeded.clouds > 40)
n = length(clouds$unseeded.clouds)

binom.test(x,n-c,alt="g")

  # Part h.
t.test(clouds$unseeded.clouds)
wilcox.test(clouds$unseeded.clouds, conf.int = T)

rbind(0:26, round(pbinom(0:26,size=26,p=0.5),3))
sort(clouds$unseeded.clouds)

1 - pbinom(16,25,0.5)
pbinom(8,25,0.5)

# Exercise 5.3

  # Part a.
data53 = scan('newcomb.txt')
data53a = data53[1:20]
data53b = data53[21:66]
summary(data53a)
summary(data53b)
par(mfrow=c(1,1), pty="s")
boxplot(data53a, data53b, main = "Boxplot first 20 points and last 46", names = c('frist20','last46')) 
par(mfrow=c(1,2), pty="s")
hist(data53a, xlim = c(-50,50), ylim = c(0,20), col = 'red', nclass = 20, main = "Histogram first 20 points")
hist(data53b, xlim = c(-50,50), ylim = c(0,20), col = 'blue', main = "Histogram last 46 points")
ks.test(data53a, data53b, alternative = "two.sided")
wilcox.test(data53a,data53b ,alternative = "two.sided")

  # Part b.
wilcox.test(data53, mu = 24.8332, conf.int = 0.05)

mylist <- list(stud_no = c(2669137 , 2671011),
               "1_a_pval" = pval_a, '1_a_reject' = reject_a,"1_b_pval" = pval_b, 
               '1_b_reject' = reject_b,"1_c_pval" = pval_c, '1_c_reject' = reject_c,
               "2_b_sd" = sd(clouds$unseeded.clouds),
               "2_d_mad" = sd(bootstrap(clouds$unseeded.clouds, mad, B = 2000)),
               "2_h_CI_sign" = c(26.3 , 147.8),
               "2_h_CI_wilcox" = c(36.69997 , 187.24999),
               "2_h_CI_t" = c(52.09509 , 277.02876)
               )

save(mylist, file="C:/Users/david/OneDrive/VU/Statistical Data Analysis/Assignment 5/myfile5_39.RData")

