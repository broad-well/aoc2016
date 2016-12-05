# Day 3 of Advent Of Code, 2015
# Created in 2016

$loc_now = [0, 0]
$present_delivered = [[0, 0]]
$houses_delivered = [[0, 0]]
# x, y

DIRECTIONS = {
  '^' => [1, 1],
  'v' => [1, -1],
  '<' => [0, -1],
  '>' => [0, 1]
}
INPUT = File.read('data3.txt')

INPUT.each_char do |char|
  if DIRECTIONS.include? char
    formula = DIRECTIONS[char]
    $loc_now[formula[0]] += formula[1]
    $present_delivered.push $loc_now.dup
    if not $houses_delivered.include? $loc_now
      $houses_delivered.push $loc_now.dup
    end
  end
end
puts "delivered to #{$houses_delivered.length} houses"
