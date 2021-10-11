require_relative "../lib/printer.rb"

class GameManager
	# Handle game data
	# Set behavior, rules
	# Only for hangman

	def initialize(opts)
		@opts = opts

		if !opts[:word].nil?
			@word = opts[:word]
		else
			@word = get_file_word(opts[:file_name])
		end
		
		@true_letters = []
		@false_letters = []

		@error_count = 0

	end

	def opts
		@opts
	end


	def letters
		@word.split("")
	end

	def true_letters
		@true_letters
	end

	def true_letters_add(letter)
		@true_letters << letter
	end

	def false_letters
		@false_letters
	end

	def false_letters_add(letter)
		@false_letters << letter
	end


	def game_state
		check_game
	end

	def error_count
		@error_count
	end

	def error_count_inc
		@error_count += 1
	end


	def game_start
		Gem.win_platform? ? (system "cls") : (system "clear")
		puts Printer.status(true_letters, false_letters, letters, error_count)

		while game_state == 0
			puts game_step
		end

		puts game_end(game_state)

	end	

	def game_step(test_letter = "")
		
		if !opts[:testing]
			# Get letter from user
			letter = STDIN.gets.encode("utf-8").chomp.split("")[0] # Entered text first letter
		else
			# Or work like function
			letter = test_letter
		end

		case check_letter(letter)
		when -1
			error_count_inc
			false_letters_add(letter)
		when 1
			true_letters_add(letter)
		end

		Gem.win_platform? ? (system "cls") : (system "clear")
		Printer.status(true_letters, false_letters, letters, error_count)
	end

	def game_end(game_state)
		
		case game_state
		when -1
			return Printer.lose(letters)
		when 1
			return Printer.win(error_count)
		end
		
		exit if !opts[:testing]
	end
	

	def check_game
		# Return:
		# -1 - lose
		# 0 - game continue
		# 1 - win

		if letters.uniq.sort == true_letters.sort && error_count < 6
			return 1
		end

		if error_count < 6
			return 0
		else
			return -1
		end

	end
	
	def check_letter(letter)
		# Return:
		# -1 - when letter false and not used (+1 error)
		# 0 - when letter already used
		# 1 - when letter true and not used

		if (true_letters + false_letters).include? letter || letter == ""
			# Letter alredy used
			return 0
		elsif letters.include? letter
			# Letter true
			return 1
		else
			# Letter false
			return -1
		end

	end
	

	def get_file_word(file_name)
		current_dir = File.dirname(__FILE__)

		path = "#{current_dir}/../data/#{file_name}.txt"
		file_data = File.read(path)

		lines = file_data.split "\n"
		lines.sample
	end
	
end