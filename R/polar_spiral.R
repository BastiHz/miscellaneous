# Inspired by the video "Why do prime numbers make these spirals?"
# by 3Blue1Brown on youtube.
# https://www.youtube.com/watch?v=EK32jo7i5LQ


polar_to_cartesian <- function(r, theta) {
    list(
        x = r * cos(theta),
        y = r * sin(theta)
    )
}

par(mar = c(0, 0, 0, 0))

n <- 500
coords_polar <- list(
    r = 1:n,
    theta = 1:n
)
coords_cartesian <- polar_to_cartesian(coords_polar$r, coords_polar$theta)
plot(y~x, coords_cartesian, asp = 1, pch = 20, axes = FALSE, ann = FALSE)
