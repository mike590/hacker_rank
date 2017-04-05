require 'pry'

x = gets.chomp.to_i
test = gets.chomp.split(" ").map(&:to_i).sort

def q2(list)
    x = list.length
    if x % 2 == 1
        q2 = list[(x/2)]
    else
        q2 = (list[(x/2)] + list[((x/2)-1)])/2
    end
    q2
end

if x % 2 == 1
    l1 = test[0...(x/2)]
    l3 = test[((x/2)+1)..-1]
else
    l1 = test[0..((x/2)-1)]
    l3 = test[(x/2)..-1]
end
puts q2(l1)
puts q2(test)
puts q2(l3)
