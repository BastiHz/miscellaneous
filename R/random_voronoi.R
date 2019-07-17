# Using randomness to create a voronoi diagram.


num_centerpoints <- 9
num_tracepoints <- 50000

centerpoints <- data.frame(
    x = runif(num_centerpoints, 0, 1),
    y = runif(num_centerpoints, 0, 1),
    colors = rainbow(num_centerpoints),
    stringsAsFactors = FALSE
)
tracepoints <- data.frame(
    x = runif(num_tracepoints, 0, 1),
    y = runif(num_tracepoints, 0, 1)
)
tracepoint_colors_idx <- numeric(num_tracepoints)
for (i in seq_len(nrow(tracepoints))) {
    tracepoint_colors_idx[i] <- which.min(
        (tracepoints$x[i] - centerpoints$x)^2 +
        (tracepoints$y[i] - centerpoints$y)^2
    )
}

par(pty = "s")
plot(NA, NA, xlim = c(0, 1), ylim = c(0, 1), las = 1)
points(tracepoints, pch = 16,
       col = centerpoints$colors[tracepoint_colors_idx])
points(y ~ x, centerpoints, bg = centerpoints$colors, col = "black",
       pch = 21, cex = 1.5, lwd = 3)
