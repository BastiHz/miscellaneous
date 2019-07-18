# Works best with a console that can be cleared by cat("\f"). Otherwise it
# may not look right.
# Make sure that the console is big enough to display the whole matrix plus
# two rows and columns.
# Press ESC to exit the loop.

width <- 30
height <- 18

# rules:
b <- c(3)  # a cell is born if it has this many neighbors
s <- c(2, 3)  # a cell survives if it has this many neighbors

# glider:
# m <- matrix(0, nrow = height, ncol = width)
# m[c(2, height+3, 2*height+1, 2*height+2, 2*height+3)] <- 1

# random:
m <- matrix(sample(c(T, F), width * height, replace = TRUE), nrow = height)

shift_right <- c(width, 1:(width-1))
shift_down <- c(height, 1:(height-1))
shift_left <- c(2:width, 1)
shift_up <- c(2:height, 1)

while (TRUE) {
    neighbors <- m[, shift_right] +
        m[, shift_left] +
        m[shift_up, ] +
        m[shift_down, ] +
        m[shift_up, shift_right] +
        m[shift_down, shift_right] +
        m[shift_up, shift_left] +
        m[shift_down, shift_left]
    m <- m & neighbors %in% s | !m & neighbors %in% b
    m_visible <- ifelse(m, "#", " ")
    m_visible <- cbind("|", m_visible, "|")
    m_visible <- rbind(
        c(" ", rep("—", width), " "),  # "—" is an em dash
        m_visible,
        c(" ", rep("—", width), " ")
    )
    cat("\f")  # clear console, does not work in Rgui on Windows
    write.table(
        m_visible,
        row.names = FALSE,
        col.names = FALSE,
        quote = FALSE
    )
    Sys.sleep(0.1)
}
