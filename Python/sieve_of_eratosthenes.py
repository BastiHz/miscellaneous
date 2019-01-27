"""List all prime numbers up to n.


Copyright (C) 2019 Sebastian Henz

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <https://www.gnu.org/licenses/>.
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
