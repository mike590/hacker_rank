require 'pry'

let_to_num = {"A" => 1, "B" => 2, "C" => 3, "D" => 4}

games = []

num_of_games = gets.chomp.to_i
num_of_games.times do |i|
  piece_counts = gets.chomp.split(" ")
  temp_game = {limit: piece_counts[2].to_i, turn: :w, w: {}, b: {}, moves: []}
  piece_counts[0].to_i.times do
    arr = gets.chomp.split(" ")
    temp_game[:w][[let_to_num[arr[1]], arr[2].to_i]] = arr[0]
  end
  piece_counts[1].to_i.times do
    arr = gets.chomp.split(" ")
    temp_game[:b][[let_to_num[arr[1]], arr[2].to_i]] = arr[0]
  end
  games.push(temp_game)
end

@opp_turn = {w: :b, b: :w}

# combine bishop and rook for queen moves
def bishop_moves(x, y, game)
  own_spaces = game[game[:turn]].keys
  opponent_spaces = game[@opp_turn[game[:turn]]].keys
  moves = []
  # up right
  temp_x = x + 1
  temp_y = y + 1
  while temp_x < 5 && temp_y < 5 && !own_spaces.include?([temp_x, temp_y])
    moves.push([temp_x, temp_y])
    break if opponent_spaces.include?([temp_x, temp_y])
    temp_x += 1
    temp_y += 1
  end
  # up left
  temp_x = x - 1
  temp_y = y + 1
  while temp_x > 0 && temp_y < 5 && !own_spaces.include?([temp_x, temp_y])
    moves.push([temp_x, temp_y])
    break if opponent_spaces.include?([temp_x, temp_y])
    temp_x -= 1
    temp_y += 1
  end
  # down right
  temp_x = x + 1
  temp_y = y - 1
  while temp_x < 5 && temp_y > 0 && !own_spaces.include?([temp_x, temp_y])
    moves.push([temp_x, temp_y])
    break if opponent_spaces.include?([temp_x, temp_y])
    temp_x += 1
    temp_y -= 1
  end
  # down left
  temp_x = x - 1
  temp_y = y - 1
  while temp_x > 0 && temp_y > 0 && !own_spaces.include?([temp_x, temp_y])
    moves.push([temp_x, temp_y])
    break if opponent_spaces.include?([temp_x, temp_y])
    temp_x -= 1
    temp_y -= 1
  end
  moves
end

def rook_moves(x, y, game)
  own_spaces = game[game[:turn]].keys
  opponent_spaces = game[@opp_turn[game[:turn]]].keys
  moves = []
  # to the right
  temp_x = x + 1
  while temp_x < 5 && !own_spaces.include?([temp_x, y])
    moves.push([temp_x, y])
    break if opponent_spaces.include?([temp_x, y])
    temp_x += 1
  end
  # to the left
  temp_x = x - 1
  while temp_x > 0 && !own_spaces.include?([temp_x, y])
    moves.push([temp_x, y])
    break if opponent_spaces.include?([temp_x, y])
    temp_x -= 1
  end
  # down
  temp_y = y - 1
  while temp_y > 0 && !own_spaces.include?([x, temp_y])
    moves.push([x, temp_y])
    break if opponent_spaces.include?([x, temp_y])
    temp_y -= 1
  end
  # up
  temp_y = y + 1
  while temp_y < 5 && !own_spaces.include?([x, temp_y])
    moves.push([x, temp_y])
    break if opponent_spaces.include?([x, temp_y])
    temp_y += 1
  end
  moves
end

def knight_moves(x, y, game)
  moves = []
  if x + 2 < 5
    if y + 1 < 5
      moves.push([x+2, y+1])
    end
    if y - 1 > 0
      moves.push([x+2, y-1])
    end
  end
  if x - 2 > 0
    if y + 1 < 5
      moves.push([x-2, y+1])
    end
    if y - 1 > 0
      moves.push([x-2, y-1])
    end
  end
  if y + 2 < 5
    if x + 1 < 5
      moves.push([x+1, y+2])
    end
    if x - 1 > 0
      moves.push([x-1, y+2])
    end
  end
  if y - 2 > 0
    if x + 1 < 5
      moves.push([x+1, y-2])
    end
    if x - 1 > 0
      moves.push([x-1, y-2])
    end
  end
  # can't land on your own pieces
  own_spaces = game[game[:turn]].keys
  moves.select {|x| !own_spaces.include?(x)}
end

def find_moves(arr, game)
  moves =[arr[2], arr[0..1]]
  case arr[2]
  when "Q"
    moves.push(rook_moves(arr[0], arr[1], game) + bishop_moves(arr[0], arr[1], game))
  when "R"
    moves.push(rook_moves(arr[0], arr[1], game))
  when "B"
    moves.push(bishop_moves(arr[0], arr[1], game))
  when "N"
    moves.push(knight_moves(arr[0], arr[1], game))
  end
  # returns a 3 element array
  # first element, letter denoting piece type
  # second element, 2 element array with x and y position
  # third element, 2 dimensional array containing arrays of coordinates x,y of possible moves
  moves
end

# move will be in format of [type, start, end]
# e.g. ["N", [1,1], [2,3]]
def make_move(game, move, turn)
  new_game = game.clone
  # remove piece from the board
  new_game[turn].delete(move[1])
  # add it to the board in new position
  new_game[turn][move[2]] = move[0]
  # remove opponent's piece
  new_game[@opp_turn[turn]].delete(move[2])
  # a move has been made, decrement the limit, switch the turns
  new_game[:limit] -= 1
  new_game[:turn] = @opp_turn[turn]
  # record the move made
  new_game[:moves].push([turn, move])
  return new_game
end

def white_turn(game)
  if game[:limit] == 0
    return false
  end

  possible_moves = []
  game[:w].each do |pos, piece|
    possible_moves.push(find_moves([pos, piece].flatten, game))
  end

  # check to see if black queen can be taken
  victory = false
  game[:b].each do |pos, piece|
    if piece == "Q"
      possible_moves.each do |move_object|
        if move_object[2].include?(pos)
          victory = true
          break
        end
      end
      break if victory
    end
  end

  # if queen cannot be taken, go through the possible moves
  if !victory
    possible_moves.each do |move_object|
      move_object[2].each do |target_square|
        temp_game = make_move(game, [move_object[0], move_object[1], target_square], :w)
        victory = black_turn(temp_game)
        break if victory
      end
      break if victory
    end
  end
  return victory
end

def black_turn(game)
  if game[:limit] == 0
    # black queen cannot be taken
    return true
  end
  possible_moves = []
  game[:b].each do |pos, piece|
    possible_moves.push(find_moves([pos, piece].flatten, game))
  end

  survive = true
  possible_moves.each do |move_object|
    move_object[2].each do |target_square|
      temp_game = make_move(game, [move_object[0], move_object[1], target_square], :b)
      survive = !white_turn(temp_game)
      break if survive
    end
    break if survive
  end
  return !survive
end


games.each do |g|
  puts white_turn(g) ? "YES" : "NO"
end

binding.pry
puts 'fin'
