# Sebastian Henz (2018)
# License: MIT (see file LICENSE for details)
#
# Numberphile video on sandpiles: https://www.youtube.com/watch?v=1MtEUErz7Gg

library(grid)


sandpile <- matrix(0, nrow = 51, ncol = 51)
sandpile[26, 26] <- 3000

repeat {
    to_topple <- which(sandpile > 3, arr.ind = TRUE)
    if (nrow(to_topple) == 0) break

    sandpile[to_topple] <- sandpile[to_topple] - 4
    rows <- to_topple[, 1]
    cols <- to_topple[, 2]
    neighbors <- data.frame(
        row = c(rows - 1, rows, rows, rows + 1),
        col = c(cols, cols - 1, cols + 1, cols)
    )
    on_the_grid <- (
        neighbors$row > 0 & neighbors$row <= nrow(sandpile) &
        neighbors$col > 0 & neighbors$col <= ncol(sandpile)
    )
    neighbors <- neighbors[on_the_grid, ]
    # The following line eats up all the computation time. How can I improve it?
    neighbors <- as.data.frame(table(neighbors), stringsAsFactors = FALSE)
    neighbors <- do.call(cbind, lapply(neighbors, as.integer))
    sandpile[neighbors[, 1:2]] <- sandpile[neighbors[, 1:2]] + neighbors[, 3]
}

sand_colors <- data.frame(
    num = 0:3,
    color = c("#dbd1b4", "#cabc91", "#baa86f", "#a69150"),
    stringsAsFactors = FALSE
)

color_matrix <- matrix(sand_colors$color[match(sandpile, sand_colors$num)],
                       nrow = nrow(sandpile), ncol = ncol(sandpile))
grid.raster(color_matrix, interpolate = FALSE)
