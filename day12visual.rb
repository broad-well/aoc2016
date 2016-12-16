# Day 12 of Advent Of Code, both parts, with visualization

$registers = {
  'a' => 0,
  'b' => 0,
  'c' => ARGV.include?('part2') ? 1 : 0,
  'd' => 0
}

def eval_val(val)
  val.match(/^\d+$/) == nil ? $registers[val] : val.to_i
end

puts
$input_lines = File.read('data/12.txt').split("\n")
$input_lines.length.times do |i|
  puts "  #{i+1} #{$input_lines[i]}"
end

def term_cursor_up(times)
  print "\e[#{times}A"
end
def term_cursor_down(times)
  print "\e[#{times}B"
end
def print_before_ln(content)
  print "\r#{content}"
end

# reset cursor to beginning of printed file
term_cursor_up($input_lines.length)

$exec_counter = 0

def execute
  print_before_ln(' ')
  ec_init = $exec_counter
  term_cursor_down(ec_init)

  print_before_ln('!')
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
  sleep 0.02
  print_before_ln(' ')

  term_cursor_up(ec_init)
end

while $exec_counter < $input_lines.length
  print "\e[?25l"
  execute
  term_cursor_up 1
  print "\e[2Ka=#{$registers['a']} b=#{$registers['b']} c=#{$registers['c']} d=#{$registers['d']}"
  term_cursor_down 1
  $exec_counter += 1
end

puts "Registers: #{$registers}"
print "\e[?25h"
