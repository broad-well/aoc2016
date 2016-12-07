# Day 7 of Advent Of Code, 2016

INPUT = File.read('data/7.txt')
output = 0

def supports_tls(line, verb=false)
  in_brackets = false
  brackets_passed = false
  pending_result = false
  (line.length - 3).times do |i|
    next if line[i] == "\n"
    if line[i] == '['
      puts "in_brackets = true, i=#{i}" if verb
      in_brackets = true
      next
    end
    if line[i] == ']'
      puts "in_brackets = false, brackets_passed = true, i=#{i}" if verb
      in_brackets = false
      brackets_passed = true
      next
    end
    if line[i] != line[i+1] && line[i..i+1].reverse == line[i+2..i+3]
      puts "pending_result = !in_brackets, i=#{i}" if verb
      return false if in_brackets
      pending_result = true
    end
  end
  puts "brackets_passed: #{brackets_passed}, pending_result: #{pending_result}" if verb
  brackets_passed && pending_result
end

if ARGV.include? 'manual'
  p supports_tls ARGV[1], true
else
  INPUT.each_line { |l| output += 1 if supports_tls l}
  puts "#{output} IPs support TLS"
end