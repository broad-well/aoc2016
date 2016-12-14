# Day 11 of Advent of Code, 2016
require 'set'
require 'thread'
require 'fiber'

$floors = [['pr-g', 'pr-m'], ['co-g', 'cu-g', 'ru-g', 'pl-g'],
           ['co-m', 'cu-m', 'ru-m', 'pl-m'], []]
#$floors = [['hy-m', 'li-m'], ['hy-g'], ['li-g'], []] if ARGV.include? 'use-example'
$elevator = 0

def pair_element(elem)
  elem[0..-2] + (elem.end_with?('-m') ? 'g' : 'm')
end

def validate_move_custom(move, custom_elev, custom_floors)
  # useful variables
  next_floor = custom_elev + (move[0] == 'u' ? 1 : -1)
  moving_elems = move.split('_')[1..-1]
  future_next_floor = custom_floors[next_floor] + moving_elems
  # criteria 0: microchip accessible to elevator for recharge
  return false unless future_next_floor.join.include?('-m')

  # criteria 1: no microchips in conflict when not attached to their generators
  # ab-m ab-g we-m
  return true unless future_next_floor.join.include? '-g' # no generators
#  trail = []
#  has_pairs = false
#  future_next_floor.each do |elem|
#    if trail.include? pair_element(elem)
#      has_pairs = true
#      trail.delete pair_element(elem)
#    else
#      trail << elem
#    end
#  end
#  return false if trail.map { |e| e.end_with?('m') }.include?(true) &&
#                  (has_pairs ||
#                   trail.map { |e| e.end_with?('g') }.include?(true))
#
#  return true
#
  # criteria 1 experimental
  future_next_floor.each do |elem|
    return false if elem.end_with?('-m') &&
                                   !future_next_floor.include?(pair_element(elem))
  end
  true
end

def validate_move(move)
  validate_move_custom(move, $elevator, $floors)
end

# action format: (u/d)_pr-g_pr-m (index of current floor to take)
def permutations_cond(floors, elevator)
  perm_take = floors[elevator].to_a.combination(2).to_a +
              floors[elevator].to_a.combination(1).to_a
  actions = []
  perm_take.each do |to_take|
    ud_stack = elevator.zero? ? 'u' : (if elevator == 3 then 'd' else 'ud' end)
    ud_stack.split('').each { |pre| actions << "#{pre}_#{to_take.join('_')}" }
  end
  # filter
  bad = []
  actions.each { |action| bad.push(action) unless
                 validate_move_custom(action, elevator, floors) }
  actions - bad
end

def act(action)
  toks = action.split('_')
  toks[1..-1].each { |elem| $floors[$elevator].delete(elem) }
  $elevator += (toks[0] == 'u' ? 1 : -1 )
  toks[1..-1].each { |elem| $floors[$elevator] << elem }
end

def virtual_act(elev, floors, action)
#  puts "virtual_act elev=#{elev} floors_orig=#{floors_orig} action=#{action}"
  toks = action.split '_'
  toks[1..-1].each { |elem| floors[elev].delete(elem) }
  elev += toks[0] == 'u' ? 1 : -1
  toks[1..-1].each { |elem| floors[elev] << elem }
#  puts "virtual_act end, elev=#{elev} floors=#{floors}"
  [elev, floors]
end

def reverse_act(action)
  new_act = action.dup
  new_act[0] = new_act[0] == 'u' ? 'd' : 'u'
  new_act
end

def done(floors)
  floors[0..2].join.empty?
end

if ARGV.length == 0
  puts 'Missing intelligence value'
  exit 1
end

$intelligence = ARGV[0].to_i
INTEL_DIV = 3
def internal_max(elev, floors, prev_act, level = 0)
  use_threads = level <= 1 && !ARGV.include?('flat')
  step_scores = {}
  ss_access = Mutex.new
  threads = [] if use_threads
  permts = permutations_cond(floors, elev)
#  puts "#{' '*level}level=#{level}, permts_len=#{permts.count}, elev=#{elev} floors=#{floors} prev=#{prev_act}"
  permts.delete reverse_act prev_act
  if permts.empty? || level > $intelligence
    score = $intelligence - level
    4.times { |i| score += floors[3 - i].count * (3 - i) * 5 }
    return score
  end
  return 100_000 - level * 100 if done floors
  return permts[0] if permts.count == 1 && level == 0
  permts.each do |action|
    new_elev, new_floors = virtual_act(elev, floors.map(&:dup), action)
    if use_threads
      threads << Thread.new do
        result = internal_max(new_elev,
                              new_floors, action, level + 1)
        ss_access.synchronize do
          step_scores[action] = result
          print "\e[2K#{Thread.current} done (#{step_scores.count}/#{permts.count}) lvl #{level}\r"
        end
      end
    else
      step_scores[action] = internal_max(new_elev,
                                         new_floors, action, level + 1)
    end
  end
  threads.each(&:join) if use_threads
  level.zero? ? step_scores.key(step_scores.values.max) : step_scores.values.max
end

class StateHash < Hash
  def initialize
    super
  end

  def [](state)
    method(:[]).super_method.call(state_tostr(state))
  end

  def []=(state, val)
    method(:[]=).super_method.call(state_tostr(state), val.to_i)
  end

  def include?(state)
    method(:include?).super_method.call(state_tostr(state))
  end

  def get(elev, floors)
    self[[elev, floors]]
  end

  private

  def state_tostr(state)
    floorstr = ''
    state[1].each do |floor|
      floorstr += floor.join('') + ','
    end
    state[0].to_s + floorstr[0..-2]
  end
end

def bfs # theoretical confidence
  queue = [[$elevator, $floors.map(&:dup).dup]]
  dist_prev = StateHash.new
  dist_prev[queue[0]] = 0

  loop do
    current_e, current_f = queue.pop
    current_d = dist_prev.get(current_e, current_f)
    return current_d if done current_f
    permutations_cond(current_f, current_e).each do |action|
      new_state = virtual_act(current_e, current_f.map(&:dup).dup, action)
      next if dist_prev.include?(new_state)
      dist_prev[new_state] = current_d + 1
      queue.insert(0, new_state)
      #print "queue.count=#{queue.count} dist_prev.count=#{dist_prev.count}"\
      #      " current_d=#{current_d}\r"
    end
  end
end

def max
  internal_max($elevator, $floors, 'u-NA')
end

puts bfs
