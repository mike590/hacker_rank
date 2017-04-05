require 'pry'

num = gets.chomp
list = gets.chomp.split(" ").map(&:to_i).sort

if list.length% 2 == 0
  first = ((list.length)/2)-1
  median = ((list[first].to_f + list[first+1])/2).round(1)
else
  median = list[(list.length)/2]
end

counts = {}
sum = 0
@counter = 0
list.each do |x|
  @counter += 1
    sum += x
    counts[x] ||= 0
    counts[x] += 1
end

mean = sum.to_f/list.length

mode = nil
mode_count = 0
counts.each do |k,v|
    if v > mode_count || (v == mode_count && k < mode)
        mode = k
        mode_count = v
    end
end

puts mean
puts median
puts mode

binding.pry
puts 'fin'
