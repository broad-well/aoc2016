# coding: utf-8
# Day 8 of Advent of Code, 2016

$screen_pixels = Array.new(6) { Array.new(50, false) }

def cmd_rect(args)
  # Syntax: rect 1x1 (example); first is width, second is height
  width, height = args[0].split('x').map(&:to_i)
  height.times do |y|
    width.times do |x|
      $screen_pixels[y][x] = true
    end
  end
end

def shift_right(array)
  array.unshift array.pop
end

def cmd_rotate(args)
  case args[0]
  when 'row'
  # rotate row y=0 by 2
    rownum = args[1][2].to_i
    args[3].to_i.times { shift_right $screen_pixels[rownum] }
  when 'column'
  # rotate column x=20 by 2
    current_value = []
    colnum = args[1][2..-1].to_i
    6.times do |i|
      current_value << $screen_pixels[i][colnum]
    end
    args[3].to_i.times { shift_right current_value }
    6.times do |i|
      $screen_pixels[i][colnum] = current_value[i]
    end
  else
    puts "warning: unknown rotate command: #{args}"
  end
end

def display
  $screen_pixels.each { |y| y.each { |x| print((x ? '█' : '·')) }; puts }
end

if ARGV.include?('manual')
  print('rect>')
  cmd_rect(STDIN.gets.chomp.split(' '))
  display
  print('rotate>')
  cmd_rotate(STDIN.gets.chomp.split(' '))
  display
  exit 0
end

INPUT = File.read('data/8.txt')
INPUT.each_line do |line|
  args = line.delete("\n").split(' ')
  case args[0]
  when 'rect'
    cmd_rect args[1..-1]
  when 'rotate'
    cmd_rotate args[1..-1]
  end
  next if ARGV.include? 'nolive'
  display
  print "\e[6A"
  if ARGV.include? 'slow'
    sleep 1.0/20
  end
end

total = 0
$screen_pixels.each do |row|
  row.each { |e| total += 1 if e }
end
display
puts "pixels on: #{total}"
