
# Gute Präsentation von Jenny Bryan:
# https://youtu.be/7oyiPBjLAWY?t=2120  Zeit 35:20
# Ein bisschen Text zum Thema:
# https://www.cyclismo.org/tutorial/R/objectOriented.html


# S3 Klassen --------------------------------------------------------------

blubb <- list(first = "one", second = "two", third = "three")
class(blubb) <- "hurtz"
blubb

get_first <- function(x) {
    # Ausschnitt aus der ?UseMethod:
    # When a function calling UseMethod("get_first") is applied to an object
    # with class attribute c("hurtz", "waargh"), the system searches for a
    # function called get_first.hurtz and, if it finds it, applies it to the
    # object. If no such function is found a function called get_first.waargh is
    # tried. If no class name produces a suitable function, the function
    # get_first.default is used, if it exists, or an error results.
    UseMethod("get_first", x)
}

get_first.hurtz <- function(x) {
    x$first
}

get_first(blubb)


# Man kann auch vorhandene Funktionen für die neue Klasse einsetzen.
# Falls plot.bar nicht existiert, wird plot.default aufgerufen.
foo <- list(x = -10:10, y = (-10:10)^3)
plot(foo)
class(foo) <- append(class(foo), "bar")
class(foo)
plot.bar <- function(bla, ...) {
    plot(bla$x, bla$y, col = "red", type = "o", ...)
}
plot(foo)
