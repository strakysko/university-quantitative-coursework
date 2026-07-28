`lognorm <- function(n, mu, sigma) {
  set.seed(20220286)
  
  x = rlnorm(n, meanlog = mu, sdlog = sigma)
  
  quants = quantile(x, c(0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 1))
  loc = mean(x)
  spread = sd(x)
  stud_no = 2669137
  
  mylist = c(quants, loc, spread, stud_no)
  
  save(mylist, file="C:/Users/david/OneDrive/VU/Statistical Data Analysis/Assignment 1/myfile1_75.RData")
}

lognorm(100, 1, 1)


bin <- function(n, size, prob) {
  x = rbinom(n, size, prob)
  u = seq(min(x), max(x)+1, 1)
  v = dpois(u, size*prob)
  
  hist(x, prob=T, breaks=0:(max(x)+1)-0.001, 
       xlab = "Number of Successes", main = "Histogram of Binomial Distribution")
  lines(u, v, type="s", col="red")
}

par(mfrow=c(2,2))
bin(100, 1000, 0.01)
bin(100, 1000000, 0.00001)
bin(100, 1000, 0.01)
bin(100000, 1000, 0.01)


par(mfrow=c(1,1))

covid_data = read.csv("C:/Users/david/OneDrive/VU/Statistical Data Analysis/Assignment 1/owid_covid_data_selection.csv", header=TRUE)
covid_data_asia = covid_data[covid_data$continent == 'Asia',]
partly_vac = covid_data_asia$partly_vacc

length(partly_vac)
summary(partly_vac)
sd(na.omit(partly_vac))
var(na.omit(partly_vac))
IQR(na.omit(partly_vac))

par(mfrow=c(1,1))

hist(partly_vac, xlab = "Partly Vaccinated People (%)",
     ylab = "Number of Countries",
     main = "Histogram of Partly Vaccinated Countries in Asia")

boxplot(partly_vac, main="Boxplot of Partly Vaccinated People in Asia (in %)", col=c("grey",2))

plot(ecdf(covid_data_asia$partly_vacc), col="grey", main="Empirical Cum. Distribution Function for Asia",
     xlab="Partly Vaccinated People (in %)", xlim=c(0,100))


bivariate <- cbind(covid_data_asia$partly_vacc, covid_data_asia$human_development_index)

colMeans(bivariate, na.rm=T)
bivariate_woNA <- bivariate[-which(is.na(covid_data_asia$human_development_index)
                | is.na(covid_data_asia$partly_vacc)), ]
cov(bivariate_woNA)
cor(bivariate_woNA)
cor(bivariate_woNA, method="spearman")
cor(bivariate_woNA, method="kendall")

plot(bivariate_woNA, xlab = "Partly Vaccinated People (%)", 
     ylab = "HDI", main = "Scatter Plot for Asia")
