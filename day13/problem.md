# Day 13

## Part One

### Problem

```
patterns of ash and rocks
figure out where mirrors are
find a reflection
  across a horizontal line between rows
  or a vertical line between columns
count
  columns to the left of a vertical line of reflection
  rows above a horizontal line of reflection, multiplied by 100
```

### Examples

```
 ><
#..##
....#
####.
 ><

2 columns to left
```

- Notice the reflection line will always be between two identical rows or columns
  - Only check these points for full reflection

### Data Structures

- Raw input contains many patterns, `\n\n` separated
- Parse each pattern to an array of string lines
  - Could transpose pattern to check for vertical lines
    - Map strings to characters, transpose, join
      `array.map(&:chars).transpose.map(&:join)`

### Algorithm

- Split input into patterns
- Map each pattern to its score
  - Indentify candidate reflection points (or test all)
  - Test reflects?
- Sum

```
reflects?(pattern, index)
  slice up to not including index, slice rest, reverse
  account for different length!
  equal?

pattern_score(pattern array of strings)
  for each possible horiz reflection point (before indices 1...size)
    reclects_before?(pattern, index)
    if so return 100 * index
  test verts
    transpose
    test indices as above
    if so return index
```

## Part Two

- Each pattern needs to be changed
- Swap a single point to the opposite type
- There will only be one valid swap resulting in a reflection

- Split into patterns
- For each pattern...
  - Iterate across all characters
    - If swap results in score, return

```
smudge_score(pattern)
  each row index...
    each char index...
      dup, swap char, try
```

- **The original mirror may still be valid after the correct swap. Ignore it!**
- Need a way to prevent it finding the same line as in the original
  - require it be different???
  - pass forbidden value to scorer and skip that mirror line
