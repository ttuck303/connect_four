class Connect_Four
	attr_accessor :players, :board

	def initialize
		@players = 2
		@board  = self.new_board
	end

	def new_board
		b = Array.new()
		7.times do 
			b << Array.new(6, '_')
		end
		return b
	end

	def select_column
		col = gets.chomp.to_i
		#puts "Column #{col} selected..."
		return @board[col]
	end

	def column_has_vacancy?(col)
		col.include?("_")
	end

	def add_piece(col, player_sym)
		col.reverse!
		idx = col.find_index("_")
		col[idx] = player_sym
		col.reverse!
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
		return false unless column.is_a? Fixnum
		return false unless (0..6).include?(column)
		return false unless column_has_vacancy?(@board[column])
		return true
	end

end
