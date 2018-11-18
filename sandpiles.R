# Sebastian Henz (2018)
# License: MIT (see file LICENSE for details)

# Numberphile video on sandpiles: https://www.youtube.com/watch?v=1MtEUErz7Gg
# This is the version with the infinite grid mentioned at the end of the video.
# Lots of sand is put in the center and then the rules are applied until there
# are no more stacks to topple.

# TODO:
# - Increase the size of the matrix each time the sand reaches the edge.
# - Make it faster so it can handle more sand.


library(grid)


sandpile <- matrix(0, nrow = 101, ncol = 101)
sandpile[51, 51] <- 15000


repeat {
    to_topple <- which(sandpile > 3, arr.ind = TRUE)
    if (nrow(to_topple) == 0) break

    sandpile[to_topple] <- sandpile[to_topple] - 4
    rows <- to_topple[, "row"]
    cols <- to_topple[, "col"]
    neighbors <- cbind(
        row = c(rows - 1, rows, rows, rows + 1),
        col = c(cols, cols - 1, cols + 1, cols)
    )
    on_the_grid <- (
        neighbors[, "row"] > 0 & neighbors[, "row"] <= nrow(sandpile) &
        neighbors[, "col"] > 0 & neighbors[, "col"] <= ncol(sandpile)
    )
    neighbors <- neighbors[on_the_grid, ]

    # The following step consumes all the computation time. I tried to improve
    # it but this seems to be the fastest I can make it.
    for (i in 1:nrow(neighbors)) {
        position <- neighbors[i, , drop = FALSE]
        sandpile[position] <- sandpile[position] + 1
    }
}

sand_colors <- data.frame(
    num = 0:3,
    color = c("#fbf3ed", "#f2d7c4", "#e8bb9a", "#df9f71"),
    stringsAsFactors = FALSE
)
color_matrix <- matrix(sand_colors$color[match(sandpile, sand_colors$num)],
                       nrow = nrow(sandpile), ncol = ncol(sandpile))
grid.raster(color_matrix, interpolate = FALSE)
