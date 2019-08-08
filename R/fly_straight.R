# first half of this video: https://www.youtube.com/watch?v=pAMgUB51XZA

get_gcd <- function(a, b) ifelse (b==0, a, get_gcd(b, a %% b))

n_max <- 1000
a <- c(1, 1, rep(NA, n_max-2))
for (n in 2:n_max) {
    gcd <- get_gcd(n, a[n-1])
    if (gcd == 1) {
        a[n] <- a[n-1] + n + 1
    } else {
        a[n] <- a[n-1] / gcd
    }
}
n <- 0:n_max
a <- c(1, a)
plot(n, a, pch = 20, las = 1)
