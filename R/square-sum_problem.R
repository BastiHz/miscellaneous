# Sebastian Henz (2018)
# License: MIT (see file LICENSE for details)
#
# Numberphile - The Square-Sum Problem:
# https://www.youtube.com/watch?v=G1m7goLCJDY&t=0s


# TODO: implement return_all. Currently only the first valid chain is returned.


find_chains <- function(n, return_all = FALSE, print_current_chain = FALSE) {
    # n = length of list, maximum number
    # return_all = Should all valid chains be returned? If FALSE (the default)
    #   return only the first one found.
    # print_current_chain = print the current chain. WARNING, potentially very
    #   large amount of text.

    # Find all relevant square numbers. This is so that they only have to
    # be calculated once:
    squares <- seq_len(floor(sqrt(n + n - 1)))[-1] ^ 2

    # Find all pairwise combinations:
    pairwise_combinations <- list()
    for (i in 1:n) {
        possible_partners <- seq(1, n)[-i]
        partner_sums <- possible_partners + i
        partners_for_i <- possible_partners[partner_sums %in% squares]

        if (length(partners_for_i) > 0) {
            pairwise_combinations[[i]] <- partners_for_i
        } else {
            stop(paste("No partners for the number", i, "found."))
        }
    }

    # Go through the list and build the chain:
    for (i in 1:n) {  # go through the starting positions
        current_chain <- i
        current_num <- i
        dead_end <- 0
        success = FALSE

        while (TRUE) {
            if (length(current_chain) == n) {
                success = TRUE
                break
            }

            next_num <- pairwise_combinations[[current_num]][
                !(pairwise_combinations[[current_num]] %in% current_chain)
                & pairwise_combinations[[current_num]] > dead_end
                ][1]

            if (is.na(next_num)) {
                # go back
                dead_end <- current_num
                current_chain <- current_chain[-length(current_chain)]  # [1]
                if (length(current_chain) == 0) break
                current_num <- current_chain[length(current_chain)]  # [1]
            } else {
                dead_end <- 0
                current_chain <- c(current_chain, next_num)
                current_num <- next_num
            }
            if (print_current_chain) print(current_chain)
        }
        if (success) break
    }

    if (!success) stop("No valid chains found")
    current_chain
}


check_solution <- function(solution) {
    squares <- seq_len(floor(sqrt(max(solution) + max(solution) - 1)))[-1] ^ 2
    sums <- solution[-1] + solution[-length(solution)]
    all(sums %in% squares)
}


foo <- find_chains(30, print_current_chain = TRUE)
foo
check_solution(foo)


# [1] Instead of calling length track the length via a number that you increase
# or decrease when necessary. May be an optimization.
