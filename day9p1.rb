# Day 9 of Advent of Code, 2016

if ARGV.include? 'manual'
  INPUT = ARGV[1]
else
  INPUT = File.read('data/9.txt').delete("\n")
end

output = ''
char_count = 0
while char_count < INPUT.length do
  if INPUT[char_count] == '('
    subcount = char_count + 1
    subcount += 1 until INPUT[subcount] == ')'
    len, iter = INPUT[(char_count + 1)..subcount - 1].split('x').map(&:to_i)
    prose_repeat = INPUT[subcount+1..subcount+len]
    iter.times do
      output += prose_repeat
    end
    char_count = subcount + len + 1
  else
    output += INPUT[char_count]
    char_count += 1
  end
end

puts output.length
