# Sebastian Henz (2018)
# License: MIT (see file LICENSE for details)
#
# This is an attempt to write a self-learning tic-tac-toe program. I got the
# idea from this video by Matt Parker:
# https://www.youtube.com/watch?v=R9c-_neaxeU

# TODO: Make the game recognise rotated and mirrored boards.


win_lines <- list(c(1, 4, 7), c(2, 5, 8), c(3, 6, 9), c(1, 2, 3), c(4, 5, 6),
                  c(7, 8, 9), c(1, 5, 9), c(3, 5, 7))
player_characters <- c("X", "O")
free_position_character <- "."
start_prob <- 3  # number of balls in a box for each free position at start
win_reward <- 3
draw_reward <- 1
loss_punishment <- -1
max_prob <- 30  # maximum number of
long_memory <- list()  # all states and their probability vectors


detect_win <- function(board, current_character) {
    for (win_l in win_lines) {
        if (all(board[win_l] == current_character)) {
            return(TRUE)
        }
    }
    return(FALSE)
}


player_move <- function(board, player_character, short_memory) {
    while (TRUE) {
        new_position <- as.numeric(readline(">>> "))

        if (new_position < 1 | new_position > 9) {
            print("Invalid position. Must be between 1 and 9 inclusive. Try again.")
            next
        } else if (board[new_position] != free_position_character) {
            print("Please pick an empty position.")
            next
        } else {
            break
        }
    }

    board_str <- paste(board, collapse = "")
    short_memory[board_str] <- new_position

    board[new_position] <- player_character

    return(list(board = board, short_memory = short_memory))
}


ai_move <- function(board, ai_character, short_memory, long_memory) {
    # convert board state to string
    # check if board state is in memory (todo: considering rotation and mirroring)
    # make a move
    # commit move to short term memory

    free_positions <- which(board == free_position_character)
    board_str <- paste(board, collapse = "")

    # on.exit({print(board_str); print(free_positions)
    # print(long_memory[[board_str]])})  # DEBUG

    # If there is only one position left then take that position. This case is
    # necessary because sample() behaves differently when given only one integer
    # to sample from.
    if (length(free_positions) == 1) {
        new_position <- free_positions
    } else if (board_str %in% names(long_memory)) {
        new_position <- sample(free_positions, size = 1,
                               prob = long_memory[[board_str]])
    } else {
        new_position <- sample(free_positions, size = 1)
    }

    board[new_position] <- ai_character
    short_memory[board_str] <- new_position
    return(list(board = board, short_memory = short_memory))
}


learn <- function(long_memory, short_memory, game_result) {
    # If position is already in long_memory adjust the probrabilities.
    # If not then make new probabilities equal and adjust them.
    # The vectors in long_memory are the probabilities of the free positions.

    for (board_str in names(short_memory)) {
        position <- short_memory[[board_str]]
        free_positions <- which(
            unlist(strsplit(board_str, "")) == free_position_character
        )
        position_idx <- which(free_positions == position, arr.ind = TRUE)

        if (!(board_str %in% names(long_memory))) {
            long_memory[[board_str]] <- rep(start_prob, length(free_positions))
        }

        if (game_result == "win") {
            long_memory[[board_str]][position_idx] <-
                long_memory[[board_str]][position_idx] + win_reward
        } else if (game_result == "loss") {
            long_memory[[board_str]][position_idx] <-
                long_memory[[board_str]][position_idx] + loss_punishment
        } else if (game_result == "draw") {
            long_memory[[board_str]][position_idx] <-
                long_memory[[board_str]][position_idx] + draw_reward
        }

        if (all(long_memory[[board_str]] == 0)) {
            long_memory[[board_str]] <- long_memory[[board_str]] + 1
        } else if (any(long_memory[[board_str]] > max_prob)) {
            long_memory[[board_str]][long_memory[[board_str]] > max_prob] <-
                max_prob
        }
    }
    return(long_memory)
}


play <- function(player_character, long_memory, silent = FALSE, auto = FALSE) {
    # player_character must be either "X" or "O". "X" goes first.
    short_memory_1 <- numeric()  # all moves of player 1 in the current game
    short_memory_2 <- numeric()  # all moves of player 2 in the current game
    game_result <- NULL

    if (!(player_character %in% player_characters)) {
        stop("Incorrect player character. Must be either 'X' or 'O'")
    }

    ai_character <- player_characters[player_characters != player_character]

    board <- matrix(rep(".", 9), nrow = 3)
    rownames(board) <- rep("", 3)
    colnames(board) <- rep("", 3)

    current_player <- 0  # 0 or 1
    current_character <- "X"  # X goes first
    winner <- NULL

    if (!silent) print(board, quote = FALSE)

    while (TRUE) {
        if (current_character == player_character) {
            if (auto) {
                return_list <- ai_move(board, player_character,
                                       short_memory_1, long_memory)
                board <- return_list$board
                short_memory_1 <- return_list$short_memory
            } else {
                return_list <- player_move(board, player_character,
                                           short_memory_1)
                board <- return_list$board
                short_memory_1 <- return_list$short_memory
            }
        } else {
            return_list <- ai_move(board, ai_character, short_memory_2,
                                   long_memory)
            board <- return_list$board
            short_memory_2 <- return_list$short_memory
        }

        if (!silent) print(board, quote = FALSE)

        if (detect_win(board, current_character)) {
            winner <- current_character
            break
        }
        if (all(board != ".")) break

        current_player <- (current_player + 1) %% 2
        current_character <- player_characters[current_player + 1]
    }

    if (is.null(winner)) {
        if (!silent) print("Draw.")
        ai_result <- "draw"
        player_1_result <- "draw"
    } else {
        if (!silent) print(paste(current_character, "wins!"))
        if (current_character == ai_character) {
            ai_result <- "win"
            player_1_result <- "loss"
        } else {
            ai_result <- "loss"
            player_1_result <- "win"
        }
    }

    long_memory <- learn(long_memory, short_memory_1, player_1_result)
    long_memory <- learn(long_memory, short_memory_2, ai_result)

    return(long_memory)
}


auto_play <- function(long_memory, num_games) {
    for (i in seq_len(num_games)) {
        if (i %% 2 == 0) {
            player_char <- "X"
        } else {
            player_char <- "O"
        }
        long_memory <- play(player_char, long_memory, TRUE, TRUE)
    }
    return(long_memory)
}


write_memory <- function(memory, filename = "memory.txt") {
    memory_df <- data.frame(
        board_strings = names(memory),
        probabilities = sapply(memory, function(x) paste(x, collapse = ","))
    )
    write.table(memory_df, filename, row.names = FALSE)
}


load_memory <- function(filename = "memory.txt") {
    memory <- read.table(filename, header = TRUE, stringsAsFactors = FALSE)
    memory_list <- strsplit(memory$probabilities, ",", fixed = TRUE)
    memory_list <- lapply(memory_list, as.numeric)
    names(memory_list) <- memory$board_strings
    memory_list
}


# play ----------------------------------------------------------------------------------------

# 1, 4, 7
# 2, 5, 8
# 3, 6, 9

long_memory <- load_memory()

# long_memory <- list()
# long_memory <- play("O", long_memory)
# long_memory <- start_auto_play(long_memory, 10000)

# write_memory(long_memory)
