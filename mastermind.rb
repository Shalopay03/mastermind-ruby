# frozen_string_literal: true

# This class contains all methods regarding playing the game
class Mastermind
  def play
    # Output welcome message and rules
    welcome

    # Create "players" objects
    player = Player.new
    computer = Computer.new

    # Generate code
    @secret_code = computer.generate_a_code

    # Loops for 12 tries
    number_of_tries = 12
    while number_of_tries.positive?
      puts "You have #{number_of_tries} more tries:"

      # Making a guess
      @current_guess = player.make_a_guess

      # Output codes and matches (mostly for debugging for now)
      puts "computer generated: #{@secret_code}"
      puts "player guess: #{@current_guess}"
      if check_number_matches == 4
        puts 'You won!!! congrats!!'
        return
      end
      number_of_tries -= 1
    end
    puts "You didn't make it! The code was #{@secret_code}"
  end

  private

  # Method for rules output
  def welcome
    puts 'Welcome to Mastermind game!!!'
    puts 'Rules:'
    puts '- There are two players: codemaker and codebreaker;'
    puts '- Codemaker creates a 4-digit code from either of 6 numbers (1-6)'
    puts '- Codebreaker tries to break this code in 12 attempts'
    puts '- After each attempt there is hint: x - in position and n - in code'
  end

  # Check and output number of digits matches
  def check_number_matches
    numbers_in_places = 0
    numbers_included = 0

    # Array for logging whether digit is exact match
    matches_log = [0, 0, 0, 0]

    # Searching exact matches
    4.times do |index|
      if @secret_code[index] == @current_guess[index]
        numbers_in_places += 1
        matches_log[index] = 1
      end
    end

    # Searching for numbers that are not in place but included in code
    4.times do |index|
      numbers_included += 1 if (matches_log[index]).zero? && @secret_code.chars.include?(@current_guess[index])
    end

    # Output of results
    puts "#{numbers_in_places} - in position"
    puts "#{numbers_included} - in code"
    numbers_in_places
  end
end

# This class is about interaction of player and the game
class Player
  # Method for inputting code guess from player
  def make_a_guess
    puts 'Enter a four-digit code:'
    code = gets.chop
    # Check for right input
    while code.length != 4 || !code.chars.all? { |digit| ('1'..'6').to_a.include?(digit) }
      puts 'I said 4 digits!!!'
      code = gets.chop
    end
    code
  end
end

# This class is about interaction of computer and the game
class Computer
  # Method generates a code from a computer
  def generate_a_code
    code = []
    4.times { code.push(rand(1..6).to_s) }
    code.join('')
  end
end

mastermind = Mastermind.new
mastermind.play

puts 'Wanna play again? (yes?)'
play_again = gets.chop.downcase
# Loop the game
while play_again == 'yes'
  mastermind.play
  puts 'Wanna play again? (yes?)'
  play_again = gets.chop.downcase
end
