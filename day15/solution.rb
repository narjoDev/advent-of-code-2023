ACTUAL = (File.read('input_actual.txt')) # .split(/\n/)

# Part One

def hash_value(str)
  str.each_char.reduce(0) do |value, char|
    ((value + char.ord) * 17) % 256
  end
end

def part_one(input)
  input.split(',').sum { |step| hash_value(step) }
end

# Part Two

def do_step(step, boxes)
  label, operator, focal = step.match(/(\w+)([-=])(\d*)/).captures
  focal = focal.to_i unless focal.empty?
  box_number = hash_value(label)
  lenses = boxes.fetch(box_number, [])

  if operator == '-'
    lenses.reject! { |lens| lens[0] == label }
  elsif operator == '='
    index = lenses.index { |lens| lens[0] == label }
    if index
      lenses[index][1] = focal
    else
      lenses << [label, focal]
    end
  end

  boxes[box_number] = lenses
  nil
end

def score_box(box_number, lenses)
  lenses.each_with_index.sum do |(_label, focal), lens_index|
    (box_number + 1) * (lens_index + 1) * focal
  end
end

def part_two(input)
  steps = input.split(',')
  boxes = {}
  steps.each { |step| do_step(step, boxes) }
  boxes.sum { |box| score_box(*box) }
end
