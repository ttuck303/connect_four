class Connect_Four
	attr_accessor :board, :active_player

	def initialize
		@board  = new_board
		@active_player = 'x'
		game_loop
	end

	def new_board
		b = Array.new()
		7.times do 
			b << Array.new(6, '_')
		end
		return b
	end

	def select_column
		puts "Please select the column for your next piece by entering the column number [0-6]"
		selection = gets.strip.to_i #TODO BUG the to_i conversion will cast the input to 0 if its not a proper type
		puts "You selected #{selection}."
		selection
	end

	def column_has_vacancy?(col)
		col.include?("_")
	end

	def add_piece(col, player_sym)
		helper_column = @board[col]
		helper_column.reverse!
		idx = helper_column.find_index("_")
		helper_column[idx] = player_sym
		@board[col] = helper_column.reverse!
	end

	def horizontal_win?
		helper_board = @board.transpose
		helper_board.each do |row|
			row = row.join("")
			return true if row.include?("xxxx") || row.include?("oooo")
		end
		return false
	end

	def vertical_win?
		helper_board = @board
		helper_board.each do |row|
			row = row.join("")
			return true if row.include?("xxxx") || row.include?("oooo")
		end
		return false
	end

	def diagonal_win?
		diagonal_lower_right_win?(@board) || diagonal_lower_right_win?(@board.reverse)
	end

	def diagonal_lower_right_win?(helper_board)
		for i in (0..3)
			for j in (0..2)
				first = helper_board[i][j]
				second = helper_board[i+1][j+1]
				third = helper_board[i+2][j+2]
				fourth = helper_board[i+3][j+3]
				diag_up_left = first + second + third + fourth
				return true if diag_up_left.include?("xxxx") || diag_up_left.include?("oooo")
			end
		end
		return false
	end

	def winner?
		horizontal_win? || vertical_win? || diagonal_win?
	end

	def valid_move?(column)
		(column.is_a?(Fixnum)) && (0..6).include?(column) && column_has_vacancy?(@board[column])
	end

	def draw?
		@board.each do |row|
			return false if column_has_vacancy?(row)
		end
		return true
	end

	def get_move
		selection = select_column
		if valid_move?(selection)
			add_piece(selection, @active_player)
		else
			puts "Invalid selection, please try again."
			get_move
		end
	end

	def game_over?
		draw? || winner?
	end

	def print_board
		helper_board = @board.transpose
		helper_board.each do |row|
			row = row.join(" ")
			puts row
		end
		puts 
		puts "0 1 2 3 4 5 6   <-(Rows)"

	end

	def switch_active_player
		if @active_player == 'x'
			@active_player = 'o'
		else
			@active_player = 'x'
		end
		puts "Its now #{@active_player}'s turn!"
	end

	def play_again_prompt
		puts "Game over."
		puts "Would you like to play again? [y/n]"
		choice = gets.strip()
		Connect_Four.new if choice == 'y'
		puts "Thanks for playing!"
	end

	def game_loop
		puts "Welcome to connect four!"
		puts "Player #{@active_player} goes first."
		print_board
		loop do
			# get active player's move, make sure it is legal, and enter the piece onto the board
			get_move
			# print board
			print_board
			# check the board for a win or draw (if so break and declare why)
			break if game_over?
			# switch active player (prompt the next player)
			switch_active_player
			puts
			puts
			puts
		end
		draw? ? puts("Draw :|") : puts("Player #{@active_player} wins!")
		play_again_prompt
	end

end

g = Connect_Four.new
