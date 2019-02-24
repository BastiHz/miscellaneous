# https://en.wikipedia.org/wiki/Lucky_number

# Get all lucky numbers <= n
n <- 1000
lucky_numbers <- seq(1, n, 2)
for (i in 2:n) {
    step <- lucky_numbers[i]
    if (step > length(lucky_numbers)) break
    lucky_numbers <- lucky_numbers[-seq(step, n, step)]
}

lucky_numbers
plot(seq_along(lucky_numbers), lucky_numbers)
