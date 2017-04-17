require 'pry'

num_of_tests = gets.chomp.to_i
tests = []
num_of_tests.times do
  tests.push(gets.chomp.to_i)
end

def decent_number(n)
  if n < 3
    "-1"
  # all 5s
  elsif n % 3 == 0
    "5" * n
  # one group of 3s
  elsif n - 5 > -1 && (n - 5) % 3 == 0
    ("5" * (n - 5)) + ("3" * 5)
  # two groups of 3s
elsif n - 10 > -1 && (n - 10) % 3 == 0
    ("5" * (n - 10)) + ("3" * 10)
  else
    "-1"
  end
end

tests.each do |t|
  puts decent_number(t)
end
