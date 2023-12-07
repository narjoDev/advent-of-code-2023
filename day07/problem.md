# Day 7: Camel Cards

## Part One

Implement `<=>`-like method

TYPES array of types from weakest to strongest
CARDS array weakest to strongest

returns -1, 0, 1
shouldn't ever be 0?
compare_hands(hand1, hand2)
  if type not equal <=> index in type power rank
  (0..)

## Part Two

There's got to be better way than trying every permutation

A joker would only ever make a hand better by changing into another card already in the hand

If I remove the jokers I can pattern match the rest of the hand to the best possibility

TWO PAIR AND HIGH CARD CAN'T HAPPEN WITH ANY JOKERS
if no jokers use normal method

/\d?/ => 5
'13' => 4
'22' => full
/11(1|2)/ => 3
'1111' => one


Number of Jokers
Highest other count
num_jokers + highest_other = max_group
still need to consider full house (if max < 4)

