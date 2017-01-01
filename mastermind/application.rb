require_relative "mastermind.rb"
require_relative "mastermind_view.rb"
require_relative "mastermind_cpu.rb"

class Application

	#creates the game and the view
	#by default the player is the code breaker
	def initialize
		@mm_view = MastermindView.new
		@cpu = MastermindCpu.new
		@code_breaker = true
	end

	#displays the start screen anp prompts the user for play options
	def startup
		user_input = " "
		@mm_view.clear_screen
		while user_input != ""
			@mm_view.display_start_screen
			user_input = gets.chomp
			@mm_view.clear_screen
			if user_input.downcase == "i"
				@mm_view.display_instructions
				gets
				user_input = ""
			end
		end
		@mm_view.choose_play_style
		user_input = gets.chomp.to_i
		@code_breaker = false if user_input == 2
		@code_breaker = true if user_input == 1
		breaker_loop if  @code_breaker
		maker_loop   if !@code_breaker
	end

	#if the player is playing as the code breaker, this method is to be executed
	private
	def breaker_loop
		@mm = Mastermind.new(@cpu.select_random_code) #cpu rival selects random code
		@mm_view.clear_screen
		while !@mm.game_over
			@mm_view.display_board(@mm.guesses, @mm.data_pegs)
			user_input = create_code
			@mm_view.clear_screen
			@mm.guess(user_input)
		end
		@mm_view.display_board(@mm.guesses, @mm.data_pegs, @mm.secret_code)
		end_game
	end

	#if the player is playing as the code maker, this method is to be executed
	def maker_loop
		@mm = Mastermind.new(create_code)
		@mm_view.clear_screen
		while !@mm.game_over
			@mm_view.display_board(@mm.guesses, @mm.data_pegs)
			@mm_view.prompt_for_enter
			gets
			cpu_input = @cpu.five_guess_algo(@mm.guess_number, @mm.data_pegs[-1])
			@mm_view.clear_screen
			@mm.guess(cpu_input)
		end
		@mm_view.display_board(@mm.guesses, @mm.data_pegs, @mm.secret_code)
		end_game
	end

	def create_code
		user_input = ""
		while(!valid_input?(user_input))
			@mm_view.prompt_for_input
			user_input = gets.chomp
		end
		user_input
	end

	def end_game
		if @mm.winner
			if @code_breaker
				@mm_view.end_game_options ("You won!")
			else
				@mm_view.end_game_options ("You lost!")
			end
		else
			if @code_breaker
				@mm_view.end_game_options ("You lost!")
			else
				@mm_view.end_game_options ("You won!")
			end
		end
		user_input = gets.chomp
		if user_input.downcase == 'y'
			startup
		end
		@mm_view.clear_screen
	end

	def valid_input?(input)
		unless (input.is_a? String) && input.length == 4
			return false
		end
		input.split("").each do |c|
			return false unless /[rgbypo]/.match c
		end
		return true
	end
end

Application.new.startup
