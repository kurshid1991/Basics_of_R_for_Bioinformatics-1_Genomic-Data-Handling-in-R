#######################################################################
########################## DATA GENERATION ############################
#######################################################################

set.seed(123)

# Generate sample data
x <- rnorm(50)              # Normal distribution
y <- rnorm(50)

#######################################################################
########################## HISTOGRAM ##################################
#######################################################################

# Basic histogram
hist(x, main = "Basic Histogram", col = "lightblue")

# Customized histogram
hist(x,
     main = "Customized Histogram",
     col = "orange",
     border = "black",
     xlab = "Values", #labels X axis
     ylab = "Frequency", #labels Y axis
     breaks = 10) #controls the number of bins (range of values)

# Histogram with density curve

hist(x,
     main = "customised histogram",
     col = "pink",
     border = "black",
     xlab = "time",
     ylab = "density",
     breaks = 10,
     probability = TRUE)

lines(density(x), lwd = 2, col = "blue")


# Histogram with mean line
hist(x,
     col = "grey",
     main = "Histogram with Mean Line")
abline(v = mean(x), col = "red", lwd = 2
abline(v = median(x), col = "red", lwd = 2
