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
		# transpose board
		helper_board = @board.transpose

		helper_board.each do |row|
			row = row.join("")
			return true if row.include?("xxxx") || row.include?("oooo")
		end
		return false
	end

end
