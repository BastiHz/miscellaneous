# Another attempt at a self learning tic tac toe program. This time it's much
# simpler. It just records all past game states and assigns values to their
# outcome.
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



# TODO: Make the game recognise rotated and mirrored boards.
# Mirroring can happen horizontally, vertically and diagonally on both diagonals!


free_space <- "."
symbols <- c("X", "O")
scores <- c(win = 1, draw = 0, loss = -1)
win_lines <- list(c(1, 4, 7), c(2, 5, 8), c(3, 6, 9),
                  c(1, 2, 3), c(4, 5, 6), c(7, 8, 9),
                  c(1, 5, 9), c(3, 5, 7))

board_to_str <- function(board) paste(board, collapse = "")
print_board <- function(board) print(board, quote = FALSE)

memory <- data.frame(
    state = board_to_str(board),
    next_position = 1:9,
    score = 0,
    stringsAsFactors = FALSE
)



check_win <- function(board, symbol) {
    for (line in win_lines) {
        if (all(board[line] == symbol)) {
            return(TRUE)
        }
    }
    return(FALSE)
}



learn <- function() {
    board <- matrix(rep(".", 9), nrow = 3)
    memory <- data.frame(
        state = board_to_str(board),
        next_position = 1:9,
        score = 0,
        stringsAsFactors = FALSE
    )

    end_state <- NA
    while (is.na(end_state)) {
        current_symbol_idx <- 1  # X goes first
        current_symbol <- symbols[current_symbol_idx]






        current_symbol_idx <- current_symbol_idx %% 2 + 1
    }


}








# play <- function(player_symbol) {
#     if (!(human_symbol %in% human_symbol)) {
#         stop("Incorrect human character. Must be either 'X' or 'O'")
#     }
#
#     ai_symbol <- symbols[symbols != human_symbol]
#
#
#     board <- matrix(rep(".", 9), nrow = 3)
#     rownames(board) <- rep("", 3)
#     colnames(board) <- rep("", 3)
#
#
#     current_player <- match(human_symbol, symbols)
#
#
#
#
#
#     current_player <- current_player %% 2 + 1
#
# }





