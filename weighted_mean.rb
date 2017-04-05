require 'pry'

num = gets.chomp
xs = gets.chomp.split(" ").map(&:to_f)
ws = gets.chomp.split(" ").map(&:to_f)

num = 0
den = 0

ws.each_with_index do |w, i|
  num += (w*xs[i])
  den += w
end

puts (num/den).round(1)
