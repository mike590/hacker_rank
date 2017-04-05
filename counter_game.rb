require 'pry'

queries = gets.chomp.to_i
test_cases = []
queries.times do
  test_cases.push(gets.chomp.to_i)
end

@winners = [nil, "Richard", "Louise"]

def play_game(x)
  winner = 1
  while x != 1
    bin = x.to_s(2)
    # if its a power of 2, all digits past the first will be 0
    if !bin[1..-1].include?("1")
      x /= 2
    else
      x -= 2**(bin.length-1)
    end
    winner *= -1
  end
  puts @winners[winner]
end

test_cases.each do |t|
  play_game(t)
end
