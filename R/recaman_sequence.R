# Entry in the On-Line Encyclopedia of Integer Sequences:
# https://oeis.org/A005132
#
# Numberphile video:
# https://www.youtube.com/watch?v=FGC5TdIiT9U
#
#
# Copyright (C) 2019 Sebastian Henz
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.


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
    angle <- seq(0, pi, length.out = n_approx)
    lines(
        x + radius * cos(angle) * side,
        y + radius * sin(angle) * side,
        ...
    )
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
