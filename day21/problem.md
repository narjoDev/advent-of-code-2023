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
