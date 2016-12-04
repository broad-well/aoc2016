# Day 1 of Advent Of Code, 2015
# Created in 2016

FLOOR_OPS = {
  "(" => 1,
  ")" => -1
}

$input = File.read "data1.txt"
$floor = 0
$enum = 0

$input.chomp.each_char do |char|
  $floor += FLOOR_OPS[char]
  $enum += 1
  if $floor == -1
    puts "entered basement at #{$enum}"
  end
end

puts $floor
