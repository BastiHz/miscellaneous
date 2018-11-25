# Sebastian Henz (2018)
# License: MIT (see file LICENSE for details)
#
# Inspired by this Numberphile video:
# https://www.youtube.com/watch?v=kbKtFN71Lfs


chaos_polygon <- function(n = 3, move_distance = 0.5,
                          num_points = 10000, plot = TRUE, ...) {
    # Start with the corners of a regular polygon. Place a tracepoint somewhere
    # between those. Each step of the iteration choose a random corner and move
    # the tracepoint some distance towards that. Vary the number of corners and
    # the move distance to achieve different effects.
    # n = Number of corners.
    # ... = Further arguments which are passed to plot()

    radians <- seq(0, by = 2 * pi / n, length.out = n)
    # Rotate the angles so that the bottom edge is horizontal. It just looks
    # nicer that way:
    radians <- radians - (pi / n) * (n - 1)
    corners <- data.frame(x = numeric(n), y = numeric(n))
    for (i in seq_len(n)) {
        corners$x[i] <- sin(radians[i])
        corners$y[i] <- cos(radians[i])
    }

    # This version of the code below came to be after many iterations of
    # preformance improvements. At first I did everything using data frames
    # which took around 1 s for 1000 points. But using vectors like shown here
    # and creating the result data frame afterwards makes everything extremely
    # fast. Now it runs 1 million points in less than half a second. The new
    # bottleneck with so many points is the plot() function.
    trace_x <- corners$x[1]
    trace_y <- corners$y[1]
    result_x <- result_y <- numeric(num_points)
    targets <- sample(1:n, num_points, replace = TRUE)
    ct_x <- corners$x[targets]
    ct_y <- corners$y[targets]
    for (i in seq_len(num_points)) {
        trace_x <- trace_x - (trace_x - ct_x[i]) * move_distance
        trace_y <- trace_y - (trace_y - ct_y[i]) * move_distance
        result_x[i] <- trace_x
        result_y[i] <- trace_y
    }
    result <- data.frame(x = result_x, y = result_y)

    if (!plot) return(result)
    opar <- par(no.readonly = TRUE)
    on.exit(par(opar))
    par(mar = rep(0, 4))
    plot(result, pch = 20, axes = TRUE, ann = FALSE, asp = 1, ...)
}

# chaos_polygon()
# chaos_polygon(num_points = 50000, cex = 0.2)
# chaos_polygon(n = 4, move_distance = 0.55, num_points = 20000, cex = 0.25)
# chaos_polygon(n = 5, move_distance = 0.62, num_points = 30000, cex = 0.2)
# chaos_polygon(n = 6, move_distance = 2/3, cex = 0.2, num_points = 50000)
# chaos_polygon(n = 4, type = "l", num_points = 1000)
# chaos_polygon(30, move_distance = 0.91, num_points = 2000)
# chaos_polygon(2, move_distance = 0.7)
