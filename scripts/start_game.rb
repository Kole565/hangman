# Script to play

require_relative "../lib/gamemanager.rb"

puts "Want to use custom word? (if yes enter word, else press 'enter')"
word = STDIN.gets.encode("utf-8").chomp

if word != ""
	game = GameManager.new(:word => word)
else
	game = GameManager.new(:file_name => "words_for_script")
end

game.game_start