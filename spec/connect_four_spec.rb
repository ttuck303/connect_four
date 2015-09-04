require_relative 'spec_helper'
require 'rspec'

describe Connect_Four do
	let(:connect_four_game) {Connect_Four.new}
	let(:col0) {%w{_ _ _ _ _ _}}
	let(:col1) {%w{_ _ _ _ _ x}}
	let(:col2) {%w{_ _ _ _ o x}}
	let(:col3) {%w{x o x o x o}}
	let(:col4) {%w{x x o o x o}}
	let(:col5) {%w{o o o x x x}}
	let(:col6) {%w{x o o o x o}}
	let(:col7) {%w{x x x x o o}}
	let(:horiz_board_t) {[col0, col1, col2, col3, col4, col5, col6]}
	let(:horiz_board_f) {[col0, col1, col2, col3, col4, col5, col7]}

	describe "#new" do
		it "returns an instance of a connect four game" do
			expect(connect_four_game).to be_an_instance_of(Connect_Four)
		end
	end

	describe "#new_board" do
		it "returns type array" do
			expect(connect_four_game.new_board).to be_an_instance_of(Array)
		end

		it "returns a new array with 7 columns" do
			expect(connect_four_game.new_board.size).to eql(7)
		end

		it "has 6 rows in each column" do
			expect(connect_four_game.new_board[0].size).to eql(6)
		end

		it "has an underscore in any given space" do
			expect(connect_four_game.new_board[rand(0..6)][rand(0..5)]).to eql('_')
		end
	end

	describe "#board" do
		it "returns type array" do
			expect(connect_four_game.board).to be_an_instance_of(Array)
		end

		it "contains 7 columns" do
			expect(connect_four_game.board.size).to eql 7
		end

		it "contains 6 spots per column" do
			expect(connect_four_game.board[rand(0..5)].size).to eql 6
		end
	end

	describe "#column_has_vacancy?" do
		it "returns true if there is vacancy" do
			expect(connect_four_game.column_has_vacancy?(["_"])).to be true
		end

		it "returns false if there is no vacancy" do
			expect(connect_four_game.column_has_vacancy?([5, 3, 4, 4, "foo"])).to be false
		end
	end

	describe "#select_column" do

		it "allows user to select a column" do
			allow(connect_four_game).to receive(:gets).and_return(rand(0..5).to_s)
			expect(connect_four_game.select_column).to be_an_instance_of(Array)
		end
	end

	describe "#add_piece" do

		it "puts a piece into the lowest available slot of a column" do
			expect(connect_four_game.add_piece(col0,'x')).to eql(col1)
		end

		it "puts a piece into the lowest available slot of a column" do
			expect(connect_four_game.add_piece(col1,'o')).to eql(col2)
		end

	end

	describe "#horizontal_win?" do
		it "return true if there are 4-in-a-row of the same piece horizontally" do
			connect_four_game.board = horiz_board_t
			expect(connect_four_game.horizontal_win?).to be true
		end

		it "returns false if there are no 4-in-a-row combo's horizontally" do
			connect_four_game.board = horiz_board_f
			expect(connect_four_game.horizontal_win?).to be false
		end

	end

	describe "#vertical_win?" do
		#check horizontal wins
	end

	describe "#diagonal_win?" do
		#check for diagonal wins
	end

	describe "#check_win" do 
		#check for wins
	end

	describe "#valid_move?" do
		#checks if a move is valid
	end

	describe "#get_move" do
		#gets player input for a move
	end

	describe "#save_game" do 
		# saves game
	end

	describe "#load_game" do
		# loads game 
	end

	## going to assume 2 players for now
	#describe "#set_number_of_human_players" do
	#	it "sets human players to 2" do
	#		connect_four_game.stub!(:gets)
	#		allow(connect_four_game.set_number_of_human_players).to receive(:gets){2}
	#		
	#	end
#
#		it "sets human players to 1" do
#			connect_four_game.set_number_of_human_players(1)
#			expect(game.players).to eql 1
#		end
#
#		it "throws error when more than 2 players" do
#			expect(connect_four_game.set_number_of_human_players(5)).to raise_error(TooManyPlayersError)
#		end
#
#		it "throws error when less than 1 player" do
#			expect(connect_four_game.set_number_of_human_players(0)).to raise_error(NotEnoughPlayersError)
#		end
#
#		it "rejects invalid input type for number of players" do
#			expect(connect_four_game.set_number_of_human_players("string")).to raise_error(WrongInputError)
#		end
#	end

end



