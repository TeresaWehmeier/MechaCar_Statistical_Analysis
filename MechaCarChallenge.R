## Deliverable 1

# step 3 - load dplyr
library(dplyr)

# step 4 read in machacar.csv to data frame
mechacar_mpg <- read.csv('C:/Users/Teresa/Class/MechaCar_Statistical_Analysis/R_Analysis/MechaCar_mpg.csv',check.names = F, stringsAsFactors = F)

# step 5 perform linear regression using lm() for all six variables
lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + AWD + ground_clearance,data=mechacar_mpg)

# Step 6 use summary function to determine p-value and r-squared valued for linear regression model
summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + AWD + ground_clearance,data=mechacar_mpg))

## Deliverable 2

# step 2 - read in Suspension_Coil.csv
suspension_coil <- read.csv('C:/Users/Teresa/Class/MechaCar_Statistical_Analysis/R_Analysis/Suspension_Coil.csv',check.names = F, stringsAsFactors = F)

# step 3 - create a total_summary dataframe using the summarize() function to get mean, median, variance, and SD of suspension coils PSI Column
total_summary <- suspension_coil %>% summarize(Mean=mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI), .groups = 'keep')


# step 4 create lot_summary dataframe using group_by() and summarize() functions to group by lot
lot_summary <- suspension_coil %>% group_by(Manufacturing_Lot) %>% summarize(Mean=mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI), .groups = 'keep')

library(tidyverse)


## Deliverable 3 t-test
# Step 1 - perform a t-test.
t.test(suspension_coil$PSI,mu=1500)

# step 2 - perform t-test by lot
lot1 <- subset(suspension_coil, Manufacturing_Lot=="Lot1")
lot2 <- subset(suspension_coil, Manufacturing_Lot=="Lot2")
lot3 <- subset(suspension_coil, Manufacturing_Lot=="Lot3")

t.test(lot1$PSI,mu=1500)
t.test(lot2$PSI,mu=1500)
t.test(lot3$PSI,mu=1500)

## deeper dive - create box and whisker plot by lot
ggplot(suspension_coil, aes(Manufacturing_Lot, PSI)) +
  geom_boxplot()


