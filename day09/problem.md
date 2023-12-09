# Day 9

## Part One

### Problem

- Input contains lines of numbers
- Each line contains the history of a value
- Our task is to:
  - analyze the pattern of changes in values
  - predict the next value for each line
  - return the sum of those extrapolated values

- The pattern of a history's values can be found by repeatedly processing...
  - the differences between values
  - the differences between those differences
  - ...
  - until you reach a level where all the differences are 0

### Examples

Extrapolating the next value in a single history:

```
0   3   6   9  12  15 => 18
  3   3   3   3   3 => 3
    0   0   0   0 => 0
```

- Notice that the next value in the primary sequence is the sum of the last values of all sequences.
  - (0 + 3 + 15 = 18)
- Notice each progressive sequence has one less element
  - Hopefully we won't reach an empty array before it is all zeroes

#### Possible Input

- Numbers in input can be negative (need to be able to scan for `-`)
- Differences can be negative

### Data Structures

- Arrays of Integers
- Nested array for sequences of differences

### Algorithm

- Each line of history can be processed separately
- Map each line to next value, then take sum
- The main problem in part one is generating difference sequences for extrapolation
  - A method to generate the next sequence would get us most of the way there

```
parse_input:
  takes as argument lines of input file  (array of strings)
  map lines: split by spaces and map to integers

differences_between:
  takes as argument a sequence (array of integers)
  for indices (1...size of input sequence) (non-inclusive) (there should be one less iteration than the size of the input)
    (map [1..] with index?)
    difference = sequence[index] - sequence[index - 1]
    add difference to accumulating array
  END
  return new array

extrapolate_next:
  takes as argument a single history  (array of integers)
  initialize sequences array containing history = [ history ]
  until last sub array of sequences array is all zeroes:
    sequences push differences_between(sequences.last)
  END WHILE
  return sum of last elements of sequences sub arrays

part_one main:
  parse input to histories array (parse_input)
  map histories to next values (extrapolate_next)
  sum
```

## Part Two

### Problem

- This time we need to extrapolate backwards, the previous value
- Still return sum of previous extrapolated values

### Examples

```
5 <= 10  13  16  21  30  45
  5 <=  3   3   5   9  15
   -2 <=  0   2   4   6
      2 <=  2   2   2
        0 <=  0   0
```

- Notice once we find all the sequences, we only care about the first values
- We do subtraction this time, but not exactly from the bottom up
  - It is from the bottom up, except we subtract the lower number from the upper number

```
2 - 0 => 2
0 - 2 => -2
3 - -2 => 5
10 - 5 => 5
```

### Algorithm

- We can keep the same way of finding difference sequences
- map sequences to their first values (gives us a non nested array of integers)

`[10, 3, 0, 2, 0]`

- Reduce backwards (reverse.reduce)

`[0, 2, 0, 3, 10].reduce`

element - memo



