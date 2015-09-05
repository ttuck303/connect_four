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
	let(:col8) {%w{y y y y y y}}
	let(:blank_board) {[col0, col0, col0, col0, col0, col0, col0]}
	let(:draw_board) {[col8, col8, col8, col8, col8, col8, col8]}
	let(:horiz_board_t) {[col0, col1, col2, col3, col4, col5, col6]}
	let(:horiz_board_f) {[col0, col1, col2, col3, col4, col5, col7]}
	let(:vert_board_t) {horiz_board_f}
	let(:vert_board_f) {horiz_board_t}
	let(:diag_board_right_t) {[col0, col0, col2, col3, col4, col5, col0]}
	let(:diag_board_left_t) {[col0, col0, col5, col4, col3, col2, col0]} 
	let(:diag_board_f) {[col0, col5, col0, col5, col0, col5, col0]}


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
		it "returns a user-selected column (integer)" do
			connect_four_game.board = blank_board
			allow(connect_four_game).to receive(:gets).and_return(rand(0..5).to_s)
			expect(connect_four_game.select_column).to be_an_instance_of(Fixnum)
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
		it "returns true if there are 4-in-a-row of the same piece horizontally" do
			connect_four_game.board = horiz_board_t
			expect(connect_four_game.horizontal_win?).to be true
		end

		it "returns false if there are no 4-in-a-row combo's horizontally" do
			connect_four_game.board = horiz_board_f
			expect(connect_four_game.horizontal_win?).to be false
		end

	end

	describe "#vertical_win?" do
		it "returns true if there are 4-in-a-row of the same piece vertically" do
			connect_four_game.board = vert_board_t
			expect(connect_four_game.vertical_win?).to be true
		end

		it "returns false if there are no 4-in-a-row of the same piece vertically" do
			connect_four_game.board = vert_board_f
			expect(connect_four_game.vertical_win?).to be false
		end

	end

	describe "#diagonal_win?" do

		it "returns true if there are 4-in-a-row diagonally to the upper-right" do
			connect_four_game.board = diag_board_right_t
			expect(connect_four_game.diagonal_win?).to be true
		end

		it "returns true if there are 4-in-a-row diagonally to the upper-left" do
			connect_four_game.board = diag_board_left_t
			expect(connect_four_game.diagonal_win?).to be true
		end

			it "returns false if there are no diagonal win conditions" do
			connect_four_game.board = diag_board_f
			expect(connect_four_game.diagonal_win?).to be false
		end
		


	end

	describe "#winner?" do 
		it "returns true on a horizontal_win" do
			connect_four_game.board = horiz_board_t
			expect(connect_four_game.winner?).to be true
		end


		it "returns true on a vertical_win" do
			connect_four_game.board = vert_board_t
			expect(connect_four_game.winner?).to be true
		end

		it "returns true on a diagonal win"do
			connect_four_game.board = diag_board_right_t
			expect(connect_four_game.winner?).to be true
		end


		it "returns false if there is no winner yet" do
			connect_four_game.board = diag_board_f
			expect(connect_four_game.winner?).to be false
		end

	end

	describe "#valid_move?" do
		it "returns true if the player selects a column with vacancies" do
			connect_four_game.board = horiz_board_t
			expect(connect_four_game.valid_move?(rand(0..2))).to be true
		end

		it "returns false if the player selects a column with no vacancies" do
			connect_four_game.board = horiz_board_t
			expect(connect_four_game.valid_move?(rand(3..6))).to be false
		end

		it "returns false if the column is larger than the number of columns on the board" do
			connect_four_game.board = blank_board
			expect(connect_four_game.valid_move?(7)).to be false
		end

		it "returns false if the player enters anything other than a single numerical digit" do
			connect_four_game.board = blank_board
			expect(connect_four_game.valid_move?("string")).to be false
			expect(connect_four_game.valid_move?(['array'])).to be false
			expect(connect_four_game.valid_move?({:o => 'p'})).to be false	
		end

	end

	describe "#draw?" do
		it "returns true if all the spaces are taken and there is no winner yet" do
			connect_four_game.board = draw_board
			expect(connect_four_game.draw?).to be true
		end


		it "returns false if there are empty spaces" do 
			connect_four_game.board = blank_board
			expect(connect_four_game.draw?).to be false
		end
	end

	describe "#get_move" do 
		#maybe use context here - when active player is x, place x's, and when active player is o, place o's
		it "put a new piece in for the active player in the appropriate column"
	end

	describe "#board_maintenance" do
		it "will update the board"
	end

	describe "#print_board" do
		it "will print out a text representation of the board"
	end

	describe "#game_over?" do
		it "will check for game ending conditions"
	end

	describe "#switch_active_player" do
		it "will alternate the active player"
	end

	describe "#play_again_prompt" do
		it "will ask the player if they would like to play again"
	end



end



