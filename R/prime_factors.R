# TODO: Put this into my R package BastiHzR

get_prime_factors <- function(n) {
    stopifnot("n must be integer" = n %% 1 == 0)
    prime_factors <- integer()
    i <- 2L
    while (n > 1) {
        while (n %% i == 0) {
            prime_factors <- c(prime_factors, i)
            n <- n %/% i
        }
        i <- i + 1L
    }
    prime_factors
}

p <- get_prime_factors(123456789L)
typeof(p)
