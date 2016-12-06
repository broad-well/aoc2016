# Day 5 of Advent of Code, 2015
# Created in 2016

# Nice string criterias

VOWELS = 'aeiou'
def three_vowels?(str)
  counter = 0
  str.each_char { |char| counter += 1 if VOWELS.include? char }
  counter >= 3
end

def twice_in_a_row?(str)
  (str.length-1).times do |i|
    return true if str[i] == str[i+1]
  end
  false
end

BAD_SUBSTR = 'ab,cd,pq,xy'.split ','
def no_substring?(str)
  BAD_SUBSTR.each { |bad| return false if str.include? bad }
  true
end

# Nice string?
def nice?(str)
  no_substring?(str) && twice_in_a_row?(str) && three_vowels?(str)
end

INPUT = File.read('data5.txt')

c = 0
INPUT.each_line { |line| c += 1 if nice? line.gsub("\n", '') }

puts "Nice lines: #{c}"
