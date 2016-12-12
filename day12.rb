# Day 12 of Advent Of Code, both parts

$registers = {
  'a' => 0,
  'b' => 0,
  'c' => ARGV.include?('part2') ? 1 : 0,
  'd' => 0
}

def eval_val(val)
  val.match(/^\d+$/) == nil ? $registers[val] : val.to_i
end

$input_lines = File.read('data/12.txt').split("\n")
$exec_counter = 0

def execute
  toks = $input_lines[$exec_counter].split ' '
  case toks[0]
  when 'cpy'
    $registers[toks[2]] = eval_val(toks[1])
  when 'inc'
    $registers[toks[1]] += 1
  when 'dec'
    $registers[toks[1]] -= 1
  when 'jnz'
    $exec_counter += toks[2].to_i - 1 if eval_val(toks[1]) != 0
  end
end

while $exec_counter < $input_lines.length
  execute
  $exec_counter += 1
end

puts "Registers: #{$registers}"
