
# see Numberphile video:
# https://www.youtube.com/watch?v=FGC5TdIiT9U

racaman <- function(n) {
  # n: length of sequence
  if (n <= 1) return(0)
  visited <- numeric(n)
  visited[1] <- c(0)
  last <- 0
  step <- 1
  for (i in 2:n) {
    if (((last - step) < 0) | ((last - step) %in% visited)) {
      last <- last + step
    } else {
      last <- last - step
    }
    visited[i] <- last
    step <- step + 1
  }
  visited
}


plot_half_circle <- function(x, y, r, n_steps, side, ...) {
  # teilweise von StackOverflow
  rs <- seq(0, pi, length.out = n_steps)
  xc <- x + r * cos(rs) * side
  yc <- y + r * sin(rs) * side
  lines(xc, yc, ...)
}


plot_racaman_circles <- function(n_racaman, n_steps_circles = 100) {
  # n_racaman: length of sequence
  # n_steps_circles: resolution of the semicircles
  x <- racaman(n_racaman)
  radii <- abs(diff(x)) / 2
  centers <- (head(x, -1) + tail(x, -1)) / 2
  up_down <- rep(c(-1, 1), length.out = n_racaman - 1)

  opar <- par(no.readonly = TRUE)
  on.exit(par(opar))
  par(mar = rep(0, 4))
  plot(NULL, NULL, xlim = c(0, max(x)), ylim = c(-max(radii), max(radii)),
       asp = 1, bty = "n", xlab = "", ylab = "", axes = FALSE)
  for (i in seq_along(radii)) {
    plot_half_circle(centers[i], 0, radii[i], n_steps_circles, up_down[i])
  }
}

plot_racaman_circles(50)
racaman(140)

n <- 1000
plot(0:(n-1), racaman(n))




