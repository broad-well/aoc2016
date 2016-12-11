# Day 11 of Advent of Code, 2016
require 'set'
$floors = [Set.new(['pr-g', 'pr-m']), Set.new(['co-g', 'cu-g', 'ru-g', 'pl-g']),
           Set.new(['co-m', 'cu-m', 'ru-m', 'pl-m']), Set.new]
$floors = [['hy-m', 'li-m'], ['hy-g'], ['li-g'], []]
$elevator = 0

def is_generator(str)
  str[-1] == 'g'
end

def validate_move(move, custom_elev = nil, custom_floors = nil)
  # useful variables
  next_floor = (custom_elev == nil ? $elevator : custom_elev) +
               (move[0] == 'u' ? 1 : -1)
  future_next_floor = (custom_floors == nil ? $floors[next_floor] :
                         custom_floors[next_floor]) + move.split('_')[1..-1]
  # criteria 0: microchip accessible to elevator for recharge
  return false unless future_next_floor.to_a.join.include?('-m')

  # criteria 1: no microchips in conflict when not attached to their generators
  # ab-m ab-g we-m tw-g
  hypo_nf = future_next_floor.dup.to_a
  hypo_del = []
  hypo_nf.length.times do |i|
    hypo_del += [hypo_nf[i], hypo_nf[i].sub('-m', '-g')] if
      hypo_nf[i].end_with?('-m') && hypo_nf.include?(hypo_nf[i].sub('-m', '-g'))
  end
  hypo_diff = hypo_nf - hypo_del
  hypo_diff_has_gen = false
  hypo_diff.each { |elem| hypo_diff_has_gen = true if elem.end_with?('-g') }
  hypo_diff.each { |elem| return false if elem.end_with?('-m') && hypo_diff_has_gen }

  true
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
                 validate_move(action, elevator, floors) }
  actions - bad
end

def act(action)
  toks = action.split('_')
  toks[1..-1].each { |elem| $floors[$elevator].delete(elem) }
  $elevator += (toks[0] == 'u' ? 1 : -1 )
  toks[1..-1].each { |elem| $floors[$elevator] << elem }
end

def virtual_act(elev, floors_orig, action)
  floors = floors_orig.dup
  toks = action.split '_'
  toks[1..-1].each { |elem| floors[elev].delete(elem) }
  elev += toks[0] == 'u' ? 1 : -1
  toks[1..-1].each { |elem| floors[elev] << elem }
  [elev, floors]
end

def reverse_act(action)
  new_act = action.dup
  new_act[0] = new_act[0] == 'u' ? 'd' : 'u'
  new_act
end

def internal_max(elev, floors, prev_act, external = false, level = 0)
  step_scores = {}
  permts = permutations_cond(floors, elev)
  puts "#{' '*level}level=#{level}, permts_len=#{permts.count}, elev=#{elev} floors=#{floors} prev=#{prev_act}"
  return -10_000 if level > 10
  permts.delete reverse_act prev_act
  return floors[3].count * 10 + 10 - level if permts.empty?
  permts.each do |action|
    new_elev, new_floors = virtual_act(elev, floors, action)
    step_scores[action] = internal_max(new_elev,
                                       new_floors.dup, action, false, level + 1)
  end
  external ? step_scores.key(step_scores.values.max) : step_scores.values.max
end

def max
  internal_max($elevator, $floors, 'u-NA', true)
end
max
