class Printer
	# Static class
	# Print info
	@@path_to_images = "../data/graphic"

	def self.status(true_letters, false_letters, letters, error_count)
		current_dir = File.dirname(__FILE__)
		path = "#{current_dir}/#{@@path_to_images}/#{error_count}.txt"

		graphic_str = File.read(path)
		
		output = ""
		output += "#{graphic_str}\n"
		output += " " * 2
		output += format_word(true_letters, letters)
		output += "\n"
		output += "Used letters: #{(true_letters + false_letters).join(" ")}"
		
	end

	def self.format_word(true_letters, letters)
		output = ""
		
		for letter in letters

			if true_letters.include? letter
				output += letter
			else
				output += "_"
			end

		end

		output

	end

	def self.win(error_count)
		output = ""
		output += "#{error_count} errors\n" if error_count != 0
		output += "You Win!" if error_count != 0

		output += "Flawless victory!" if error_count == 0
		
		output
	end

	def self.lose(letters)
		output = ""
		output += "That's be: #{letters.join ""}\n"
		output += "You Lose!"
		
		output
	end

end