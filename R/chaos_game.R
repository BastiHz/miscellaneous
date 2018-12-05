# Sebastian Henz (2018)
# License: MIT (see file LICENSE for details)
#
# Inspired by this Numberphile video:
# https://www.youtube.com/watch?v=kbKtFN71Lfs
#
# This script includes the polygons made from random points and the fern shown
# in the video. For an animated version of the polygons see chaos_game.py. For
# more info on the fern see https://en.wikipedia.org/wiki/Barnsley_fern


chaos_polygon <- function(n = 3, move_distance = 0.5,
                          num_points = 10000, plot = TRUE, cex = 0.25, ...) {
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
    plot(result, pch = 20, axes = TRUE, ann = FALSE, asp = 1, cex = cex, ...)
}

# chaos_polygon()
# chaos_polygon(num_points = 50000)
# chaos_polygon(n = 4, move_distance = 0.55, num_points = 20000)
# chaos_polygon(n = 5, move_distance = 0.62, num_points = 30000)
# chaos_polygon(n = 6, move_distance = 2/3, num_points = 50000)
# chaos_polygon(n = 4, type = "l", num_points = 1000)
# chaos_polygon(30, move_distance = 0.91, num_points = 2000)
# chaos_polygon(2, move_distance = 0.7)
# chaos_polygon(move_distance = 1.5)
# chaos_polygon(move_distance = 1.99, num_points = 30000)


chaos_fern <- function(num_points = 10000, params = "barnsley",
                       plot = TRUE, cex = 0.25, ...) {
    # params = Either the string "barnsley" or a data frame or matrix
    #     containing the parameters a, b, c, d, e, f and p.
    if ("character" %in% class(params) && params == "barnsley") {
        params <- data.frame(
            a = c(0, 0.85, 0.2, -0.15),
            b = c(0, 0.04, -0.26 , 0.28),
            c = c(0, -0.04 , 0.23, 0.26),
            d = c(0.16, 0.85, 0.22, 0.24),
            e = c(0, 0, 0, 0),
            f = c(0, 1.6, 1.6, 0.44),
            p = c(0.01, 0.85, 0.07, 0.07)
        )
    }
    params <- as.matrix(params)

    tracepoint <- c(0, 0)
    param_index <- sample(
        seq_len(nrow(params)),
        num_points - 1,  # -1 because the first point is always (0, 0)
        replace = TRUE,
        prob = params[, "p"]
    )
    result <- data.frame(
        x = numeric(num_points),
        y = numeric(num_points)
    )
    abcd_index <- match(c("a", "b", "c", "d"), colnames(params))
    ef_index <- match(c("e", "f"), colnames(params))
    for (i in seq_len(num_points - 1)) {
        k <- param_index[i]
        m <- matrix(params[k, abcd_index], nrow = 2, byrow = TRUE)
        tracepoint <- m %*% tracepoint + params[k, ef_index]
        result[i + 1, ] <- tracepoint
    }

    if (!plot) return(result)
    opar <- par(no.readonly = TRUE)
    on.exit(par(opar))
    par(mar = rep(0, 4))
    plot(result, pch = 20, axes = TRUE, ann = FALSE, asp = 1, cex = cex, ...)
}

# chaos_fern(30000, col = "forestgreen")
#
# Different parameter set taken from Wikipedia:
# alternative <- data.frame(
#     a = c(0, 0.95, 0.035, -0.04 ),
#     b = c(0, 0.005, -0.2, 0.2),
#     c = c(0, -0.005, 0.16, 0.16),
#     d = c(0.25, 0.93, 0.04, 0.04),
#     e = c(0, -0.002, -0.09, 0.083),
#     f = c(-0.4, 0.5, 0.02, 0.12),
#     p = c(0.02, 0.84, 0.07, 0.07)
# )
# chaos_fern(20000, params = alternative, col = "forestgreen")
