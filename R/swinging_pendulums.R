# This simulates the effect that can be seen when multiple pendulumns hanging
# in a line swing at different frequencies. Most of the time the pattern seems
# chaotic but at some points the lines converge.
#
#
# Copyright (C) 2019 Sebastian Henz
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.


x_max <- 2 * pi
stepsize <- pi / 1000
x <- seq(0, x_max, stepsize)
frequency <- 25:35  # number of periods between 0 and 2*pi

plot(
    NA,
    NA,
    xlim = c(0, 2 * pi),
    ylim = c(-1, 1),
    las = 1,
    axes = FALSE,
    ann = FALSE,
    asp = 0.25  # reduced aspect ratio to make the effect more visible
)
axis(
    1,
    at = seq(0, 2 * pi, pi / 2),
    labels = paste(seq(0, 2, 0.5), "\u03C0")
)
for (f in frequency) {
    lines(x, sin(x * f))
}
