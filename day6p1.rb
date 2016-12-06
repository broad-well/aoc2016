# Day 6 of Advent Of Code, 2016

INPUT = File.read("data/6.txt")

occurrence_position = Array.new(8, '')

INPUT.each_line do |line|
  8.times do |i|
    occurrence_position[i] += line[i]
  end
end

output = ''
8.times do |i|
  output += occurrence_position[i].split('').group_by(&:itself).values.max_by(&:size).first
end

puts "the message is #{output}"
