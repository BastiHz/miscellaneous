
# Wenn ich Plots für Publikationen erstelle, möchte ich die Schriftgrößen und
# Punktgrößen kontrollieren. Das geschieht mit cex und den cex.*-Parametern.
# Wenn ich aber die Größen über verschiedene Bilder gleich halten will und diese
# Bilder aus unterschiedlich vielen Plots bestehen, dann muss ich cex manuell
# kontrollieren. Am besten suche ich mir einen Wert für cex aus, der bei allen
# Bildern gut aussieht gebe das dann jedes mal in par() ein. Die anderen
# cex.*-Parameter sind vielfache von cex, also muss ich die nicht noch extra
# anpassen.

par("cex")  # 1
par(mfrow = c(2, 2))
par("cex")  # 0.83
par(mfrow = c(2, 2), cex = 1)
par("cex")  # 1
