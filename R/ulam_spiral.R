# https://en.wikipedia.org/wiki/Ulam_spiral


library(grid)


sidelength <- 1001  # must be > 1 and odd
n <- sidelength^2
print(n)
m <- matrix(NA, nrow = sidelength, ncol = sidelength)

x <- y <- integer(n)
x[1] <- y[1] <- (sidelength + 1) / 2
x_diff <- y_diff <- integer(n)
s <- 1
k <- 2
for (i in seq_len(sidelength - 1)) {
    to <- k + i * 2 - 1
    x_diff[k:to] <- rep(c(1, 0) * s, each = i)
    y_diff[k:to] <- rep(c(0, -1) * s, each = i)
    k <- to + 1
    s <- s * -1
}
x_diff[k:n] <- 1
y_diff[k:n] <- 0
for (i in 2:n) {
    x[i] <- x[i-1] + x_diff[i]
    y[i] <- y[i-1] + y_diff[i]
}
m[cbind(y, x)] <- 1:n

# sieve of eratosthenes
primes <- rep(TRUE, n)
primes[1] <- FALSE
for (i in 2:sidelength) {
    if (primes[i]) {
        primes[seq(i + i, n, i)] <- FALSE
    }
}
primes <- seq_len(n)[primes]
m <- matrix(m %in% primes, nrow = sidelength)

grid.newpage()
grid.raster(!m, interpolate = FALSE)
