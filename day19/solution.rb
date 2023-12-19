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

def parse_rule(rule)
  regex = /([xmas])([<>])(\d+):(\w+)/
  key, operator, value, destination = rule.match(regex).captures
  value = value.to_i
  [key, operator, value, destination]
end

def workflow_accepts?(workflow_name, part, workflows)
  rules = workflows[workflow_name]

  rules.each do |rule|
    if rule.match?(':')
      key, operator, value, destination = parse_rule(rule)
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

def combinations(part_range)
  part_range.values.map(&:size).reduce(:*)
end

def split_range(rule, part_range)
  key, operator, value, = parse_rule(rule)
  tested_range = part_range[key]
  lower_max = operator == '<' ? value - 1 : value
  upper_min = lower_max + 1

  if tested_range.max < upper_min || tested_range.min > lower_max
    [part_range]
  else
    lower = part_range.dup
    upper = part_range.dup
    lower[key] = (tested_range.min..lower_max)
    upper[key] = (upper_min..tested_range.max)
    [lower, upper]
  end
end

def get_destination(rule, part_range)
  key, operator, value, destination = parse_rule(rule)

  condition_met = case operator
                  when '<' then part_range[key].max < value
                  when '>' then part_range[key].min > value
                  end
  condition_met ? destination : nil
end

def count_accepted(workflow_name, part_range, workflows)
  rules = workflows[workflow_name]

  rules.each do |rule|
    if rule.match?(':') # there's a condition
      partitions = split_range(rule, part_range)
      if partitions.size == 1 # range wasn't split
        destination = get_destination(rule, part_range)
        next unless destination
      else # call again on each => they won't split on this rule
        return partitions.sum do |range|
                 count_accepted(workflow_name, range, workflows)
               end
      end
    else # no condition, set destination
      destination = rule
    end

    case destination
    when 'A' then return combinations(part_range)
    when 'R' then return 0
    else return count_accepted(destination, part_range, workflows)
    end
  end
end

def part_two(input)
  workflows = parse_input(input)[0]
  full_range = { 'x' => (1..4000), 'm' => (1..4000), 'a' => (1..4000),
                 's' => (1..4000) }
  count_accepted('in', full_range, workflows)
end
