# Read in data and look at top six rows to see information. 
housing <- read.csv("data/landdata-states.csv")
head(housing[1:5])

# Make sure you are using ggplot2 
library(ggplot2)
library(dplyr)

# Create a Histogram of the Home.Value column with the housing data. 
ggplot(data = housing) +
  geom_histogram(mapping = aes(Home.Value))

# Create a plot that focus on MA and TX with the x-axis the Date and the y-axis Home.Value
ggplot(subset(housing, State %in% c("MA", "TX"))) +
  geom_point(mapping = aes(x = Date, y = Home.Value))

housing.2001 <- subset(housing, Date == 2001.25) 

# Create a scatter plot that's x-axis is Land.Value and y-axis is Structure.Cost
ggplot(data = housing) +
  geom_point(mapping = aes(x = Land.Value, y = Structure.Cost))

# Now pass in the Land.Value in log form for the same graph 
ggplot(data = housing) +
  geom_point(mapping = aes(x = log10(Land.Value), y = Structure.Cost))

# Why would you want to log() one of the axis.  Look at the two different graphs to help you answer. 

housing.2001$pred.SC <- predict(lm(Structure.Cost ~ log(Land.Value), data = housing.2001))

# Pass the same graph into a value p1 
 p1 <- ggplot(data = housing.2001, aes(x = log10(Land.Value), y = Structure.Cost))

# Now add coloring to the Home.Value and line that is the pred.SC colun in the data frame
p1 + geom_point(aes(color = Home.Value)) +
     geom_line(aes(y = pred.SC))

# Do the same as before but instead of adding the prediction line try out the geo_smooth() funciton 
p1 + geom_point(aes(color = Home.Value)) +
  geom_smooth()

# Finally in order to not just look at a bunch of points with no context we will add the different state names 
# Make sure the label is the state and the size is 3 
p1 +
  geom_text(aes(label=State), size = 3)