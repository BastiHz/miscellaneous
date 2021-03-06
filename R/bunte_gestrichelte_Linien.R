x <- seq(0, 2 * pi, length.out = 100)
y <- sin(x)

# png("foo.png", width = 1024, height = 768, type = "cairo", res = 96)
pdf("foo.pdf")
plot(NA, NA, xlim = range(x), ylim = range(y))
lines(x, y, lty = "44", col = "red", lwd = 2)
lines(x, y, lty = "4c", col = "green", lwd = 2)  # hexadezimale Werte
legend(
    "bottomleft",
    legend = c("", ""),
    lty = c(NA, "44"),
    pch = c(NA, NA),
    bty = "n",
    col = c(NA, "red")
)
legend(
    "bottomleft",
    legend = c("", ""),
    lty = c(NA, "4c"),
    pch = c(NA, NA),
    bty = "n",
    col = c(NA, "green")
)
legend(
    "bottomleft",
    legend = c("was anderes", "sin"),
    lty = c(1, NA),
    pch = c(16, NA),
    bty = "n"
)
dev.off()

# Sieht gut aus, wenn ich es als pdf ausgebe. Oder als png mit type = "cairo.
# Ohne Kantenglättung stimmen die Abstände nicht ganz. Der Trick ist hier bei
# "lty". Es gibt auch noch "lend", falls benötigt.
# In der Legende funktioniert das etwas anders: Hierfür müssen zwei Legenden
# übereinander geplottet werden.


# TODO: Schreibe eine Funktion, die automatisch die drei Legenden erzeugt.
