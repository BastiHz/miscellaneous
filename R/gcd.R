
# Greatest common divisor with Euclid's algorithm
# If the gcd is 1 then a and b are coprime, i.e. they don't have common factors except 1.
gcd <- function(a, b) {
    stopifnot(
        "a must not be 0" = a != 0,
        "b must not be 0" = b != 0
    )
    while (b != 0) {
        temp = b
        b = a %% b
        a = temp
    }
    a
}

gcd(60, 48) == 12
