# Using base R determine the width of the legend and resize the right plot
# margin accordingly.


# Sample data:
x <- 1:10
y <- rnorm(10)

# Open an empty plot device.
pdf(file = NULL)

# Plot the plot:
# There doesn't need to be any data. It is only important that the dimensions
# are correct. Don't use log axes here because they change the coordinates
# returned by the legend. You can still use log axes later when creating the
# final plot including the fitted margins.
plot(x, y)

# Make the legend:
# Place it anywhere, it doesn't matter (here it is topright). Assign the
# coordinates returned by the legend. Remember to use the same text and symbols
# as in the real plot.
legend_info <- legend(
  "topright",
  legend = c("foo", "bar"),
  pch = c(16, 17),
  col = c("red", "blue")
)

# Calculate the legend width:
# This must be done while the plot device is still open. Otherwise the
# coordinates won't be calculated correctly.
legend_left <- legend_info$rect$left
legend_right <- legend_left + legend_info$rect$w
legend_width <- (grconvertX(legend_right, to = "inches")
                 - grconvertX(legend_left, to = "inches"))

# Close the plot:
dev.off()


# Make the plot, this time for real:
png("test.png", width = 600, height = 500)

# Resize the margin where the legend sould be drawn:
omai <- par("mai")
mai <- omai
mai[4] <- legend_width + 0.1
par(mai = mai)

# Plot the data:
plot(x, y)

# Draw the legend: Get the coordinates of the right and top borders using
# par("usr"). Use xpd = NA to suppress clipping of the axis.
legend(
  x = par("usr")[2],
  y = par("usr")[4],
  legend = c("foo", "bar"),
  pch = c(16, 17),
  col = c("red", "blue"),
  xpd = NA
)
# If one of the axes is to be drawn logarithmically, for example the x-axis,
# then you have to change the coordinates on the log axis to 10^par("usr")[2].

# Close the plot:
dev.off()


# Todo: Does this still work if the resolution, point size or other parameters
# are changed, either in the call to png or plot?
