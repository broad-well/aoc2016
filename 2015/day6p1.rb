# Day 10 of Advent Of Code, 2015
# Created in 2016

$grid = Array.new(1000) { Array.new(1000, false) }

def manip(xy1, xy2, val_lambda)
  x1, y1 = xy1.split(',').map(&:to_i)
  x2, y2 = xy2.split(',').map(&:to_i)
  for x in [x1, x2].min..[x1, x2].max
    for y in [y1, y2].min..[y1, y2].max
      $grid[x][y] = val_lambda.call $grid[x][y]
    end
  end
end

def ton(xy1, xy2)
  manip xy1, xy2, ->(_) { true }
end

def toff(xy1, xy2)
  manip xy1, xy2, ->(_) { false }
end

def togg(xy1, xy2)
  manip xy1, xy2, ->(gridval) { !gridval }
end

def parse_line(ln)
  tokens = ln.split ' '
  case tokens[0]
  when 'turn'
    (tokens[1] == 'on' ? ton(tokens[2], tokens[4]) : toff(tokens[2], tokens[4]))
  when 'toggle'
    togg tokens[1], tokens[3]
  end
end

if ARGV.include? 'manual'
  parse_line ARGV[1]
else
  File.read('data6.txt').each_line do |ln|
    parse_line ln.delete("\n")
  end
end

puts "Lights lit: #{$grid.map{ |i| i.count true }.reduce(&:+)}"
