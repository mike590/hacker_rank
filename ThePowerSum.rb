require 'pry'

@sum = gets.chomp.to_i
@power = gets.chomp.to_i
@in_use = []
def find_sums(sum)
  answers = []
  upper_bound = (sum)**(1/@power.to_f)
  # if perfect root is found, add it to answers
  if upper_bound % 1 == 0 && upper_bound.to_i < (@in_use.last || sum)
    answers.push([upper_bound.to_i])
  end
  # round down
  upper_bound = upper_bound.to_i
  working_num = upper_bound
  while working_num > 0
    # dont repeat perfect root
    # dont re-use a number from a previous call
    # dont use a number larger than the last working number
    if working_num**@power != sum && working_num < (@in_use.last || sum)
      @in_use.push(working_num)
      temp = find_sums(sum-(working_num**@power))
      if !temp.empty?
        # temp should be a 2 dimension array, with each element being a list of
        # numbers that sum up to original sum after each has been raised to @power
        # Each is a possible solution, after adding in the working_num
        temp.each do |y|
          answers.push(y.unshift(working_num))
        end
      end
      @in_use.pop
    end
    working_num -=1
  end
  answers
end
test = find_sums(@sum)

puts test.length
