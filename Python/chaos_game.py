"""Sebastian Henz (2018)
License: MIT (see file LICENSE for details)

Inspired by this Numberphile video:
https://www.youtube.com/watch?v=kbKtFN71Lfs

This is the animated companion script to chaos_game.R. It only does
the polygons and not the fern.
"""

import math
import os
import random
import pygame as pg


# The important variables:
N = 6
MOVE_DISTANCE = 2/3


DISPLAY_WIDTH = 800
DISPLAY_HEIGHT = 800

os.environ["SDL_VIDEO_CENTERED"] = "1"
pg.init()
display = pg.display.set_mode((DISPLAY_WIDTH, DISPLAY_HEIGHT))
clock = pg.time.Clock()
canvas = display.copy()

FPS = 30
CORNER_COLOR = (100, 100, 100)
POINT_COLOR = (200, 200, 200)
TRACEPOINT_COLOR = (200, 0, 0)
MARGIN = 20
POINT_RADIUS = 3
CORNERS = []
for i in range(N):
    angle = i * 2 * math.pi / N
    angle = angle - (math.pi / N) * (N - 1)
    x = math.sin(angle)
    y = math.cos(angle)
    x = (DISPLAY_WIDTH / 2 - MARGIN) * x + DISPLAY_WIDTH / 2
    y = (DISPLAY_HEIGHT / 2 - MARGIN) * y + DISPLAY_HEIGHT / 2
    y = DISPLAY_HEIGHT - y
    CORNERS.append((int(x), int(y)))
for position in CORNERS:
    pg.draw.circle(canvas, CORNER_COLOR, position, POINT_RADIUS)
x, y = CORNERS[0]

limit_fps = True
running = True
while running:
    if limit_fps:
        clock.tick(FPS)
    else:
        clock.tick()
    
    for event in pg.event.get():
        if event.type == pg.QUIT:
            running = False
        elif event.type == pg.KEYDOWN:
            if event.key == pg.K_ESCAPE:
                running = False
            elif event.key == pg.K_SPACE:
                limit_fps = not limit_fps
                
    target = random.choice(CORNERS)
    x = int(x - (x - target[0]) * MOVE_DISTANCE)
    y = int(y - (y - target[1]) * MOVE_DISTANCE)
    pg.draw.circle(canvas, POINT_COLOR, (x, y), POINT_RADIUS)
    display.blit(canvas, (0, 0))
    pg.draw.circle(display, TRACEPOINT_COLOR, (x, y), POINT_RADIUS)
    pg.display.update()
