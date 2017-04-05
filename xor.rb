require 'pry'

# to_s with base 2 converts num to binary
x = gets.chomp.to_i
y = gets.chomp.to_i

max = 0
res = []
while x <= y
  c = x
  while c <= y
    temp_xor = x^c
    max = temp_xor if temp_xor > max
    res.push([x,c,temp_xor])
    c += 1
  end
  x += 1
end

puts max
