# Day 19

## Part One

```ruby
workflows = {
  'px' => [
    'a<2006:qkq',
    'm>2090:A',
    'rfg'
    ],
  'pv' => ...
}

parts = {
  {'x' => 787,
  'm' => 2655,
  'a' => 1222,
  's' => 2876},
  {
    ...
  }
}
```

## Part Two

### Problem

- We no longer care about specific parts
- We want to know how many combinations of ratings will be accepted by the workflows
- The four ratings (xmas) can range (1..4000)

### Data

- We will pass a meta part_range and partition it as rules affect part of it
- Start with `{'x' => (1..4000), 'm' => (1..4000), 'a' => (1..4000), 's' => (1..4000)}`

### Algorithm

- Helper takes rule and range, returns an array of ranges
- If a rule splits the range, recursively call again on each range partition
