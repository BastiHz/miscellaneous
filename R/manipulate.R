# Beispielcode zur Demonstration des tollen Pakets "manipulate".
# Funktioniert nur mit RStudio.

library(manipulate)

normal_distribution <- function(mu, sigma, color, solid_line) {
    curve(
        dnorm(x, mu, sigma), 
        from = -10, 
        to = 10, 
        col = color, 
        lwd = 2, 
        n = 1000, 
        lty = if (solid_line) 1 else 2
    )
}

manipulate(
    normal_distribution(mu, sigma, color, solid_line), 
    mu = slider(-5, 5, step = 0.5, initial = 0),
    sigma = slider(0.5, 5, step = 0.5, initial = 1),
    color = picker("black", "red", "green", "blue"),
    solid_line = checkbox(TRUE, "solid line")
)
