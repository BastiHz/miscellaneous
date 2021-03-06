# Diese kleine Funktion hilft, wenn ich sehr oft
# png(...)
# par(...)
# plot(...)
# dev.off()
# mit den gleichen Argumenten für png und par schreibe. Mit Vorsicht verwenden!


png_wrapper <- function(filename, plots) {
  on.exit(dev.off())
  png(filename, width = 800, height = 600, res = 96)
  par(mfrow = c(1, 2))  # always after opening the device!
  plots
}



# usage:

x <- 1:10
y <- rnorm(length(x))

png_wrapper("test.png", {
  plot(x, y, pch = 16, col = "deepskyblue")
  plot(x, y, pch = 15, col = "forestgreen")
})


# Es ist nicht notwendig immer
# opar <- par(no.readonly = TRUE)
# on.exit(par(opar))
# zu schreiben, da das von dev.off erledigt wird.
