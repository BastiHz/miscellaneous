# Sebastian Henz (2018)
# License: MIT (see file LICENSE for details)
#
# Inspired by this Numberphile video:
# https://www.youtube.com/watch?v=kbKtFN71Lfs

# TODO: Implement Barnsley's Fern


chaos_polygon <- function(n = 3, move_distance = 0.5,
                          num_points = 1000, plot = TRUE, ...) {
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

    result <- data.frame(
        x = numeric(num_points),
        y = numeric(num_points)
    )
    targets <- sample(1:n, num_points, replace = TRUE)
    tracepoint <- corners[1, ]
    for (i in seq_len(num_points)) {
        tracepoint <-
            tracepoint -
            (tracepoint - corners[targets[i], ]) *
            move_distance
        result[i, ] <- tracepoint
    }
    if (!plot) return(result)
    opar <- par(no.readonly = TRUE)
    on.exit(par(opar))
    par(mar = rep(0, 4))
    plot(result, pch = 20, axes = TRUE, ann = FALSE, asp = 1, ...)
}

# chaos_polygon()
# chaos_polygon(n = 4, move_distance = 0.6)
# chaos_polygon(n = 5, move_distance = 0.62, num_points = 3000)
# chaos_polygon(n = 6, move_distance = 2/3)
# chaos_polygon(n = 4, type = "l")
# chaos_polygon(30, move_distance = 0.91, num_points = 2000)
# chaos_polygon(2, move_distance = 0.7)
