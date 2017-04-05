require 'pry'

puzzle = []
10.times do
  puzzle.push(gets.chomp.split)
end
words = gets.chomp.split(";")

words_by_length = {}
words.each do |w|
  words_by_length[w.length] ||= []
  words_by_length[w.length].push(w)
end

spaces = {}

10.times do |row|
  puzzle[i].each_with_index do |s, col|
    if s == "-"
      # we only care if its the first letter of the word
      # horizontally?
      if col == 0 || puzzle[row][col-1] != "-"
        # find the end of the word
        last_col = col + 1
        while puzzle[row][last_col] == "-"
          last_col = last_col + 1
        end
        spaces[[row, col]] = {length: last_col - col, collisions: []}
        # check for collisions
        
      end
      # vertically?
      if row == 0 || puzzle[row-1][col] != "-"
      end
    end
  end
end

# spaces = {
#   [0,3] => {length: 6, collisions: [
#     [[2,3],[2,0]]
#   ]},
#   [2,0] => {length: 5, collisions: [
#     [[2,3],[0,3]],
#     [[2,4],[1,4]]
#   ]},
#   [1,4] => {length: 4, collisions: [
#     [[2,4],[2,0]]
#   ]}
# }

binding.pry
puts "fin"
