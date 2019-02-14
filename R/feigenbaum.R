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



# https://www.youtube.com/watch?v=ETrYE4MdoLQ


f <- function(lambda, precision = 5, max_iterations = 10000, start = 0.5,
              max_return = 500) {
    # lambda: A number in the interval [0, 4].
    # precision: The number of decimal places the numbers are rounded to.
    # max_iterations: The maximum number of iterations before the search for
    #   cycles is aborted.
    # start: The starting value.
    # max_return: The maximum length of the vector returned.

    n <- numeric(max_iterations)
    x <- round(start, precision)
    x_rounded <- round(x, precision)
    n[1] <- x_rounded

    if (max_iterations <= 2) {
        stop("max_iterations must be > 2.")
    }
    if (lambda < 0 | lambda > 4) {
        stop("lambda must be between 0 and 4 inclusive.")
    }

    for (i in 2:max_iterations) {
        x <- lambda * x * (1 - x)
        x_rounded <- round(x, precision)
        if (x_rounded == 0) return(0)
        if (x_rounded %in% n) {
            n <- n[n > 0]
            n <- n[which(n == x_rounded):length(n)]
            if (length(n) <= max_return) return(n)
            break
        }
        n[i] <- x_rounded
    }
    from <- length(n) - max_return + 1
    return(n[from:length(n)])
}


# I initialize x and y empty and cut off the rest later to increase the speed.
len <- 1000
max_return <- 500
x <- y <- numeric(len * max_return)
i <- 1
for (lambda in seq(3.4, 4, length.out = len)) {
    cycle <- f(lambda, max_return = max_return)
    len_cycle <- length(cycle)
    j <- seq(i, i + len_cycle - 1)
    x[j] <- rep(lambda, len_cycle)
    y[j] <- cycle
    i <- tail(j, 1) + 1
}
keep <- seq(1, max(which(x > 0)))
x <- x[keep]
y <- y[keep]
length(x)
plot(x, y, pch = ".")
