require 'pry'

num_of_mis = gets.chomp.to_i
missiles = []
num_of_mis.times do
  missiles.push(gets.chomp.split(" ").map(&:to_i))
end
# sort by arrival time
missiles.sort_by {|x| x.first}
def_mis = []

protected = false
while !protected
  temp_attacks = missiles.clone
  temp_def = def_mis.clone
  temp_attacks.each_with_index do |att, i|
    defended = false
    temp_def.each do |defender|
      # if missile can defend
      if att[0] >= defender[:last_launch] && ((att[1] - defender[:freq]).magnitude <= att[0] - defender[:last_launch])
        defender[:freq] = att[1]
        defender[:last_launch] = att[0]
        defended = true
        break
      end
    end
    # if not defended, add a a defensive missile
    if !defended
      def_mis.push({last_launch: att[0], freq: att[1]})
      break
    end
    # win condition
    if defended && i == (temp_attacks.length-1)
      protected = true
    end
  end
end

puts def_mis.count
