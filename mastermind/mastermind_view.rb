class MastermindView

  #Displays the board to the user
  #takes in an array of previous guesses
  #preconditions:
  # => parameter must be an array
  def display_board(guesses, hints, code = Array.new(4))
    raise ArgumentError, 'guesses must be an array' unless guesses.is_a?(Array)
    raise ArgumentError, 'hints must be an array' unless hints.is_a?(Array)
    puts "  =========      "
    print " | "
    print "#{code[0] || ' '} "
    print "#{code[1] || ' '} "
    print "#{code[2] || ' '} "
    print "#{code[3] || ' '} "
    puts "|Hints"
    puts " |=========|==== "
    12.times do |i|
      if guesses[11-i]
        print " | "
        print "#{guesses[11-i][0] || ' '} "
        print "#{guesses[11-i][1] || ' '} "
        print "#{guesses[11-i][2] || ' '} "
        print "#{guesses[11-i][3] || ' '} |"
        print "#{hints[11-i][0] || ' '}"
        print "#{hints[11-i][1] || ' '}"
        print "#{hints[11-i][2] || ' '}"
        print "#{hints[11-i][3] || ' '}|\n"
      else
        puts " |         |    |"
      end
      if i < 11
        puts " |---------|----|"
      else
        puts "  --------- ---- "
      end
    end
  end

  def display_start_screen
    puts ' __  __           _              __  __ _           _ '
    puts '|  \/  |         | |            |  \/  (_)         | |'
    puts '| \  / | __ _ ___| |_ ___ _ __  | \  / |_ _ __   __| |'
    puts '| |\/| |/ _` / __| __/ _ \ `__| | |\/| | | `_ \ / _` |'
    puts '| |  | | (_| \__ \ ||  __/ |    | |  | | | | | | (_| |'
    puts '|_|  |_|\__,_|___/\__\___|_|    |_|  |_|_|_| |_|\__,_|'
    puts 'press i for instructions'
    puts 'press enter to play'
  end

  def display_instructions
    puts "1. assign yourself a role. whether that be code maker or code breaker"
    puts "2. a sequence of colored pegs are chosen by the code maker"
    puts "   ->the colors are red, green, blue, yellow, pink, and orange"
    puts "   ->colors are selected by typing the first letter of the color that you wish to select"
    puts "   ->colors can be repeated, however colors cannot be left blank"
    puts "3. The code breaker has 12 attempts to guess the code"
    puts "   ->the code breaker types in the first letter of the 4 colors which they wish to play"
    puts "   eg. 'rgby' -> red, green, blue, yellow"
    puts "4. the code breaker is presented with data pegs to help them out."
    puts "   ->A black peg means they have guessed a correct color in a CORRECT position."
    puts "   ->A white peg means they have guessed a correct color in a WRONG position."
    puts "5. if the code breaker gets presented with all black pegs, the game is over and the code breaker has won"
    puts "   if all 12 guesses are used up, the game is over and the code maker has won"
    puts "Press enter to play"
  end

  def prompt_for_input
    puts "enter the first letter of the 4 colors you would like to pick. eg: 'rgby'"
    puts "RED, GREEN, BLUE, YELLOW, PINK, ORANGE"
  end

  def choose_play_style
    puts "What would you like to play as?"
    puts "[1] code breaker"
    puts "[2] code maker"
  end

  def end_game_options message
    puts "#{message}"
    puts "Play again? [Y]es [N]o"
  end

  def prompt_for_enter
    puts "Press 'Enter' to continue"
  end

  def clear_screen
    Gem.win_platform? ? (system "cls") : (system "clear")
  end
end