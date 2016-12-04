# Day 1 of Advent Of Code, 2016
INPUT = "L1, R3, R1, L5, L2, L5, R4, L2, R2, R2, L2, R1, L5, R3, L4, L1, L2, R3, R5, L2, R5, L1, R2, L5, R4, R2, R2, L1, L1, R1, L3, L1, R1, L3, R5, R3, R3, L4, R4, L2, L4, R1, R1, L193, R2, L1, R54, R1, L1, R71, L4, R3, R191, R3, R2, L4, R3, R2, L2, L4, L5, R4, R1, L2, L2, L3, L2, L1, R4, R1, R5, R3, L5, R3, R4, L2, R3, L1, L3, L3, L5, L1, L3, L3, L1, R3, L3, L2, R1, L3, L1, R5, R4, R3, R2, R3, L1, L2, R4, L3, R1, L1, L1, R5, R2, R4, R5, L1, L1, R1, L2, L4, R3, L1, L3, R5, R4, R3, R3, L2, R2, L1, R4, R2, L3, L4, L2, R2, R2, L4, R3, R5, L2, R2, R4, R5, L2, L3, L2, R5, L4, L2, R3, L5, R2, L1, R1, R3, R3, L5, L2, L2, R5"

begin
  $direction = 0
  $x = 0
  $y = 0
  $footprint = [[0, 0]]
  $intersection = nil
  # 0 => north, 1 => east, 2 => south, 3 => west

  WALK_FORMULA = [
    lambda {$y += 1},
    lambda {$x += 1},
    lambda {$y -= 1},
    lambda {$x -= 1}
  ]

  def walk(steps)
    steps.times do
      WALK_FORMULA[$direction].call
      if $footprint.include? [$x, $y] and $intersection == nil
        $intersection = [$x, $y]
        puts "heavy footprint! length is #{$footprint.length}"
      else
        $footprint.push([$x, $y])
      end
    end
  end

  def left
    $direction = ($direction + 3) % 4
  end

  def right
    $direction = ($direction + 1) % 4
  end

  INPUT.split(' ').each do |cmd|
    if cmd[0] == 'L' then left else right end
    walk cmd[1..-1].to_i
  end

  puts "blocks away: #{$x.abs + $y.abs}"
  puts "first intersection away: #{$intersection[0].abs + $intersection[1].abs}"
end
