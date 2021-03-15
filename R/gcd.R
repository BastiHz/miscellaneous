
# Greatest common divisor with Euclid's algorithm
# Arguments a and b must be vectors of the same length.
gcd <- function(a, b) {
    stopifnot(length(a) == length(b))
    for (i in seq_along(a)) {
        a_i <- a[i]
        b_i <- b[i]
        while (b_i != 0) {
            temp = b_i
            b_i = a_i %% b_i
            a_i = temp
        }
        a[i] <- a_i
    }
    a
}

gcd(60, 48) == 12
gcd(60, 39) == 3
gcd(c(60, 60), c(48, 39)) == c(12, 3)


is_coprime <- function(a, b) {
    gcd(a, b) == 1
}

is_coprime(60, 48) == FALSE
is_coprime(13, 17) == TRUE
is_coprime(c(60, 13), c(48, 17)) == c(FALSE, TRUE)


# Approximating pi using the probability that two random integers are coprime.
rand_max <- 1e6
n <- 1e5
a <- sample(rand_max, n, replace = TRUE)
b <- sample(rand_max, n, replace = TRUE)
coprime <- is_coprime(a, b)
n_coprime <- cumsum(coprime)
pi_estimate <- sqrt(6 * (1:n) / n_coprime)
tail(pi_estimate)

par(las = 1)
plot(
    pi_estimate,
    type = "l",
    xlab = "n",
    ylab = expression(pi*"-estimate"),
)
abline(h = pi, lty = 2)
axis(2, pi, expression(pi))
