# Day 4, part 1 of Advent Of Code 2015
# Created in 2016
require 'digest'
INPUT = 'ckczppom'

fast = ARGV.include? 'fast'
counter = 0
md5 = ''
while !md5.start_with?('00000')
  md5 = Digest::MD5.hexdigest INPUT + counter.to_s
  print "Newest MD5: #{md5}\r" if !fast && counter % 60 == 0
  counter += 1
end

puts "\e[2KAnswer: #{counter-1}"