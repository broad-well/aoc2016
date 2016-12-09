# Day 9 of Advent of Code, 2016

if ARGV.include? 'manual'
  INPUT = ARGV[1]
else
  INPUT = File.read('data/9.txt').delete("\n")
end

def expand(str)
  out = 0
  count = 0
  while count < str.length do
    if str[count] == '('
      subcount = count + 1
      subcount += 1 until str[subcount] == ')'
      len, iter = str[(count + 1)..subcount - 1].split('x').map(&:to_i)
      prose_repeat_size = expand str[subcount+1..subcount+len]
      out += prose_repeat_size * iter
      count = subcount + len + 1
    else
      out += 1
      count += 1
    end
  end
  out
end

puts expand INPUT
