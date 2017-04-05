require 'pry'

# q = gets.strip.to_i
test_cases = []
# q.times do
#     test_cases.push(gets.chomp.split(" ").map(&:to_i))
# end

# create master array
master = [0]
10000.times do |i|
  master.push((i+1)^master[i])
end

def xor_sequence(list)
  xor_sum = 0
  list.each do |x|
    xor_sum = xor_sum^x
  end
  puts "#{xor_sum}"
end

x = 11
while x <= 50
  test_cases.push([10, x])
  x += 1
end

test_cases.each_with_index do |y,i|
  # puts i
  xor_sequence(master[y[0]..y[1]])
end

puts 'fin'
