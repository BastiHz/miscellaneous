# Sebastian Henz (2018)
# License: MIT (see file LICENSE for details)
#
# Entry in the On-Line Encyclopedia of Integer Sequences:
# https://oeis.org/A005132
#
# Numberphile video:
# https://www.youtube.com/watch?v=FGC5TdIiT9U


recaman <- function(n) {
    recaman_seq <- integer(n + 1)
    if (n == 0) return(recaman_seq)
    for (i in 1:n) {
        last <- recaman_seq[i]
        difference <- last - i
        if (difference <= 0 | difference %in% recaman_seq) {
            recaman_seq[i + 1] <- last + i
        } else {
            recaman_seq[i + 1] <- difference
        }
    }
    recaman_seq
}


plot_semicircle <- function(x, y, radius, n_approx, side, ...) {
    # Draw a semicircle into an existing plot. The semicircle begins and
    # ends at the horizontal line.
    # x, y: Circle center.
    # radius: Circle radius.
    # n_approx: Number of points to approximate the circle.
    # side: Either 1 or -1. Draw above horizontal if positive
    #     and below if negative.
    # ...: Further arguments to be passed to lines().
    rs <- seq(0, pi, length.out = n_approx)
    xc <- x + radius * cos(rs) * side
    yc <- y + radius * sin(rs) * side
    lines(xc, yc, ...)
}


plot_recaman_semicircles <- function(recaman_seq, res_circles = 100) {
    # res_circles: Resolution of the semicircles, number of points
    #     to approximate circle shape.
    radii <- abs(diff(recaman_seq)) / 2
    centers <- (head(recaman_seq, -1) + recaman_seq[-1]) / 2
    side <- rep(c(-1, 1), length.out = length(recaman_seq) - 1)

    opar <- par(no.readonly = TRUE)
    on.exit(par(opar))
    par(mar = rep(0, 4))
    plot(
        NA,
        NA,
        xlim = c(0, max(recaman_seq)),
        ylim = c(-max(radii), max(radii)),
        asp = 1,
        bty = "n",
        ann = FALSE,
        axes = FALSE
    )
    for (i in seq_along(radii)) {
        plot_semicircle(centers[i], 0, radii[i], res_circles, side[i])
    }
}


r <- recaman(99)
r
plot_recaman_semicircles(r)
