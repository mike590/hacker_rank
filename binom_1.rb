require 'pry'

num_of_boys = 3
num_of_kids = 6
prob = 1.09/2.09

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

res = []
4.times do
    res.push(binom_prob(num_of_boys, num_of_kids, prob))
    num_of_boys+=1
end

puts res.reduce(:+).round(3)
