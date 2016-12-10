# Day 10 of Advent of Code, 2016

$instructions = {}
$bothands = {}
$bins = {}

def place_bin(bin_index, num)
  $bins[bin_index] = [] unless $bins.include? bin_index
  $bins[bin_index] << num
end

def grip(bh_index, num, update = true)
  unless $bothands.include? bh_index
    $bothands[bh_index] = [num]
    return
  end
  if $bothands[bh_index].length == 2
    puts "\e[31mOVERFLOW: num #{bh_index}\e[0m"
    exit 1
  end
  $bothands[bh_index] << num
end

def parse_dest(target)
  # target = ['output', '3']
  targnum = target[1].to_i
  targnum = (targnum * -1) - 1 if target[0] == 'output'
  targnum
end

def redirect(targ, val)
  if targ < 0
    # output bound
    place_bin targ.abs - 1, val
  else
    grip targ, val, false
  end
end

def refresh_bots(instrs)
  instrs.each do |instr|
    release_do instr if instr >= 0 && $bothands[instr].length >= 2
  end
end

def schedule_release(bh_index, low_targ, high_targ)
  $instructions[bh_index] = [low_targ, high_targ]
end

def release_do(bh_index)
  return unless $bothands.include?(bh_index) && $bothands[bh_index].length == 2 &&
                $instructions.include?(bh_index)
  onpalm = $bothands[bh_index]
  if onpalm.sort == [17, 61]
    puts bh_index
  end
  redirect $instructions[bh_index][0], onpalm.min
  redirect $instructions[bh_index][1], onpalm.max
  refresh_bots $instructions[bh_index]
  $bothands[bh_index].clear
end

$grippings = {}

def parse_line(ln)
  if ln.start_with? 'v'
    # value xx goes to bot xx
    tokens = ln.split ' '
    grip tokens[5].to_i, tokens[1].to_i
  else
    # bot xxx gives low to (bot/output) xxx and high to bot xxx
    # output is negative, bot is positive
    tokens = ln.split ' '
    botnum = tokens[1].to_i
    lowdest = tokens[5..6]
    highdest = tokens[10..11]
    schedule_release botnum, parse_dest(lowdest), parse_dest(highdest)
  end
end

File.read(ARGV.length == 1 ? ARGV[0] : 'data/10.txt').each_line { |l| parse_line l.chomp }
$bothands.keys.each { |i| release_do i }
puts [$bins[0], $bins[1], $bins[2]].map(&:first).reduce(&:*)
