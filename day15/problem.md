# Day 15

## Part One

**HASH algorithm**

- Start with value `0`
- For each character starting from beginning:
  - Increase value by ASCII code of character
  - Multiply value by 17
  - Set value to value % 256

- Input is a comma-separated list of steps
- Map each step to its HASH algorithm output
- Sum
