# Zum einfügen von Trennlinien zwischen Plots bei Nutzung von par(mfrow=). Mit
# layout() wäre es auch möglich und vermutlich eleganter. Aber ich bevorzuge
# meistens par(mfrow=), weil ich mich da besser auskenne.


par(mfrow = c(2, 2))
for (i in 1:4) {
    plot(rnorm(10), rnorm(10))
}
par(mfrow = c(1, 1), mar = c(0, 0, 0, 0), new = TRUE)
plot(0.5, xaxs = "i", yaxs = "i", ann = FALSE, axes = FALSE, type = "n",
     xlim = c(0, 1), ylim = c(0, 1))
# 0 = links oder unten, 1 = rechts oder oben.
abline(h = 0.5, xpd = NA)

dev.off()
