# Day 7 of Advent Of Code, 2016

INPUT = File.read('data/7.txt')
output = 0

def flip_it(str)
  side = str[0].dup
  mid = str[1].dup
  "#{mid}#{side}#{mid}"
end

def supports_ssl(line)
  hypernet_seq = []
  supernet_seq = ['']
  criteria = []

  in_brackets = false
  line.each_char do |char|
    if char == '['
      in_brackets = true
      hypernet_seq.push ''
      next
    end
    if char == ']'
      in_brackets = false
      supernet_seq.push ''
      next
    end
    if in_brackets
      hypernet_seq.last << char
    else
      supernet_seq.last << char
    end
  end

  supernet_seq.each do |seq|
    (seq.length - 2).times { |i|
      criteria.push flip_it(seq[i..i+2]) if seq[i] == seq[i+2] && seq[i] != seq[i+1]
    }
  end
  hypernet_seq.each do |seq|
    (seq.length - 2).times { |i|
      return true if criteria.include? seq[i..i+2]
    }
  end
  false
end

if ARGV.include? 'manual'
  p supports_ssl ARGV[1]
else
  INPUT.each_line { |l| output += 1 if supports_ssl l}
  puts "#{output} IPs support SSL"
end