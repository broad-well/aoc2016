# Day 5 of Advent Of Code, 2016
INPUT = 'ojvtpuvg'

require 'digest'
require 'set'

part2 = ARGV.include? 'part2'
fast = ARGV.include? 'fast'

i = 0
$c = Set.new if part2
pwd = part2 ? '00000000' : ''
loop do
  md5 = Digest::MD5.hexdigest INPUT + i.to_s
  if !fast && i % 50 == 0 then print "Fresh MD5: #{md5}\r" end
  #print "#{INPUT + i.to_s} => #{md5}\r"
  if md5.start_with? '00000'
    if part2 && md5[5].to_i < 8 && md5[5].to_i.to_s == md5[5] && !$c.include?(md5[5].to_i)
      pwd[md5[5].to_i] = md5[6]
      puts "\e[2KPassword now: #{pwd}"
      if part2 then $c << md5[5].to_i end
    else
      unless part2
        pwd += md5[5]
        puts "\e[2KFound one! @ #{i}, md5=#{md5}"
      end
    end
  end
  break if part2 ? $c.length == 8 : pwd.length == 8
  i+=1
end

puts "\e[1mpassword: #{pwd}\e[0m"
