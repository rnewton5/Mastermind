#The Computer oponent for mastermind
#utilizes the five guess algorithm minus the last step (otherwise the computer would always win)
#https://en.wikipedia.org/wiki/Mastermind_(board_game)#Five-guess_algorithm
class MastermindCpu

	def initialize
		@colors = ['r', 'g', 'b', 'y', 'p', 'o']
		@guess = ""
		@set = nil
	end

	#selects a random 4 color combination
	def select_random_code
		code = ""
		4.times { code += @colors.sample }
		return code
	end

	#uses the five guess algolrithm to attempt to beat the human code maker
	#params
	# => guess_num -> the number that this guess is on
	# => data_pegs -> the information provided from the last guess
	#preconditions: guess_num cannot be nil
	#               guess_num must be an integer that is between one and twelve inclusive
	#data_pegs should be a string of 4 characters include B, W, and ' '. eg: "BBW "
	#data_pegs can be nil
	def five_guess_algo(guess_num, data_pegs = "    ")
		raise ArgumentError, 'Invalid guess number' unless guess_num.is_a? Integer
		raise ArgumentError, 'Invalid guess number' unless (1..12).include? guess_num
		return if (data_pegs == "BBBB")
		#if this is the first guess, initilize the set and guess "rrgg"
		if guess_num == 1 
			initialize_set
			@guess = "rrgg"
		#if this is not the first guess, perform algorithmic black magic
		#which is to compare the entire set against the previous guess, and 
		#get rid of anything in the set that returns the same data pegs that 
		#the previous guess had returned
		else
			compare_set_against_data(data_pegs)
			@guess = @set.sample
		end
		return @guess.dup
	end



	private
		#initializes the set of all 1296 different possible code combinations
	def initialize_set
		@set = Array.new()
		(0000..5555).each do |i|
			gtg = true
			i.to_s.split('').each do |j|
				gtg = false if j.to_i > 5 || j.to_i < 0
			end
			if gtg
				str = ""
				i.to_s.rjust(4, "0").split('').each { |k| str += @colors[k.to_i] }
				@set.push(str)
			end
		end
	end

	#compares the set against the data_pegs and removes from @set any code that would not
	#  give the same result if the previous guess were the code
	def compare_set_against_data(data_pegs)
		@set.delete(@guess)
		@set.each do |x|
			sc = @guess.dup
			code = x.dup
			data = ""
			code.split("").each_with_index do |c, i|
				if (c == sc[i])
					data += 'B'
					code.slice!(i)
					code.insert(i, ' ')
					sc.slice!(i)
					sc.insert(i, '_')
				end
			end
			code.split("").each do |c|
				if (sc.include? c)
					data += 'W'
					index = sc.index(c)
					code.slice!(index)
					code.insert(index, ' ')
					sc.slice!(index)
					sc.insert(index, '_')
				end
			end
			if (data.ljust(4, " ") != data_pegs.ljust(4, " "))
				@set.delete(x)
			end
		end #@set.each
	end #compare_set_against_data

end #class