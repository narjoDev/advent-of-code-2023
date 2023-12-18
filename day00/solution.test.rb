require_relative 'solution'
# require 'benchmark'

EXAMPLE_ONE = (File.read('example_one.txt')).split(/\n/)
EXAMPLE_TWO = (File.read('example_two.txt')).split(/\n/)

p part_one(EXAMPLE_ONE)
# p(part_one(ACTUAL).to_s == File.read('answer.txt').split(/\n/)[0])
