# frozen_string_literal: true

# This class contains all methods regarding playing the game
class Mastermind
  def play
    welcome
    player = Player.new
    player.make_a_guess
  end

  private

  def welcome
    puts 'Welcome to Mastermind game!!!'
    puts 'Rules:'
    puts '- There are two players: code,aker and codebreaker;'
    puts '- Codemaker creates a 4-digit code from either of 6 numbers (1-6)'
    puts '- Codebreaker tries to break this code in 12 attempts'
    puts '- After each attempt there is hint: x - in position and n - in code'
  end
end

# This class is about interaction of player and the game
class Player
  def make_a_guess
    puts 'Enter a four-digit code:'
    code = gets
    while code.length != 4 || !code.chars.all? { |digit| ('1'..'6').to_a.include?(digit) }
      puts 'I said 4 digits!!!'
      code = gets.chop
    end
  end
end

class Computer
end

mastermind = Mastermind.new
mastermind.play
