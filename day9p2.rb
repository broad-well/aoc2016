# Day 9 of Advent of Code, 2016

if ARGV.include? 'manual'
  INPUT = ARGV[1]
else
  INPUT = File.read('data/9.txt').delete("\n")
end

def expand(str)
  out = ''
  count = 0
  while count < str.length do
    if str[count] == '('
      subcount = count + 1
      subcount += 1 until str[subcount] == ')'
      len, iter = str[(count + 1)..subcount - 1].split('x').map(&:to_i)
      prose_repeat = expand str[subcount+1..subcount+len]
      iter.times do
        out += prose_repeat
      end
      count = subcount + len + 1
    else
      out += str[count]
      count += 1
    end
  end
  out
end

puts expand INPUT
