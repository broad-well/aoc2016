# Day 5 (part 2) of Advent Of Code, 2015
# Created in 2016

# Criterias

def pair_twice(str)
  (str.length - 1).times do |i|
    return true if str[i + 2..-1].include? str[i..i+1]
  end
  false
end

def between_repeat(str)
  (str.length - 2).times do |i|
    return true if str[i] == str[i + 2]
  end
  false
end

# Main routine
INPUT = ARGV.include?('manual') ? [ARGV[1]] : File.read('data5.txt').split("\n")
output = 0

INPUT.each do |string|
  output += 1 if between_repeat(string) && pair_twice(string)
end

puts "Nice strings: #{output}"
