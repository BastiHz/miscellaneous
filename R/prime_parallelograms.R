# last half of this video: https://www.youtube.com/watch?v=pAMgUB51XZA


library(magrittr)


foo <- function(x) {
    x %>%
        intToBits() %>%
        as.integer() %>%
        `[`(1:tail(which(. == 1), 1)) %>%
        paste(collapse = "") %>%
        strtoi(2) %>%
        prod(-1) %>%
        sum(x)
}

sieve_of_eratosthenes <- function(n) {
    primes <- rep(TRUE, n)
    primes[1] <- FALSE
    for (i in 2:ceiling(sqrt(n))) {
        if (primes[i]) {
            primes[seq(i + i, n, i)] <- FALSE
        }
    }
    seq_len(n)[primes]
}

p <- sieve_of_eratosthenes(200000)
y <- sapply(p, foo)
i <- seq_along(p)  # In the video he plots the index of the primes on the x axis
plot(i, y, pch = 20, cex = 0.3, las = 1)


plot(p, y, pch = 20, cex = 0.3, las = 1)
abline(v = 2^(1:17), h = 0)
