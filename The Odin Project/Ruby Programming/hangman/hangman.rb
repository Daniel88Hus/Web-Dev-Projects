require 'yaml'

class Hangman
	def initialize
		puts %q{
			What would you like to do?
			1. New game
			2. Load game
		}
		input = gets.chomp
		if input == '1'
			start_game
		elsif input == '2'
			load_game
		else
			puts "Invalid input!"
			exit
		end
	end

	def start_game
		content = File.open('5desk.txt', 'r') { |file| file.read }
		word_list = content.split.select { |word| word.length.between?(5, 12) }
		@word = word_list[rand(word_list.size)].downcase.split('')
		@turns = 6 + (@word.length / 4)
		@displays = Board.new(@word)
		play
	end

	def load_game
		content = File.open('saved_game.yaml', 'r') { |file| file.read }
		hangman = YAML.load(content)
		hangman.play
	end

	def play
		while @turns > 0
			show_boards
			solicit_guess
			winner?
		end
		puts "You lost! The word was #{@word.join}"
	end

	def show_boards
		puts "Board #{@displays.board.join(' ') }"
		puts "Fails: #{@displays.fails.join(', ') }"
		puts "Guesses: #{@displays.guesses.join(', ')}"
		puts "Turns remaining: #{@turns}"
	end

	def solicit_guess
		puts %q{
			What would you like to do?
			1. Guess
			2. Save game and quit
		}
		input = gets.chomp
		if input == '1'
			process_guess
		elsif input == '2'
			save_game
		else
			puts "Invalid input!"
			solicit_guess
		end
	end

	def process_guess
		puts "Enter guess"
		guess = gets.chomp
		update_boards(guess)
	end

	def update_boards(guess)
		if @word.none? { |letter| letter == guess }
			@displays.fails << guess
			@turns -= 1
		else
			@word.each_with_index { |letter, index| @displays.board[index] = letter if letter == guess }
		end
		@displays.guesses << guess
	end

	def winner?
		if @displays.board.none? { |letter| letter == '_' }
			puts "You won! The word was #{@word.join}"
			exit
		end
	end

	def save_game
		name = 'saved_game.yaml'
		File.open(name, 'w') { |file| file.puts YAML.dump(self) }
		puts "Done!"
		exit
	end


	class Board
		attr_accessor :board, :fails, :guesses

		def initialize(word)
			@board = Array.new(word.length, '_')
			@fails = []
			@guesses = []
		end
	end
end

Hangman.new