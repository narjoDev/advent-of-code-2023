require_relative 'solution'

# p(recover_value('1abc2') == 12)
# p(recover_value('pqr3stu8vwx') == 38)
# p(recover_value('a1b2c3d4e5f') == 15)
# p(recover_value('treb7uchet') == 77)

# p(part_one(EXAMPLE_ONE) == 142)
p(part_one(ACTUAL) == 55386)

# p(recover_including_words('two1nine') == 29)
# p(recover_including_words('xtwone3four') == 24)
p(recover_including_words('z7onetwonec') == 71)

p(part_two(EXAMPLE_TWO) == 281)
p(part_two(ACTUAL) == 54824)
