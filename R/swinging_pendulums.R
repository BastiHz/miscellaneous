# This simulates the effect that can be seen when multiple pendulumns hanging
# in a line swing at different frequencies. Most of the time the pattern seems
# chaotic but at some points the lines converge.


x_max <- 2 * pi
stepsize <- pi / 1000
x <- seq(0, x_max, stepsize)
frequency <- 25:35  # number of periods between 0 and 2*pi

plot(
    NA,
    NA,
    xlim = c(0, 2 * pi),
    ylim = c(-1, 1),
    las = 1,
    axes = FALSE,
    ann = FALSE,
    asp = 0.25  # reduced aspect ratio to make the effect more visible
)
axis(
    1,
    at = seq(0, 2 * pi, pi / 2),
    labels = paste(seq(0, 2, 0.5), "\u03C0")
)
for (f in frequency) {
    lines(x, sin(x * f))
}
