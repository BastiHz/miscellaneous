# Exploring an mathematical problem seen in this Numberphile video:
# The Square-Sum Problem https://www.youtube.com/watch?v=G1m7goLCJDY
#
#
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
