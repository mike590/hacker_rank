require 'pry'

num_of_rejects = 0
num_created = 10
prob = 0.12

def factorial(y)
  if y == 0
    1
  else
    (1..y).to_a.reduce(:*)
  end
end

def binom_prob(x, n, p)
  factorial(n)/(factorial(x)*factorial(n-x))*(p**x)*(1-p)**(n-x)
end

cumulative_chance = 0
3.times do
    cumulative_chance += binom_prob(num_of_rejects, num_created, prob)
    num_of_rejects+=1
end
puts cumulative_chance.round(3)

num_of_rejects = 2
cumulative_chance = 0
9.times do
    cumulative_chance += binom_prob(num_of_rejects, num_created, prob)
    num_of_rejects+=1
end

puts cumulative_chance.round(3)
