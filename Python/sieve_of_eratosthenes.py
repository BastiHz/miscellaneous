"""Sebastian Henz (2018)
License: MIT (see file LICENSE for details)

List all prime numbers up to n.
"""


def sieve(limit):
    primes = {i for i in range(2, limit + 1)}
    for i in range(2, int(limit ** 0.5) + 1):
        if i in primes:
            for j in range(i + i, limit + 1, i):
                primes.discard(j)
    return primes


n = 1000
primes = sieve(n)
filename = f"primes_up_to_{n}.txt"
with open(filename, "w") as file:
    for p in primes:
        file.write(str(p) + "\n")
print("finished")
