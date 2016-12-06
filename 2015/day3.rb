# Day 3 of Advent Of Code, 2015
# Created in 2016

$loc_now = [0, 0]
$robot_loc_now = [0, 0]
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

$is_robot = false
INPUT.each_char do |char|
  next unless DIRECTIONS.include? char
  formula = DIRECTIONS[char]
  ($is_robot ? $robot_loc_now : $loc_now)[formula[0]] += formula[1]
  $present_delivered.push(($is_robot ? $robot_loc_now : $loc_now).dup)
  $houses_delivered.push(($is_robot ? $robot_loc_now : $loc_now).dup) unless $houses_delivered.include?($is_robot ? $robot_loc_now : $loc_now)
  $is_robot = !$is_robot
end
puts "delivered to #{$houses_delivered.length} houses"
