# Day 12

## Part One

### Problem

- Rows of springs contains some damaged springs.
- We know some that are operational, some that are damaged, and some are unknown.
- We know the size of each contiguous group of damaged springs, in order.
- From the sizes, we can deduce the total number of damaged springs, but there could be multiple possibilities for how they are arranged.
- Figure out how many possible arrangements fit the criteria.

### Examples

```
. operational
# damaged
? unknown

#.#.### 1,1,3
???.### 1,1,3 => 1 possibility
```

### Data Structures

- Parse input into (for each row) (array of rows)
  - array of integers: sizes of contiguous groups
  - string: damaged record of conditions
- (for each row, to figure out possibilities)
  - 

### Algorithm

- The unknown can be either damaged or operational.
- Sum of sizes minus number known damaged equals number unknown that need to be turned into damaged
- Naive: create an array of unknowns, replace the appropriate number of elements with damaged, iterate over possible order permutations, count how many permutations create the correct sizes of contiguous groups
- (rather than checking all permutations, a smarter algorithm could do recursive backtracking shenanigans)
- Helpers: parse input, row_possibilities, correct_groups?

```
parse_input(line as string)
  row, sizes = split line by space
  sizes split by commas, convert to integers
  [row, sizes]

correct_groups?(row of knowns as string, sizes as array of integers)
  groups = split row by 1+ dots, eliminate empty strings
  map groups to sizes
  is equal to sizes?

row_possibilities(row with unknowns as string, sizes as array of integers)
  unknown = count in string
  total_damaged = sum of sizes
  known_damaged = count in string
  unknown_damaged = total_damaged - known_damaged
  unknown_operational = unknown - unknown_damaged

  unknown_indices = (0...row.size).select char is '?'
  possible_damages = unknown_indices combination(unknown_damaged)
  combinations count |ordering|
    try_row = dup
    replace indices of ordering with '#'
    replace rest of '?' with '.'
    correct_groups?

part_one(file as array of lines)
  map lines with parse_input
  map lines to possibilities
  sum

```

#### Rework / Avoid Permutations

- Use combination for N choose K (unknown choose unknown_damaged).
- Get indices of unknowns, choose K of them to make damaged.
