#######################################################################
########################## DATA GENERATION ############################
#######################################################################

set.seed(42)

# Generate sample data
x <- rnorm(50)              # Normal distribution
y <- rnorm(50)



#######################################################################
########################## SCATTER PLOT ###############################
#######################################################################



# Basic scatter plot
plot(x, y,
     main = "Basic Scatter Plot",
     xlab = "X values",
     ylab = "Y values",
     pch = 19,
     col = "blue")

# Scatter plot with regression line
plot(x, y,
     main = "Scatter Plot with Regression Line",
     xlab = "X values",
     ylab = "Y values",
     pch = 19,
     col = "darkgreen")
abline(lm(y ~ x), col = "red", lwd = 2)

plot(x, y,
     main = "Scatter Plot with Correlation",
     xlab = "X values",
     ylab = "Y values",
     pch = 19,
     col = "purple")

correlation <- cor(x, y)

text(max(x), max(y),
     labels = paste("Correlation =", round(correlation, 2)),
     col = "red",
     pos = 2)  # position left of the point

# Scatter with mean lines
plot(x, y,
     main = "Scatter Plot with Mean Lines",
     xlab = "X values",
     ylab = "Y values",
     pch = 19,
     col = "brown")
abline(v = mean(x), h = mean(y),
       col = "blue", lwd = 2, lty = 2)
