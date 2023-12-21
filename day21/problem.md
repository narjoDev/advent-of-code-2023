# Day 21

## Part One

- Very similar to Conway's game of life
- change start `S` to possibility `O`
- garden `.` next to a possibility `O` becomes `O`
- `O` becomes garden `.`
- execute 64 steps, count possible plots `O`

```
adjacent?(map, row, col)
  for each direction...
  unless edge, return true if O

step(map, steps = 1) executes steps
  for each row index
    for each column index
      if # => #
      if O => .
      if . => check adjacent?(previous map, row, col)
```

## Part Two

### Problem

- Actual steps is not 64 but 26501365
- The map repeats in every direction

#### Observations

- Once a garden tile is tagged, it will blink off and on every turn:

```
...
.O.
...

.O.
O.O
.O.

O.O
.O.  repeat center
O.O

.O.
O.O  repeat grid
.O.

O.O
.O.  repeat grid
O.O
```

- A tagged tile will always and only be active on an odd or even step.
- We could paint the map odd/even and skip complex checks except at the frontier

```
...
.E.
...

.O.
OEO
.O.

EOE
OEO
EOE
```

- I was expected the rocks to mess more with the spread, but it seems to grow as an almost uniform diamond. Gaps are quickly filled in.
 - Print your grid with each step to observe this
- Need to account for rocks in the diamond
- Need to account for rocks causing blips in edge growth
- In the absence of rocks, count after `s` steps = `(s + 1)**2`
  - Assuming count 1 on step 0

- We could calculate where the edge will be at step `s` and do a little replay of recent growth to track which tiles are tagged
  - We reach the starting tile again to direct vert/horiz by multiples of the height/width
    - Grid height 123 => reach start above/below every 123 steps
    - Diagonals are width + height
    - My input 131 x 131, 131+131 = 262
    - **26501365 % 131 = 65**
    - **Start has 65 rows/cols above, left, right, below in grid**
      - Map out a fully filled grid
      - Map filling from each edge and corner
      - Do math to figure out how many full grids we filled in number of steps
        - And how many diagonals?