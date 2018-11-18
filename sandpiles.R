# Sebastian Henz (2018)
# License: MIT (see file LICENSE for details)

# Numberphile video on sandpiles: https://www.youtube.com/watch?v=1MtEUErz7Gg
# This is the version with the infinite grid mentioned at the end of the video.
# Lots of sand is put in the center and then the rules are applied until there
# are no more stacks to topple.


library(grid)


sidelength <- 31  # must be an odd number
height <- 30000

n <- sidelength ^ 2
sandpile <- matrix(0, nrow = sidelength, ncol = sidelength)
center <- ceiling(sidelength / 2)
sandpile[center, center] <- height
left_border <- seq(1, sidelength)
increase_by <- 10  # must be an even number

repeat {
    to_topple <- which(sandpile > 3)
    if (length(to_topple) == 0) break

    if (any(to_topple %in% left_border)) {
        # Increase the size of the pile
        new_sidelength <- sidelength + 2 * increase_by
        new_pile <- matrix(0, nrow = new_sidelength, ncol = new_sidelength)
        middle <- seq(increase_by + 1, length.out = sidelength)
        coords <- cbind(
            row = rep(middle, sidelength),
            col = rep(middle, each = sidelength)
        )
        new_pile[coords] <- sandpile
        sandpile <- new_pile
        sidelength <- new_sidelength
        n <- sidelength ^ 2
        left_border <- seq(1, sidelength)
        to_topple <- which(sandpile > 3)
    }

    sandpile[to_topple] <- sandpile[to_topple] - 4

    top_neighbors <- to_topple - 1
    bottom_neighbors <- to_topple + 1
    left_neighbors <- to_topple - sidelength
    right_neighbors <- to_topple + sidelength

    sandpile[top_neighbors] <- sandpile[top_neighbors] + 1
    sandpile[bottom_neighbors] <- sandpile[bottom_neighbors] + 1
    sandpile[left_neighbors] <- sandpile[left_neighbors] + 1
    sandpile[right_neighbors] <- sandpile[right_neighbors] + 1
}

sand_colors <- data.frame(
    num = 0:3,
    color = c("#fbf3ed", "#f2d7c4", "#e8bb9a", "#df9f71"),
    stringsAsFactors = FALSE
)
color_matrix <- matrix(sand_colors$color[match(sandpile, sand_colors$num)],
                       nrow = nrow(sandpile), ncol = ncol(sandpile))
png(paste0("sandpile_", height, ".png"),
    width = ncol(sandpile), height = nrow(sandpile))
grid.raster(color_matrix, interpolate = FALSE)
dev.off()
