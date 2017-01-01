=begin
  Mastermind is a game where a player creates a secret code
  and another player has 12 chances to guess that code.
  The code is defined as 4 different colored pegs. these pegs
  can be Red, Green, Blue, Yellow, Pink, or Orange.
  the guesser is presented with data as to how well their guess was.
  4 data pegs are presented; 
    white: the guesser guessed a right color but wrong location
    black: the guesser guessed a right color in a right location
=end
class Mastermind

  attr_reader :game_over, :secret_code, :guess_number, :data_pegs, :winner, :guesses

  def initialize(code)
    @secret_code = validate_input(code)
    @game_over = false
    @guess_number = 1
    @winner = false
    @data_pegs = Array.new
    @guesses = Array.new
  end

  #will return a string that is [0..4] characters in length that contains
  #the characters 'B' and 'W'
  #if the string is "BBBB" that means that the guesss was correct
  #parameters
  # => user_guess: a 4 character string that is made up of the characters r,g,b,y,p, and o
  #preconditions: user_guess must not be null and must be a valid 4 character guess
  #postconditions: the guess is added to the array of previous guesses
  # => @guess_number is incremented
  # => the black and white data string is added to the @data_pegs array
  # => if the guess is correct, @game_over is true and @winner is true
  # => if @guess_number is > 12, @game_over is true
  def guess(user_guess)
    if(!@game_over)
      user_guess = validate_input(user_guess)
      @guesses.push(user_guess.dup)
      sc = @secret_code.dup
      data = ""
      #search for correct colors in the correct spot
      user_guess.split("").each_with_index do |c, i|
        #if the letter is found in the secret code at the correct spot, add a 'B' to the 
        #data string and replace that letter in the user_guess and the secret_code duplication
        if (c == sc[i])
          data += 'B'
          sc.slice!(i)
          sc.insert(i, ' ')
          user_guess.slice!(i)
          user_guess.insert(i, '_')
        end
      end
      #search for correct colors in the wrong spot
      user_guess.split("").each do |c|
        #if the letter is found in the secret code at the wrong spot, add a 'W' to the 
        #data string and replace that letter in the user_guess and the secret_code duplication
        if (sc.include? c)
          data += 'W'
          index = sc.index(c)
          sc.slice!(index)
          sc.insert(index, ' ')
          user_guess.slice!(index)
          user_guess.insert(index, '_')
        end
      end
      @guess_number += 1
      @game_over = true if @guess_number > 12 || data == "BBBB"
      @winner = true if data == "BBBB"
      @data_pegs.push(('%-4.4s' % data))
      return data
    end
  end


  private
  def validate_input(input)
    if !input.is_a? String || input.length != 4
      raise ArgumentError, 'invalid input'
    end
    input.downcase!
    input.split("").each do |c|
      raise ArgumentError, 'invalid input' unless /[rgbypo]/.match c
    end
    return input
  end
end