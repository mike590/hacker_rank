require 'pry'

n = gets.chomp.to_i
list = gets.chomp.split(" ").map(&:to_i)

mean = list.reduce(:+)/(n.to_f)

squared_dist = list.reduce(0) {|sum, x| sum += ((x-mean)**2)}



puts (squared_dist/n)**(0.5).round(1)
