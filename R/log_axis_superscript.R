# Logarithmische Achsenbeschriftung mit hochgestellten Zahlen, korrekten Minuszeichen und die kleinste Zahl ist durch "0" ersetzt.
# Das mit den Minuszeichen scheint nicht so recht zu funktionieren, wenn ich als png exportiere. Und ich glaube bei pdf ist es unnötig.

x_labels <- as.expression(c(
    0,
    sapply(
        sub("-", "\u2212", as.character(log10(as.numeric(c(0.01, 0.1, 1, 10, 100))))),
        function(x) bquote(10^.(x)),
        USE.NAMES = FALSE
    )
))

# Und dann in axis() als Wert für das "label" Argument einstzen.
