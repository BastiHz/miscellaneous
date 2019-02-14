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



f <- function(lambda, precision = 7, max_iterations = 10000, start = 0.5,
              max_return = 500) {
    # lambda: A number in the interval [0, 4].
    # precision: The number of decimal places the numbers are rounded to.
    # max_iterations: The maximum number of iterations before the search for
    #   cycles is aborted.
    # start: The starting value.
    # max_return: The maximum length of the vector returned.

    # Note: The values are rounded at each step. I could improve the
    # algorithm by comparing rounded numbers but keeping x and n precise.

    n <- numeric(max_iterations)
    x <- round(start, precision)
    n[1] <- x

    if (max_iterations <= 2) {
        stop("max_iterations must be > 2.")
    }
    if (lambda < 0 | lambda > 4) {
        stop("lambda must be between 0 and 4 inclusive.")
    }

    for (i in 2:max_iterations) {
        x <- round(lambda * x * (1 - x), precision)
        if (x == 0) return(0)
        if (x %in% n) {
            n <- n[n > 0]
            n <- n[which(n == x):length(n)]
            if (length(n) <= max_return) return(n)
            break
        }
        n[i] <- x
    }
    from <- max_iterations - max_return + 1
    return(n[from:max_iterations])
}

len <- 1000
max_return <- 500
x <- y <- numeric(len * max_return)
i <- 1
for (lambda in seq(3, 4, length.out = len)) {
    cycle <- f(lambda, max_return = max_return)
    len_cycle <- length(cycle)
    j <- i:(i + len_cycle - 1)
    x[j] <- rep(lambda, len_cycle)
    y[j] <- cycle
}
# f(3) springt zwischen 0.668 und 0.664 hin und her. Ich sollte doch lieber
# gerundete Zahlen vergleichen und die precision auf sowas wie 3 festlegen. Bei
# der Darstellung macht mehr Genauigkeit keinen Sinn, wenn man die Punkte
# sowieso nicht voneinander unterscheiden kann. Aber das mit der max_return
# werde ich behalten. Und die eigentliche Berechnung wird noch mit einem
# präzisen x durchgeführt. Aber es wird gerundet, bevor es zu n hinzugefügt
# wird.
# Überlänge von x und y abschneiden.

length(x)
plot(x, y, pch = ".")
