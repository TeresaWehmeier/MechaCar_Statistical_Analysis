
demo_table <- read.csv(file='01_Demo/demo.csv', check.names = F, stringsAsFactors = F)

library(jsonlite)

?fromJSON()

demo_table[3,3]

demo_table2 <- fromJSON(txt='01_Demo/demo.json')

demo_table$'Vehicle_Class'[2]

filter_table <- demo_table2[demo_table2$price > 10000,]

?subset()

filter_table2 <- subset(demo_table2, price > 10000 & drive == '4wd' & 'clean' %in% title_status) # filter by price and drivetrain

?sample()

sample(c('cow','deer','pig','chicken','duck','sheep','dog'), 4)

num_rows <- 1:nrow(demo_table)

sample_rows <- sample(num_rows,3)

demo_table[sample_rows,]

demo_table[sample(1:nrow(demo_table),2),]

library(tidyverse)
?mutate()

demo_table <- demo_table %>% mutate(Mileage_per_year=Total_Miles/(2020-Year), IsActive=TRUE)# add columns to original data

summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer), .groups = 'keep') #create summary table

summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer),Maximum_Price=max(price), Num_Vehicles=n(), .groups = 'keep')

?gather()

demo_table3 <- read.csv(file='01_Demo/demo2.csv', check.names = F, stringsAsFactors = F)

long_table <- demo_table3 %>% gather(key="Metric", value="Score", buying_price:popularity)

?spread()

## spread(data, key, value, fill = NA, convert = FALSE, drop = TRUE, sep = NULL)

wide_table <- long_table %>% spread(key="Metric", value="Score")

table <- demo_table3[,(colnames(wide_table))]
all.equal(table, wide_table)

head(mpg)

plt <- ggplot(mpg,aes(x=class)) # import dataset into ggplot2
plt + geom_bar() # plot a bar chart

mpg_summary <- mpg %>% group_by(manufacturer) %>% summarize(Vehicle_Count=n(), .groups = 'keep') # create summary table
plt <- ggplot(mpg_summary,aes(x=manufacturer, y=Vehicle_Count))
plt + geom_col()

plt + geom_col() + xlab('Manufacturing Company') + ylab('Number of Vehicles in Dataset') +
  theme(axis.text.x=element_text(angle=45,hjust=1))

mpg_summary <- subset(mpg, manufacturer=='toyota') %>% group_by(cyl) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep')
plt <- ggplot(mpg_summary,aes(x=cyl,y=Mean_Hwy))
plt + geom_line()

plt + geom_line() + scale_x_discrete(limits=c(4,6,8)) + scale_y_continuous(breaks=c(15:30))

plt <- ggplot(mpg,aes(x=displ,y=cty))
plt + geom_point() + xlab('Engine Size (L)') + ylab('City Fuel-Efficiency (MPG)')


plt <- ggplot(mpg,aes(x=manufacturer,y=hwy))
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust = 1))

## Heat map by vehicle class
mpg_summary <- mpg %>% group_by(class,year) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary, aes(x=class,y=factor(year),fill=Mean_Hwy))
plt + geom_tile() + labs(x="Vehicle Class",y="Vehicle Year",fill="Mean Highway (MPG)") #create heatmap with labels

## Heat map by model 
mpg_summary <- mpg %>% group_by(model,year) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary, aes(x=model,y=factor(year),fill=Mean_Hwy)) #import dataset into ggplot2
plt + geom_tile() + labs(x="Model",y="Vehicle Year",fill="Mean Highway (MPG)") + theme(axis.text.x = element_text(angle=90,hjust=1,vjust=.5)) #rotate x-axis labels 90 degrees

## Layered plot mapping
plt <- ggplot(mpg,aes(x=manufacturer,y=hwy)) #import dataset into ggplot2
plt + geom_boxplot() + #add boxplot
  theme(axis.text.x=element_text(angle=45,hjust=1)) + #rotate x-axis labels 45 degrees
  geom_point() #overlay scatter plot on top

# complementary plot mapping
mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine=mean(displ), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary,aes(x=class,y=Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size=4) + labs(x="Vehicle Class",y="Mean Engine Size") #add scatter plot

# geom_errorbar() create upper and lowe boundaries to scatter plot with standard deviation

mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine=mean(displ),SD_Engine=sd(displ), .groups = 'keep')
plt <- ggplot(mpg_summary,aes(x=class,y=Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size=4) + labs(x="Vehicle Class",y="Mean Engine Size") + #add scatter plot with labels
  geom_errorbar(aes(ymin=Mean_Engine-SD_Engine,ymax=Mean_Engine+SD_Engine)) #overlay with error bars

# Faceting - facet()
mpg_long <- mpg %>% gather(key='MPG_Type', value='Rating',c(cty,hwy))# convert to long format
head(mpg_long)

# 15.3.7 visualize fuel efficiency ratings by mfg
plt <- ggplot(mpg_long,aes(x=manufacturer, y=Rating,color=MPG_Type)) # import dataset
plt + geom_boxplot() + theme(axis.text.x = element_text(angle=45,hjust = 1)) # add boxplot with labels

?facet_wrap()

plt <- ggplot(mpg_long,aes(x=manufacturer, y=Rating,color=MPG_Type)) # import dataset
plt + geom_boxplot() + facet_wrap(vars(MPG_Type)) +
    theme(axis.text.x = element_text(angle=45,hjust = 1), legend.position = 'none') +# add boxplot with labels
    xlab('Manufacturer')

# 15.4.4 qualitative test for normality
ggplot(mtcars,aes(x=wt)) + geom_density() # visualize distribution using density plot

# 15.4.4 quantitative test for normality
?shapiro.test()

shapiro.test(mtcars$wt) # if p-value is > 0.05 the data is considered normally distributed

?sample_n()

ggplot(mtcars,aes(x=wt)) + geom_density() # visualize distribution using density plot

# 15.6.1 sample testing
population_table <- read.csv(file='01_Demo/used_car_data.csv', check.names = F,stringsAsFactors = F) #import data
plt <- ggplot(population_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualized ditribution using density plot

# use population to create a sample visual
sample_table <- population_table %>% sample_n(50) # randomly sample 50 datasets
plt <- ggplot(sample_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() # visualize distribution using density plot

#15.6.2 one sample t test
?t.test()

t.test(log10(sample_table$Miles_Driven),mu=mean(log10(population_table$Miles_Driven)))

# 15.6.3 two sample t test
sample_table <- population_table %>% sample_n(50) #generate 50 randomly sampled data points
sample_table2 <- population_table %>% sample_n(50) #generate another 50 random samples

t.test(log10(sample_table$Miles_Driven), log10(sample_table2$Miles_Driven)) # compare means of two samples

# 15.6.4 paired t test
mpg_data <- read.csv('01_Demo/mpg_modified.csv') #import data
mpg_1999 <- mpg_data %>% filter(year==1999) #select only data points where year = 1999
mpg_2008 <- mpg_data %>% filter(year==2008) #select only data point where year = 2008

t.test(mpg_1999$hwy,mpg_2008$hwy,paired = T) # compare the mean difference between two samples

#15.6.5 ANOVA must use all data from one dataset
?aov()

mtcars_filt <- mtcars[,c('hp','cyl')] # Filter columns from mtcars dataset
mtcars_filt$cycl <- factor(mtcars_filt$cyl) # convert numberic column to factor

aov(hp ~ cyl, data=mtcars_filt) # compare means across multiple levels

# to get p-value you have to wrap in summary
summary(aov(hp ~ cyl, data=mtcars_filt)) # compare means across multiple levels

#15.7.1 correlation
?cor()

head(mtcars)

plt <- ggplot(mtcars,aes(x=hp,y=qsec)) #import dataset into ggplot2
plt + geom_point() #create scatter plot

cor(mtcars$hp,mtcars$qsec) # calcuate correclation coefficient

used_cars <-read.csv('01_Demo/used_car_data.csv',stringsAsFactors = F) #read in dataset
head(used_cars)
plt <- ggplot(used_cars,aes(x=Miles_Driven,y=Selling_Price)) #import data into ggplot2
plt + geom_point()#create scatter plot

used_matrix <- as.matrix(used_cars[,c('Selling_Price','Present_Price','Miles_Driven')])#convert dataframe to numeric matrix
cor(used_matrix)

#15.7.2 linear regression
?lm()

lm(qsec ~ hp, mtcars) #create linear model

#wrap in summary to get r squared and p-value
summary(lm(qsec ~ hp, mtcars))


model <- lm(qsec~hp,mtcars) # create linear model
yvals <- model$coefficients['hp']*mtcars$hp +
  model$coefficients['(Intercept)'] #determine y-axis values from linear model

plt <-ggplot(mtcars,aes(x=hp,y=qsec)) #import dataset into ggplot2
plt + geom_point() + geom_line(aes(y=yvals), color='red') #plot scatter plot and linear model

#15.7.3 multiple linear regression

mtcars

lm(qsec~mpg + disp + drat + wt + hp,data=mtcars) #generate multiple linear regression model

#15.8.1 chi-square test test for frequency relationship between two categories

?chisq.test()
table(mpg$class,mpg$year) #generate contingency table

tbl <- table(mpg$class,mpg$year) #generate contingency table
chisq.test(tbl) #compare categorical distributions

