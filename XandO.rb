class Game
    @@total_moves = 1
    @@winner = ''

    def initialize
        puts "Welcome to X and O, rules are as expected but you must enter your move by coordinates."
        puts "Each turn, enter two numbers with a space between, per the grid layout."
        puts "\r\n"
        puts "0 0 | 0 1 | 0 2"
        puts "---------------"
        puts "1 0 | 1 1 | 1 2"
        puts "---------------"
        puts "2 0 | 2 1 | 2 2"
        puts "\r\n"
        puts 'Player 1 - enter your name!'
        @p1_name = gets.chomp
        puts "\r"
        puts 'Player 2 - enter your name!'
        @p2_name = gets.chomp
        @board = Array.new(3) { Array.new(3, '_')}
    end

    def display_board(board)
        puts "\r"
        puts "#{board[0][0]} | #{board[0][1]} | #{board[0][2]}"
        puts "#{board[1][0]} | #{board[1][1]} | #{board[1][2]}"
        puts "#{board[2][0]} | #{board[2][1]} | #{board[2][2]}"
        puts "\r"
    end

    def player_turn(turn)
        if turn.odd?
            player_choice(@p1_name, 'X')
        else
            player_choice(@p2_name, 'O')
        end
    end

    def player_choice(player, symbol)
        puts "#{player} please enter your '#{symbol}' by using coordinates separated by a space"
        input = gets.chomp
        input_array = input.split
        coord1 = input_array[0].to_i
        coord2 = input_array[1].to_i

        until input.match(/\s/) && coord1.between?(0, 2) && coord2.between?(0, 2) && @board[coord1][coord2] == '_'
            puts "Please enter valid coordinates for an empty space on the board"
            input = gets.chomp
            input_array = input.split
            coord1 = input_array[0].to_i
            coord2 = input_array[1].to_i
        end

        add_to_board(coord1, coord2, symbol)
    end

    def add_to_board(coord1, coord2, symbol)
        @board[coord1][coord2] = symbol
        @@total_moves += 1
    end

    def three_across
        @board.each do |i|
            if i.all? { |j| j == 'X'}
                @@winner = 'X'
                @@total_moves = 10
            elsif i.all? { |j| j == 'O'}
                @@winner = 'O'
                @@total_moves = 10
            else
                nil
            end
        end
    end

    def three_down
        flat = @board.flatten
        flat.each_with_index do |v, i|
            if v == 'X' && flat[i + 3] == 'X' && flat[i + 6] == 'X'
                @@winner = 'X'
                @@total_moves = 10
            elsif v == 'O' && flat[i + 3] == 'O' && flat[i + 6] == 'O'
                @@winner = 'O'
                @@total_moves = 10
            else
                nil
            end
        end
    end

    def three_diagonal
        center_value = @board[1][1]
        if center_value == 'X' || center_value == 'O'
            if @board[0][0] == center_value && @board[2][2] == center_value
                @@winner = center_value
                @@total_moves = 10
            elsif @board[0][2] == center_value && @board[2][0] == center_value
                @@winner = center_value
                @@total_moves = 10
            else
                nil
            end
        else
            nil
        end
    end

    def declare_result(symbol)
        case symbol
        when 'X'
            puts "#{@p1_name} wins the game!"
        when 'O'
            puts "#{@p2_name} wins the game!"
        else
            puts "Its a tie!"
        end
    end

    def play_game
        puts "\r\n"
        puts "Here is your board!"
        display_board(@board)

        until @@total_moves >= 10 do
            player_turn(@@total_moves)
            three_across
            three_diagonal
            three_down
            display_board(@board)
        end

        declare_result(@@winner)
    end

end

game = Game.new
game.play_game
