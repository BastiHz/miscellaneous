# Sebastian Henz (2018)
# License: MIT (see file LICENSE for details)
#
# This simulates the effect that can be seen when multiple pendulumns hanging
# in a line swing at different frequencies. Most of the time the pattern seems
# chaotic but at some points the lines converge.
#
# TODO:
# - Add a vertical component so it looks more like a pendulum.
# - Show them stacked vertically.


import sys
import math

import pygame as pg


pg.init()

FPS = 60
SCREEN_SIZE = (800, 600)
BACKGROUND_COLOR = (60, 60, 60)
CIRCLE_COLOR = (200, 200, 200)
SCREEN_CENTER = (SCREEN_SIZE[0] // 2, SCREEN_SIZE[1] // 2)
CIRCLE_RADIUS = 20
MAX_DISPLACEMENT_X = 300
MAX_ANGLE = math.pi * 2
CYCLE_DURATION = 60  # seconds
MIN_SWINGS_PER_CYCLE = 25
MAX_SWINGS_PER_CYCLE = 35


class Pendulum:
    def __init__(self, position, angular_frequency, angle=0):
        self.position = position
        self.angular_frequency = angular_frequency
        self.angle = angle
        
    def update(self, dt):
        self.angle = (self.angle + self.angular_frequency * dt) % MAX_ANGLE
        self.position[0] = (
            SCREEN_CENTER[0] + MAX_DISPLACEMENT_X * math.cos(self.angle)
        )
    
    def draw(self):
        pg.draw.circle(
            screen, 
            CIRCLE_COLOR, 
            (int(self.position[0]), int(self.position[1])), 
            CIRCLE_RADIUS
        )


pendulums = []
for n in range(MIN_SWINGS_PER_CYCLE, MAX_SWINGS_PER_CYCLE + 1):
    pendulums.append(Pendulum(
        position = [SCREEN_CENTER[0] + MAX_DISPLACEMENT_X, SCREEN_CENTER[1]],
        angular_frequency = n / CYCLE_DURATION * math.pi * 2
    ))

clock = pg.time.Clock()
screen = pg.display.set_mode(SCREEN_SIZE)
running = True

while running:
    dt = clock.tick(FPS) / 1000  # seconds
    for event in pg.event.get():
        if event.type == pg.QUIT:
            running = False
        elif event.type == pg.KEYDOWN:
            if event.key == pg.K_ESCAPE:
                running = False
    
    screen.fill(BACKGROUND_COLOR)
    for p in pendulums:
        p.update(dt)
        p.draw()
    pg.display.update()
    
pg.quit()
sys.exit()
