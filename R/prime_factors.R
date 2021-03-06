# TODO: Put this into my R package BastiHzR

get_prime_factors <- function(n) {
    stopifnot("n must be integer" = n %% 1 == 0)
    prime_factors <- numeric()
    i <- 2
    while (n > 1) {
        while (n %% i == 0) {
            prime_factors <- c(prime_factors, i)
            n <- n / i
        }
        i <- i + 1
    }
    if (length(prime_factors) == 0) {
        return(n)
    }
    prime_factors
}

p <- get_prime_factors(123456789)
p
prod(p)

p <- get_prime_factors(1000001)
p
prod(p)

p <- get_prime_factors(1000003)  # prime number
p
prod(p)

get_prime_factors(2**30)
