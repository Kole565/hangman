require "rspec"

require_relative "../lib/gamemanager.rb"

describe "hangman game" do
	# Test for game overall

	it "should be CLASS" do
		
		expect(
			GameManager.new(:word =>"testing", :testing => true).class.name
		).to eq("GameManager")

	end
	
	it "should START_WITH_WORD" do
		
		game = GameManager.new(:word =>"testing", :testing => true)

		expect(
			game.class.name
		).to eq("GameManager")

		expect(
			game.letters
		).to eq("testing".split "")

	end

	it "should START_WITH_RANDOM_WORD" do
		
		game = GameManager.new(:file_name => "one_word", :testing => true)

		expect(
			game.letters
		).to eq("foo".split "")

	end

	it "should START_GAME" do
		
		game = GameManager.new(:file_name => "one_word", :testing => true)
		
	end

	it "should support WIN_GAME" do
		game = GameManager.new(:word => "testing", :testing => true)
		expect(
			game.game_state
		).to eq(0)

		# Step 1
		game.game_step("t")

		expect(
			game.game_state
		).to eq(0)

		expect(
			game.true_letters
		).to eq(["t"])

		# Step 2
		game.game_step("e")

		expect(
			game.game_state
		).to eq(0)

		expect(
			game.true_letters
		).to eq(["t", "e"])

		# Step 3
		game.game_step("s")

		expect(
			game.game_state
		).to eq(0)

		expect(
			game.true_letters
		).to eq(["t", "e", "s"])

		# Step 4 - same value as step 1
		game.game_step("t")

		expect(
			game.game_state
		).to eq(0)

		expect(
			game.error_count
		).to eq(0)

		expect(
			game.true_letters
		).to eq(["t", "e", "s"])

		# Step 5
		game.game_step("i")

		expect(
			game.game_state
		).to eq(0)

		expect(
			game.true_letters
		).to eq(["t", "e", "s", "i"])

		# Step 6
		game.game_step("n")

		expect(
			game.game_state
		).to eq(0)

		expect(
			game.true_letters
		).to eq(["t", "e", "s", "i", "n"])

		# Step 7
		game.game_step("g")

		expect(
			game.game_state
		).to eq(1)

		expect(
			game.error_count
		).to eq(0)

		expect(
			game.true_letters
		).to eq(["t", "e", "s", "i", "n", "g"])

		# Win
		expect(
			game.game_end(1).lines[-1]
		).to eq("Flawless victory!")
	end

	it "should support LOSE_GAME" do
		game = GameManager.new(:word => "testing", :testing => true)
		expect(
			game.game_state
		).to eq(0)

		# Step 1
		game.game_step("a")

		expect(
			game.game_state
		).to eq(0)

		expect(
			game.false_letters
		).to eq(["a"])

		expect(
			game.error_count
		).to eq(1)

		# Step 2
		game.game_step("b")

		expect(
			game.game_state
		).to eq(0)

		expect(
			game.false_letters
		).to eq(["a", "b"])

		expect(
			game.error_count
		).to eq(2)

		# Step 3
		game.game_step("c")

		expect(
			game.game_state
		).to eq(0)

		expect(
			game.false_letters
		).to eq(["a", "b", "c"])

		expect(
			game.error_count
		).to eq(3)

		# Step 4
		game.game_step("d")

		expect(
			game.game_state
		).to eq(0)

		expect(
			game.false_letters
		).to eq(["a", "b", "c", "d"])

		expect(
			game.error_count
		).to eq(4)

		# Step 5
		game.game_step("f")

		expect(
			game.game_state
		).to eq(0)

		expect(
			game.false_letters
		).to eq(["a", "b", "c", "d", "f"])

		expect(
			game.error_count
		).to eq(5)

		# Step 6
		game.game_step("k")

		expect(
			game.game_state
		).to eq(-1)

		expect(
			game.false_letters
		).to eq(["a", "b", "c", "d", "f", "k"])

		expect(
			game.error_count
		).to eq(6)

		# Lose
		expect(
			game.game_end(-1).lines[-1]
		).to eq("You Lose!")
	end

end