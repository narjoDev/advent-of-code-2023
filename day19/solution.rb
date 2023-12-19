ACTUAL = (File.read('input_actual.txt'))

# Part One

def parse_input(input)
  workflows, parts = input.split("\n\n").map { |line| line.split("\n") }

  workflows = workflows.to_h do |line|
    name, rules = line.match(/(\w+){(.+)}/).captures
    rules = rules.split(',')
    [name, rules]
  end

  parts.map! do |line|
    line.delete('{}').split(',').to_h do |keyvalue|
      key, value = keyvalue.split('=')
      [key, value.to_i]
    end
  end

  [workflows, parts]
end

def workflow_accepts?(workflow_name, part, workflows)
  rules = workflows[workflow_name]
  rules.each do |rule|
    if rule.match?(':')
      regex = /([xmas])([<>])(\d+):(\w+)/
      key, operator, value, destination = rule.match(regex).captures
      value = value.to_i
      condition_met = operator == '<' ? part[key] < value : part[key] > value
      next unless condition_met
    else
      destination = rule
    end

    case destination
    when 'A' then return true
    when 'R' then return false
    else return workflow_accepts?(destination, part, workflows)
    end
  end
end

def accepted?(part, workflows)
  workflow_accepts?('in', part, workflows)
end

def part_one(input)
  workflows, parts = parse_input(input)
  accepted = parts.select { |part| accepted?(part, workflows) }
  accepted.sum { |part| part.values.sum }
end

# Part Two

def part_two(input)
  input
end
