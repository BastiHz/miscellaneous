# Sebastian Henz (2018)
# License: MIT (see file LICENSE for details)
#
# Simulate the interactions of predator and prey populations.
#
# Predators lose one energy each movement step. If energy falls to 0 they die.
# If it rises above threshold they produce one offspring. Each prey eaten
# increases the energy. Movement is random but neighboring prey is preferred.
# Prey gains one energy each movement step and produces one offspring if energy
# is above threshold.


library(dplyr)


get_neighbors <- function(x, y, world_size) {
  neighbors <- tibble(x = rep(c(x - 1, x, x + 1), 3),
                      y = rep(c(y - 1, y, y + 1), each = 3))
  neighbors <- neighbors[!(neighbors[, "x"] == x & neighbors[, "y"] == y), ]
  neighbors[neighbors == 0] <- world_size
  neighbors[neighbors == world_size + 1] <- 1
  neighbors
}


simulate_predator_prey <- function(filename,
                                   world_size,
                                   steps,
                                   prop_predator = 0.1,
                                   prop_prey = 0.4,
                                   energy_threshold = 10,
                                   feed_energy = 3) {
  # world_size: sidelength of square world
  # steps: number of simulation steps
  # prop_predator: initial proportion of predator animals between 0 and 1
  # prop_prey: initial proportion of prey animals between 0 and 1
  # energy_threshold: amount of energy required to reproduce
  # feed_energy: amount of energy per prey eaten

  # The gif needs the data in matrix:
  world_m <- matrix(nrow = world_size, ncol = world_size)
  world_storage <- array(0, c(world_size * 2, world_size * 2, steps))
  # world_storage sidelength is doubled to make the pixels in the
  # animation bigger

  color_codes <- c("empty" = 0, "prey" = 0.5, "predator" = 1)

  world <- tibble(
    x = rep(1:world_size, world_size),
    y = rep(1:world_size, each = world_size),
    animal = sample(c("predator", "prey", "empty"),
                    world_size ^ 2,
                    prob = c(prop_predator, prop_prey,
                             1 - prop_predator - prop_prey),
                    replace = TRUE),
    energy = sample(1:energy_threshold, world_size ^ 2, replace = TRUE)
  )

  for (s in 1:steps) {
    for (r in 1:nrow(world)) {
      if (world$animal[r] == "empty") {
        next
      } else if (world$animal[r] == "prey") {
        neighbor_coords <- get_neighbors(world$x[r], world$y[r], world_size)
        neighbors <- filter(world,
                            paste(x, y) %in% paste(neighbor_coords$x,
                                                   neighbor_coords$y),
                            animal == "empty")
        if (nrow(neighbors) == 0) next
        target <- neighbors[sample(1:nrow(neighbors), 1), ]
        target_index <- which(world$x == target$x & world$y == target$y)
        world$animal[target_index] <- "prey"
        if (world$energy[r] >= energy_threshold) {
          world$energy[target_index] <- world$energy[r] %/% 2
          world$energy[r] <- energy_threshold %/% 2
        } else {
          world$energy[target_index] <- world$energy[r] + 1
          world$animal[r] <- "empty"
        }
      } else {
        neighbor_coords <- get_neighbors(world$x[r], world$y[r], world_size)
        neighbors <- filter(world, paste(x, y) %in% paste(neighbor_coords$x,
                                                          neighbor_coords$y))
        target_animal <- if ("prey" %in% neighbors$animal) "prey" else "empty"
        neighbors <- filter(neighbors, animal == target_animal)
        if (nrow(neighbors) == 0) next
        target <- neighbors[sample(1:nrow(neighbors), 1), ]
        target_index <- which(world$x == target$x & world$y == target$y)
        world$animal[target_index] <- "predator"
        if (world$energy[r] >= energy_threshold) {
          world$energy[target_index] <- world$energy[r] %/% 2
          world$energy[r] <- energy_threshold %/% 2
        } else {
          world$energy[target_index] <- world$energy[r] - 1
          world$animal[r] <- "empty"
        }
      }
    }

    for (r in 1:nrow(world)) {
      world_m[world$y[r], world$x[r]] <- color_codes[world$animal[r]]
    }

    world_storage[, , s] <- world[rep(1:world_size, each = 2),
                                  rep(1:world_size, each = 2)]

    # Shuffle the world to randomize the order of moves:
    world <- world[sample(nrow(world)), ]
  }

  write.gif(world_storage, filename, col = "jet", delay = 5)
}


simulate_predator_prey("predator_prey.gif", 50, 50, 0.1, 0.5)

# test data:
# world_size <- 50
# steps <- 50
# prop_predator <- 0.1
# prop_prey <- 0.5
# energy_threshold <- 10


# todo:
# variables:
#   - different energy threshold for predators and prey? lower for prey?
#   - let the predators die when out of energy
# other:
#   - gif
#   - time series plot
#   - movement (torus)
#
