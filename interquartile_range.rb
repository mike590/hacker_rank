require 'pry'

eh = gets.chomp.to_i
inputs = gets.chomp.split(" ").map(&:to_i)
freq = gets.chomp.split(" ").map(&:to_i)

data = []

freq.each_with_index do |f, i|
  f.times do
    data.push(inputs[i])
  end
end

data.sort!

def q2(list)
    x = list.length
    if x % 2 == 1
        q2 = list[(x/2)]
    else
        q2 = (list[(x/2)] + list[((x/2)-1)])/2.0
    end
    q2
end

y = data.length

if y % 2 == 1
    l1 = data[0...(y/2)]
    l3 = data[((y/2)+1)..-1]
else
    l1 = data[0..((y/2)-1)]
    l3 = data[(y/2)..-1]
end

q1 = q2(l1)
q3 = q2(l3)

puts (q3 - q1).round(1)
