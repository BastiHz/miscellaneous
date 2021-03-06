
# unit circle:
angle <- seq(0, 2 * pi, length = 100)
x <- cos(angle)
y <- sin(angle)
plot(x, y, asp = 1)
plot(x, y, asp = 1, type = "l")

# Note that there is also the symbols() function in base R.


# with spokes:
segments(0, 0, x, y)

# polygons:
par(mfrow = c(3, 3))
for (i in 3:11) {
  # i + 1 because the last point appears twice
  angle <- seq(0, 2 * pi, length = i + 1)
  x <- cos(angle)
  y <- sin(angle)
  plot(x, y, asp = 1, type = "l", bty = "L", lwd = 2)
}
