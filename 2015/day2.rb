# Day 2 of Advent Of Code, 2015
# Created in 2016

class Present
  def initialize(x,y,z)
    @x = x
    @y = y
    @z = z
    @sa = [x*y, x*z, y*z]
    @wls = [x+y, x+z, y+z]
  end

  def surface_area
    return @sa.inject(0){ |sum, x| sum+x }*2
  end

  def volume
    return @x*@y*@z
  end

  def area_small
    return @sa.min
  end

  def wraplength
    return @wls[@sa.index(@sa.min)]*2
  end
end

INPUT = File.read('data2.txt')
sum_paper_required = 0
sum_ribbon_required = 0

INPUT.split("\n").each do |present|
  dimensions = present.split("x").map { |e| e.to_i }
  prez = Present.new(*dimensions)
  sum_paper_required += prez.surface_area + prez.area_small
  sum_ribbon_required += prez.wraplength + prez.volume
end

puts "paper required: #{sum_paper_required}"
puts "ribbon required: #{sum_ribbon_required}"
