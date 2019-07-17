# https://www.youtube.com/watch?v=XXjlR2OK1kM
# This code is really inefficient. But it's late and I'm tired.

lim <- 10^4
x <- seq(1, lim)
first_digit <- as.integer(substr(as.character(x), 1, 1))
prop <- mean_prop <- data.frame(
    prop_1 = numeric(lim),
    prop_2 = numeric(lim),
    prop_3 = numeric(lim),
    prop_4 = numeric(lim),
    prop_5 = numeric(lim),
    prop_6 = numeric(lim),
    prop_7 = numeric(lim),
    prop_8 = numeric(lim),
    prop_9 = numeric(lim)
)
for (i in 1:9) {
    for (k in seq_len(lim)) {
        prop[k, i] <- mean(first_digit[1:k] == i)
        mean_prop[k, i] <- mean(prop[1:k, i])
    }
}

par(mfrow = c(2, 1), las = 1)
rb_col <- rainbow(9)
plot(NA, NA, xlim = c(1, lim * 1.5), ylim = c(0, 1), log = "x", xlab = "x",
     ylab = "proportion", main = "proportion of first letters over 1:x")
for (i in 1:9) {
    lines(x, prop[, i], col = rb_col[i])
}
legend("topright", legend = 1:9, col = rb_col, lty = 1, cex = 0.75)

plot(NA, NA, xlim = c(1, lim * 1.5), ylim = c(0, 1), log = "x", xlab = "x",
     ylab = "proportion", main = "average proportion over 1:x")
for (i in 1:9) {
    lines(x, mean_prop[, i], col = rb_col[i])
}
legend("topright", legend = 1:9, col = rb_col, lty = 1, cex = 0.75)


# only for one number which is faster and can therefore go higher:
lim <- 10^5
x <- seq(1, lim)
first_digit <- as.integer(substr(as.character(x), 1, 1))
prop_1 <- mean_prop_1 <- numeric(lim)
for (i in seq_len(lim)) {
    prop_1[i] <- mean(first_digit[1:i] == 1)
    mean_prop_1[i] <- mean(prop_1[1:i])
}
par(mfrow = c(1, 1))
plot(x, mean_prop_1, log = "x", type = "l")
mean(mean_prop_1)
