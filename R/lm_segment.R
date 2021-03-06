# Plotte eine Regressionslinie aber nur im Wertebereich von x. Darüber hinaus
# sollte man nämlich keine einzeichnen.

# TODO: Es wäre wohl besser, wenn die Funktion einfach das lm als input akzeptieren würde. 
# Dann als output eine Liste mit x und y Komponente, damit man sowas schreiben kann:
# mod <- lm(bla ~ blubb)
# lines(lm_segment(mod), col = foo, lwd = bar)
# Am besten dann die Funktion auch anders benennen. Sie soll nichts von selbst plotten, 
# sondern wirklich nur die Koordinaten berechnen.
# Denke daran den Dateinamen entsprechend anzugleichen.


lm_line <- function(x, y, plot = TRUE, ...) {
    mod <- lm(y ~ x)
    xrange <- range(x)
    yrange <- predict(mod, data.frame(x = xrange))
    out <- list(x = xrange, y = yrange)
    if (plot) {
        segments(xrange[1], yrange[1], xrange[2], yrange[2], ...)
        invisible(out)
    }
    return(out)
}


foo <- sample(1:10) + rnorm(10, 0, 0.1)
bar <- runif(10, -2, 2) - foo
plot(foo, bar)
abline(lm(bar ~ foo))
baz <- lm_line(foo, bar, col = "red", lwd = 2)
